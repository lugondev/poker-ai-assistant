import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/card_entity.dart';
import '../../domain/entities/player.dart';

part 'calculator_state.freezed.dart';

/// Selection target for card input
enum SelectionTarget { board, player }

/// Board phase tabs
enum BoardPhase {
  flop('Flop', 3),
  turn('Turn', 4),
  river('River', 5);

  final String displayName;
  final int cardCount;
  const BoardPhase(this.displayName, this.cardCount);
}

@freezed
abstract class CalculatorState with _$CalculatorState {
  const CalculatorState._();

  const factory CalculatorState({
    /// List of players (first player is always Hero)
    @Default([]) List<Player> players,

    /// Community cards on the board
    @Default([]) List<PlayingCard> boardCards,

    /// Current board phase
    @Default(BoardPhase.flop) BoardPhase boardPhase,

    /// Currently selected player index for card input
    @Default(0) int selectedPlayerIndex,

    /// Current selection target
    @Default(SelectionTarget.player) SelectionTarget selectionTarget,

    /// Is calculation in progress
    @Default(false) bool isCalculating,

    /// Error message
    @Default(null) String? errorMessage,

    /// Current hand rank for hero
    @Default(null) String? heroHandRank,

    /// Total pot size for odds calculation
    @Default(0) double potSize,

    /// List of betting actions for analysis
    @Default([]) List<PlayerAction> bettingHistory,
  }) = _CalculatorState;

  /// Get number of active players
  int get playerCount => players.length;

  /// Get hero (first player)
  Player? get hero => players.isNotEmpty ? players.first : null;

  /// Check if can add player (max 10)
  bool get canAddPlayer => players.length < 10;

  /// Check if can remove player (min 2)
  bool get canRemovePlayer => players.length > 2;

  /// Get currently selected player
  Player? get selectedPlayer => selectedPlayerIndex < players.length
      ? players[selectedPlayerIndex]
      : null;

  /// Check if board can accept more cards based on current phase
  bool get canAddToBoard => boardCards.length < boardPhase.cardCount;

  /// Check if can calculate (hero must have 2 cards)
  bool get canCalculate => hero?.hasCompleteHand ?? false;

  /// Get all used cards across all players and board
  List<PlayingCard> get usedCards {
    final cards = <PlayingCard>[];
    for (final player in players) {
      cards.addAll(player.holeCards);
    }
    cards.addAll(boardCards);
    return cards;
  }

  /// Check if a card is already used
  bool isCardUsed(PlayingCard card) =>
      usedCards.any((c) => c.rank == card.rank && c.suit == card.suit);

  /// Get players remaining (with cards or unknown)
  int get playersRemaining =>
      players.where((p) => p.holeCards.isNotEmpty || p.useRange).length;
}
