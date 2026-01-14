import 'package:freezed_annotation/freezed_annotation.dart';

import 'card_entity.dart';
import 'game_settings.dart';

part 'player.freezed.dart';

/// Represents a player in the poker game
@freezed
abstract class Player with _$Player {
  const Player._();

  const factory Player({
    required String id,
    required int index,
    @Default([]) List<PlayingCard> holeCards,
    @Default(null) PlayerEquity? equity,
    @Default(false) bool isHero,
    @Default(false) bool isSelected,
    @Default(false) bool useRange,

    /// Selected hand range for opponents (e.g., {'AA', 'AKs', 'KK'})
    @Default({}) Set<String> selectedRange,

    /// Player's current chip stack
    @Default(100) double stack,

    /// Amount bet in current round
    @Default(0) double currentBet,

    /// Total amount invested in this hand
    @Default(0) double totalInvested,

    /// Player position at the table
    @Default(null) PlayerPosition? position,

    /// Has player folded this hand
    @Default(false) bool isFolded,

    /// Is player all-in
    @Default(false) bool isAllIn,

    /// Is it this player's turn to act
    @Default(false) bool isCurrentTurn,

    /// Has player acted in current betting round
    @Default(false) bool hasActed,
  }) = _Player;

  /// Check if player has complete hand (2 cards)
  bool get hasCompleteHand => holeCards.length == 2;

  /// Check if player can add more cards
  bool get canAddCard => holeCards.length < 2;

  /// Get display name
  String get displayName => isHero ? 'Hero' : 'Player ${index + 1}';

  /// Get position display name
  String get positionDisplay => position?.shortName ?? '';

  /// Check if player has a valid range selected
  bool get hasValidRange => useRange && selectedRange.isNotEmpty;

  /// Get range description for display
  String get rangeDescription {
    if (!useRange) return '';
    if (selectedRange.isEmpty) return 'Random';
    final percentage = (selectedRange.length / 169 * 100).toStringAsFixed(0);
    return '$percentage% (${selectedRange.length} hands)';
  }

  /// Check if player can act (not folded and not all-in)
  bool get canAct => !isFolded && !isAllIn;

  /// Check if player is still in hand
  bool get isInHand => !isFolded;

  /// Get effective stack (stack minus current bet)
  double get effectiveStack => stack - currentBet;

  /// Format stack for display
  String formatStack(String currencySymbol) {
    if (stack >= 1000) {
      return '$currencySymbol${(stack / 1000).toStringAsFixed(1)}k';
    }
    return '$currencySymbol${stack.toStringAsFixed(0)}';
  }
}

/// Equity result for a single player
@freezed
abstract class PlayerEquity with _$PlayerEquity {
  const PlayerEquity._();

  const factory PlayerEquity({
    required double winPercentage,
    required double tiePercentage,
    @Default(0) double losePercentage,
  }) = _PlayerEquity;

  double get equity => winPercentage + (tiePercentage / 2);
}

/// Betting action in a round
enum BettingAction {
  fold('Fold'),
  check('Check'),
  call('Call'),
  bet('Bet'),
  raise('Raise'),
  allIn('All-In');

  final String displayName;
  const BettingAction(this.displayName);
}

/// Betting round phase
enum BettingRound {
  preflop('Preflop', 0),
  flop('Flop', 3),
  turn('Turn', 4),
  river('River', 5);

  final String displayName;
  final int communityCardsCount;
  const BettingRound(this.displayName, this.communityCardsCount);
}

/// Player action in a betting round
@freezed
abstract class PlayerAction with _$PlayerAction {
  const factory PlayerAction({
    required String playerId,
    required BettingRound round,
    required BettingAction action,
    @Default(0) double amount,
  }) = _PlayerAction;
}
