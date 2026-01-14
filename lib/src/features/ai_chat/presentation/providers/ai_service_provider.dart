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
  static const _openaiKeyName = 'openai_api_key';
  static const _anthropicKeyName = 'anthropic_api_key';
  static const _providerKeyName = 'ai_provider';

  @override
  Future<AiConfig> build() async {
    // Load saved configuration
    final storage = ref.watch(secureStorageProvider);

    final providerStr = await storage.read(key: _providerKeyName);
    final provider = AiProvider.values.firstWhere(
      (p) => p.name == providerStr,
      orElse: () => AiProvider.mock, // Default to mock
    );

    String apiKey = '';
    if (provider == AiProvider.openai) {
      apiKey = await storage.read(key: _openaiKeyName) ?? '';
    } else if (provider == AiProvider.anthropic) {
      apiKey = await storage.read(key: _anthropicKeyName) ?? '';
    }

    return AiConfig(
      provider: provider,
      apiKey: apiKey,
      model: provider.defaultModel,
    );
  }

  /// Set AI provider
  Future<void> setProvider(AiProvider provider) async {
    final storage = ref.read(secureStorageProvider);
    await storage.write(key: _providerKeyName, value: provider.name);

    // Load API key for new provider
    String apiKey = '';
    if (provider == AiProvider.openai) {
      apiKey = await storage.read(key: _openaiKeyName) ?? '';
    } else if (provider == AiProvider.anthropic) {
      apiKey = await storage.read(key: _anthropicKeyName) ?? '';
    }

    state = AsyncData(
      AiConfig(
        provider: provider,
        apiKey: apiKey,
        model: provider.defaultModel,
      ),
    );
  }

  /// Set API key for current provider
  Future<void> setApiKey(String apiKey) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final storage = ref.read(secureStorageProvider);

    if (current.provider == AiProvider.openai) {
      await storage.write(key: _openaiKeyName, value: apiKey);
    } else if (current.provider == AiProvider.anthropic) {
      await storage.write(key: _anthropicKeyName, value: apiKey);
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
