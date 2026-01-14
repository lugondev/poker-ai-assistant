import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/ai_models.dart';

/// Abstract AI service interface
abstract class AiService {
  /// Stream completion response
  Stream<AiCompletionChunk> streamCompletion(AiCompletionRequest request);

  /// Get single completion (non-streaming)
  Future<String> getCompletion(AiCompletionRequest request);

  /// Check if service is configured
  bool get isConfigured;

  /// Get provider name
  String get providerName;
}

/// OpenAI API implementation
class OpenAiService implements AiService {
  final AiConfig config;
  final http.Client _client;

  OpenAiService({required this.config, http.Client? client})
    : _client = client ?? http.Client();

  @override
  bool get isConfigured => config.apiKey.isNotEmpty;

  @override
  String get providerName => 'OpenAI';

  @override
  Stream<AiCompletionChunk> streamCompletion(
    AiCompletionRequest request,
  ) async* {
    if (!isConfigured) {
      yield const AiCompletionChunk(
        content: '',
        isDone: true,
        error: 'API key not configured',
      );
      return;
    }

    final model = request.model.isNotEmpty ? request.model : config.model;
    final effectiveModel = model.isNotEmpty ? model : 'gpt-4o-mini';

    final body = jsonEncode({
      'model': effectiveModel,
      'messages': request.messages
          .map((m) => {'role': m.role, 'content': m.content})
          .toList(),
      'temperature': request.temperature,
      'max_tokens': request.maxTokens,
      'stream': true,
    });

    try {
      final httpRequest = http.Request(
        'POST',
        Uri.parse('${config.baseUrl}/chat/completions'),
      );
      httpRequest.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${config.apiKey}',
      });
      httpRequest.body = body;

      final response = await _client.send(httpRequest);

      if (response.statusCode != 200) {
        final errorBody = await response.stream.bytesToString();
        yield AiCompletionChunk(
          content: '',
          isDone: true,
          error: 'API Error ${response.statusCode}: $errorBody',
        );
        return;
      }

      // Process SSE stream
      await for (final chunk
          in response.stream
              .transform(utf8.decoder)
              .transform(const LineSplitter())) {
        if (chunk.isEmpty) continue;
        if (!chunk.startsWith('data: ')) continue;

        final data = chunk.substring(6);
        if (data == '[DONE]') {
          yield const AiCompletionChunk(content: '', isDone: true);
          return;
        }

        try {
          final json = jsonDecode(data) as Map<String, dynamic>;
          final choices = json['choices'] as List?;
          if (choices != null && choices.isNotEmpty) {
            final delta = choices[0]['delta'] as Map<String, dynamic>?;
            final content = delta?['content'] as String? ?? '';
            if (content.isNotEmpty) {
              yield AiCompletionChunk(content: content, isDone: false);
            }
          }
        } catch (e) {
          // Skip malformed chunks
        }
      }

      yield const AiCompletionChunk(content: '', isDone: true);
    } catch (e) {
      yield AiCompletionChunk(
        content: '',
        isDone: true,
        error: 'Connection error: $e',
      );
    }
  }

  @override
  Future<String> getCompletion(AiCompletionRequest request) async {
    final buffer = StringBuffer();
    await for (final chunk in streamCompletion(request)) {
      if (chunk.error != null) {
        throw Exception(chunk.error);
      }
      buffer.write(chunk.content);
    }
    return buffer.toString();
  }
}

/// Anthropic Claude API implementation
class AnthropicService implements AiService {
  final AiConfig config;
  final http.Client _client;

  AnthropicService({required this.config, http.Client? client})
    : _client = client ?? http.Client();

  @override
  bool get isConfigured => config.apiKey.isNotEmpty;

  @override
  String get providerName => 'Anthropic';

