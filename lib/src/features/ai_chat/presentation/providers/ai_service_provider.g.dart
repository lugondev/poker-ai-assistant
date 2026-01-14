// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiServiceHash() => r'7fb5aadee1e68e4838e4248ef8549a52e1ccf2d0';

/// AI Service instance provider
///
/// Copied from [aiService].
@ProviderFor(aiService)
final aiServiceProvider = AutoDisposeProvider<AiService>.internal(
  aiService,
  name: r'aiServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AiServiceRef = AutoDisposeProviderRef<AiService>;
String _$isAiConfiguredHash() => r'5a1cfbb78d77b1fe67105589d70c1055f6b9d465';

/// Check if AI is configured
///
/// Copied from [isAiConfigured].
@ProviderFor(isAiConfigured)
final isAiConfiguredProvider = AutoDisposeProvider<bool>.internal(
  isAiConfigured,
  name: r'isAiConfiguredProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAiConfiguredHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAiConfiguredRef = AutoDisposeProviderRef<bool>;
String _$aiConfigControllerHash() =>
    r'5aec9d31c984ff61ff281fdebc1ea14f74fcb4cf';

/// Current AI configuration state
///
/// Copied from [AiConfigController].
@ProviderFor(AiConfigController)
final aiConfigControllerProvider =
    AutoDisposeAsyncNotifierProvider<AiConfigController, AiConfig>.internal(
      AiConfigController.new,
      name: r'aiConfigControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$aiConfigControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AiConfigController = AutoDisposeAsyncNotifier<AiConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
