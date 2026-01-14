import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/ai_models.dart';
import '../../data/services/ai_service.dart';

part 'ai_service_provider.g.dart';

/// Secure storage for API keys
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
});

/// Current AI configuration state
@riverpod
class AiConfigController extends _$AiConfigController {
  // Storage keys for each provider
  static const _providerKeyName = 'ai_provider';
  static const _openaiKeyName = 'openai_api_key';
  static const _anthropicKeyName = 'anthropic_api_key';
  static const _geminiKeyName = 'gemini_api_key';
  static const _grokKeyName = 'grok_api_key';
  static const _deepseekKeyName = 'deepseek_api_key';
  static const _openrouterKeyName = 'openrouter_api_key';

  /// Get storage key name for a provider
  String _getApiKeyName(AiProvider provider) {
    return switch (provider) {
      AiProvider.openai => _openaiKeyName,
      AiProvider.anthropic => _anthropicKeyName,
      AiProvider.gemini => _geminiKeyName,
      AiProvider.grok => _grokKeyName,
      AiProvider.deepseek => _deepseekKeyName,
      AiProvider.openrouter => _openrouterKeyName,
      AiProvider.mock => '',
    };
  }

  @override
  Future<AiConfig> build() async {
    // Load saved configuration
    final storage = ref.watch(secureStorageProvider);

    final providerStr = await storage.read(key: _providerKeyName);
    final provider = AiProvider.values.firstWhere(
      (p) => p.name == providerStr,
      orElse: () => AiProvider.mock, // Default to mock
    );

    // Load API key for the selected provider
    String apiKey = '';
    final keyName = _getApiKeyName(provider);
    if (keyName.isNotEmpty) {
      apiKey = await storage.read(key: keyName) ?? '';
    }

    return AiConfig(
      provider: provider,
      apiKey: apiKey,
      model: provider.defaultModel,
      baseUrl: provider.defaultBaseUrl,
    );
  }

  /// Set AI provider
  Future<void> setProvider(AiProvider provider) async {
    final storage = ref.read(secureStorageProvider);
    await storage.write(key: _providerKeyName, value: provider.name);

    // Load API key for new provider
    String apiKey = '';
    final keyName = _getApiKeyName(provider);
    if (keyName.isNotEmpty) {
      apiKey = await storage.read(key: keyName) ?? '';
    }

    state = AsyncData(
      AiConfig(
        provider: provider,
        apiKey: apiKey,
        model: provider.defaultModel,
        baseUrl: provider.defaultBaseUrl,
      ),
    );
  }

  /// Set API key for current provider
  Future<void> setApiKey(String apiKey) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final storage = ref.read(secureStorageProvider);
    final keyName = _getApiKeyName(current.provider);

    if (keyName.isNotEmpty) {
      await storage.write(key: keyName, value: apiKey);
    }

    state = AsyncData(current.copyWith(apiKey: apiKey));
  }

  /// Clear API key
  Future<void> clearApiKey() async {
    await setApiKey('');
  }

  /// Check if configured
  bool get isConfigured {
    final current = state.valueOrNull;
    if (current == null) return false;
    if (current.provider == AiProvider.mock) return true;
    return current.apiKey.isNotEmpty;
  }
}

/// AI Service instance provider
@riverpod
AiService aiService(Ref ref) {
  final configAsync = ref.watch(aiConfigControllerProvider);

  return configAsync.when(
    data: (config) => AiServiceFactory.create(config),
    loading: () => MockAiService(),
    error: (e, s) => MockAiService(),
  );
}

/// Check if AI is configured
@riverpod
bool isAiConfigured(Ref ref) {
  final configAsync = ref.watch(aiConfigControllerProvider);

  return configAsync.when(
    data: (config) {
      if (config.provider == AiProvider.mock) return true;
      return config.apiKey.isNotEmpty;
    },
    loading: () => false,
    error: (e, s) => false,
  );
}