  @override
  Stream<AiCompletionChunk> streamCompletion(
    AiCompletionRequest request,
  ) async* {
    if (!isConfigured) {
      yield const AiCompletionChunk(
        content: '',
        isDone: true,
        error: 'API key not configured',
      );
      return;
    }

    final model = request.model.isNotEmpty ? request.model : config.model;
    final effectiveModel = model.isNotEmpty ? model : 'claude-3-haiku-20240307';

    // Extract system message
    String? systemPrompt;
    final messages = <Map<String, String>>[];

    for (final msg in request.messages) {
      if (msg.role == 'system') {
        systemPrompt = msg.content;
      } else {
        messages.add({'role': msg.role, 'content': msg.content});
      }
    }

    final bodyMap = <String, dynamic>{
      'model': effectiveModel,
      'messages': messages,
      'max_tokens': request.maxTokens,
      'stream': true,
    };

    if (systemPrompt != null) {
      bodyMap['system'] = systemPrompt;
    }

    final body = jsonEncode(bodyMap);
    final baseUrl = config.baseUrl.isNotEmpty
        ? config.baseUrl
        : 'https://api.anthropic.com/v1';

    try {
      final httpRequest = http.Request('POST', Uri.parse('$baseUrl/messages'));
      httpRequest.headers.addAll({
        'Content-Type': 'application/json',
        'x-api-key': config.apiKey,
        'anthropic-version': '2023-06-01',
      });
      httpRequest.body = body;

      final response = await _client.send(httpRequest);

      if (response.statusCode != 200) {
        final errorBody = await response.stream.bytesToString();
        yield AiCompletionChunk(
          content: '',
          isDone: true,
          error: 'API Error ${response.statusCode}: $errorBody',
        );
        return;
      }

      // Process SSE stream
      await for (final chunk
          in response.stream
              .transform(utf8.decoder)
              .transform(const LineSplitter())) {
        if (chunk.isEmpty) continue;
        if (!chunk.startsWith('data: ')) continue;

        final data = chunk.substring(6);

        try {
          final json = jsonDecode(data) as Map<String, dynamic>;
          final type = json['type'] as String?;

          if (type == 'content_block_delta') {
            final delta = json['delta'] as Map<String, dynamic>?;
            final text = delta?['text'] as String? ?? '';
            if (text.isNotEmpty) {
              yield AiCompletionChunk(content: text, isDone: false);
            }
          } else if (type == 'message_stop') {
            yield const AiCompletionChunk(content: '', isDone: true);
            return;
          }
        } catch (e) {
          // Skip malformed chunks
        }
      }

      yield const AiCompletionChunk(content: '', isDone: true);
    } catch (e) {
      yield AiCompletionChunk(
        content: '',
        isDone: true,
        error: 'Connection error: $e',
      );
    }
  }

  @override
  Future<String> getCompletion(AiCompletionRequest request) async {
    final buffer = StringBuffer();
    await for (final chunk in streamCompletion(request)) {
      if (chunk.error != null) {
        throw Exception(chunk.error);
      }
      buffer.write(chunk.content);
    }
    return buffer.toString();
  }
}

/// Mock AI service for testing/demo
class MockAiService implements AiService {
  @override
  bool get isConfigured => true;

  @override
  String get providerName => 'Mock';

  @override
  Stream<AiCompletionChunk> streamCompletion(
    AiCompletionRequest request,
  ) async* {
    final userMessage = request.messages
        .lastWhere(
          (m) => m.role == 'user',
          orElse: () => const AiMessage(role: 'user', content: ''),
        )
        .content;

    final response = _getMockResponse(userMessage);
    final words = response.split(' ');

    for (int i = 0; i < words.length; i++) {
      await Future.delayed(Duration(milliseconds: 20 + (i % 3) * 15));
      final content = (i == 0 ? '' : ' ') + words[i];
      yield AiCompletionChunk(content: content, isDone: false);
    }

    yield const AiCompletionChunk(content: '', isDone: true);
  }

  @override
  Future<String> getCompletion(AiCompletionRequest request) async {
    final buffer = StringBuffer();
    await for (final chunk in streamCompletion(request)) {
      buffer.write(chunk.content);
    }
    return buffer.toString();
  }

