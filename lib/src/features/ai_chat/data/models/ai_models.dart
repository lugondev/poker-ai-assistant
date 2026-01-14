/// AI Service configuration and models
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_models.freezed.dart';
part 'ai_models.g.dart';

/// AI Provider types
enum AiProvider {
  openai('OpenAI', 'gpt-4o-mini', 'https://api.openai.com/v1'),
  anthropic(
    'Anthropic',
    'claude-3-haiku-20240307',
    'https://api.anthropic.com/v1',
  ),
  gemini(
    'Google Gemini',
    'gemini-1.5-flash',
    'https://generativelanguage.googleapis.com/v1beta',
  ),
  grok('xAI Grok', 'grok-beta', 'https://api.x.ai/v1'),
  deepseek('DeepSeek', 'deepseek-chat', 'https://api.deepseek.com/v1'),
  openrouter(
    'OpenRouter',
    'openai/gpt-4o-mini',
    'https://openrouter.ai/api/v1',
  ),
  mock('Mock', 'mock-model', '');

  final String displayName;
  final String defaultModel;
  final String defaultBaseUrl;
  const AiProvider(this.displayName, this.defaultModel, this.defaultBaseUrl);
}

/// AI Service configuration
@freezed
abstract class AiConfig with _$AiConfig {
  const factory AiConfig({
    required AiProvider provider,
    required String apiKey,
    @Default('') String model,
    @Default('https://api.openai.com/v1') String baseUrl,
    @Default(30000) int timeoutMs,
    @Default(0.7) double temperature,
    @Default(2000) int maxTokens,
  }) = _AiConfig;

  factory AiConfig.fromJson(Map<String, dynamic> json) =>
      _$AiConfigFromJson(json);
}

/// Chat message for AI API
@freezed
abstract class AiMessage with _$AiMessage {
  const factory AiMessage({
    required String role, // 'system', 'user', 'assistant'
    required String content,
  }) = _AiMessage;

  factory AiMessage.fromJson(Map<String, dynamic> json) =>
      _$AiMessageFromJson(json);
}

/// AI completion request
@freezed
abstract class AiCompletionRequest with _$AiCompletionRequest {
  const factory AiCompletionRequest({
    required List<AiMessage> messages,
    @Default('') String model,
    @Default(0.7) double temperature,
    @Default(2000) int maxTokens,
    @Default(true) bool stream,
  }) = _AiCompletionRequest;

  factory AiCompletionRequest.fromJson(Map<String, dynamic> json) =>
      _$AiCompletionRequestFromJson(json);
}

/// AI completion response chunk (for streaming)
@freezed
abstract class AiCompletionChunk with _$AiCompletionChunk {
  const factory AiCompletionChunk({
    required String content,
    @Default(false) bool isDone,
    @Default(null) String? error,
    @Default(null) int? promptTokens,
    @Default(null) int? completionTokens,
  }) = _AiCompletionChunk;

  factory AiCompletionChunk.fromJson(Map<String, dynamic> json) =>
      _$AiCompletionChunkFromJson(json);
}

/// Poker-specific system prompt builder
class PokerSystemPrompt {
  static String build({
    List<String>? heroCards,
    List<String>? boardCards,
    String? boardPhase,
    int? opponentCount,
    double? potSize,
    double? heroEquity,
    String? heroHandRank,
    double? amountToCall,
    String? potOddsRatio,
  }) {
    final buffer = StringBuffer();

    buffer.writeln('''
You are an expert poker strategy assistant specializing in Texas Hold'em. 
You provide concise, actionable advice based on GTO (Game Theory Optimal) principles while being practical for recreational players.

Key guidelines:
- Be concise but thorough
- Use poker terminology appropriately
- Consider position, stack sizes, and opponent tendencies
- Explain pot odds and equity when relevant
- Format card notations properly (e.g., A♠ K♥)
- Use bullet points for multiple recommendations
''');

    // Add current game context if available
    if (heroCards != null && heroCards.isNotEmpty) {
      buffer.writeln('\n--- CURRENT HAND CONTEXT ---');
      buffer.writeln('Hero cards: ${heroCards.join(' ')}');

      if (boardCards != null && boardCards.isNotEmpty) {
        buffer.writeln('Board: ${boardCards.join(' ')}');
      }

      if (boardPhase != null) {
        buffer.writeln('Street: $boardPhase');
      }

      if (opponentCount != null) {
        buffer.writeln('Opponents: $opponentCount');
      }

      if (potSize != null && potSize > 0) {
        buffer.writeln('Pot size: \$${potSize.toStringAsFixed(0)}');
      }

      if (amountToCall != null && amountToCall > 0) {
        buffer.writeln('Amount to call: \$${amountToCall.toStringAsFixed(0)}');
        if (potOddsRatio != null) {
          buffer.writeln('Pot odds: $potOddsRatio');
        }
      }

      if (heroEquity != null) {
        buffer.writeln('Calculated equity: ${heroEquity.toStringAsFixed(1)}%');
      }

      if (heroHandRank != null) {
        buffer.writeln('Current hand: $heroHandRank');
      }

      buffer.writeln('--- END CONTEXT ---\n');
    }

    return buffer.toString();
  }
}
