// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_context_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameContextHash() => r'8bb147f7014050ecde9591269572c00f763c65ae';

/// Provider that builds GameContextSnapshot from current CalculatorState
///
/// Copied from [gameContext].
@ProviderFor(gameContext)
final gameContextProvider = AutoDisposeProvider<GameContextSnapshot>.internal(
  gameContext,
  name: r'gameContextProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameContextHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GameContextRef = AutoDisposeProviderRef<GameContextSnapshot>;
String _$contextQuickActionsHash() =>
    r'96ed4aa15065981b1d70af3ac35cbd65cb30b202';

/// Provider for context-aware quick actions based on game state
///
/// Copied from [contextQuickActions].
@ProviderFor(contextQuickActions)
final contextQuickActionsProvider =
    AutoDisposeProvider<List<QuickAction>>.internal(
      contextQuickActions,
      name: r'contextQuickActionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contextQuickActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ContextQuickActionsRef = AutoDisposeProviderRef<List<QuickAction>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