  String _getMockResponse(String message) {
    final lower = message.toLowerCase();

    if (lower.contains('equity') || lower.contains('odds')) {
      return "Based on your current hand, I can help analyze your equity. "
          "To give you accurate odds, make sure you've set your hole cards and any community cards. "
          "Your pot odds will determine whether a call is profitable in the long run. "
          "If your equity exceeds the pot odds, you have a profitable call.";
    }

    if (lower.contains('call') || lower.contains('should i')) {
      return "To decide whether to call, consider these factors:\n\n"
          "• Your pot odds vs your equity\n"
          "• Your position at the table\n"
          "• Stack sizes and implied odds\n"
          "• Your opponent's likely range\n\n"
          "If your equity exceeds the required equity to call, it's generally profitable to continue.";
    }

    if (lower.contains('bet') || lower.contains('raise')) {
      return "When considering bet sizing, think about:\n\n"
          "• Value betting: Bet larger when you have strong hands\n"
          "• Bluffing: Size your bluffs similar to value bets\n"
          "• Board texture: Wet boards often warrant larger bets\n\n"
          "A common approach is betting 50-75% of the pot for value on most boards.";
    }

    if (lower.contains('hand') || lower.contains('play')) {
      return "I can see your hand setup in the calculator. "
          "Strong starting hands like A♠ A♥, K♠ K♥, Q♠ Q♥, A♠ K♠ should generally be played aggressively preflop. "
          "Position matters too - you can play more hands from late position like the button or cutoff.";
    }

    if (lower.contains('range')) {
      return "Hand ranges are crucial for poker strategy. Consider:\n\n"
          "• Opening ranges vary by position (tighter UTG, wider BTN)\n"
          "• 3-bet ranges should be polarized or linear depending on opponent\n"
          "• Call ranges depend on pot odds and implied odds\n\n"
          "Use the range selector to assign opponent ranges for more accurate equity calculations.";
    }

    if (lower.contains('position')) {
      return "Position is one of the most important concepts in poker:\n\n"
          "• Early position (UTG): Play tight, premium hands only\n"
          "• Middle position: Slightly wider range\n"
          "• Late position (CO, BTN): Much wider range, more stealing opportunities\n"
          "• Blinds: Defend appropriately based on pot odds\n\n"
          "Being in position gives you more information and control over the pot size.";
    }

    if (lower.contains('help') || lower.contains('how')) {
      return "I'm your AI poker assistant! I can help you with:\n\n"
          "• Analyzing your hand equity\n"
          "• Decision making (call, fold, raise)\n"
          "• Understanding pot odds\n"
          "• Bet sizing strategies\n"
          "• Reading opponent ranges\n\n"
          "Just ask me anything about your current hand situation!";
    }

    // Default response with context awareness
    return "I understand you're asking about \"$message\". "
        "I'm here to help with your poker decisions. "
        "You can ask me about your equity, whether to call or fold, bet sizing, "
        "or any other aspect of your current hand. "
        "The quick actions below provide common questions based on your current situation!";
  }
}

/// Factory to create appropriate AI service
class AiServiceFactory {
  static AiService create(AiConfig config) {
    return switch (config.provider) {
      AiProvider.openai => OpenAiService(config: config),
      AiProvider.anthropic => AnthropicService(config: config),
      AiProvider.mock => MockAiService(),
    };
  }

  /// Create with API key only (uses default OpenAI config)
  static AiService createOpenAi(String apiKey) {
    return OpenAiService(
      config: AiConfig(
        provider: AiProvider.openai,
        apiKey: apiKey,
        model: 'gpt-4o-mini',
      ),
    );
  }

  /// Create with API key only (uses default Anthropic config)
  static AiService createAnthropic(String apiKey) {
    return AnthropicService(
      config: AiConfig(
        provider: AiProvider.anthropic,
        apiKey: apiKey,
        model: 'claude-3-haiku-20240307',
        baseUrl: 'https://api.anthropic.com/v1',
      ),
    );
  }

  /// Create mock service for testing
  static AiService createMock() => MockAiService();
}
