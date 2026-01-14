import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/card_entity.dart';
import '../../domain/entities/player.dart';
import '../../domain/logic/hand_evaluator.dart';
import '../../domain/logic/monte_carlo_engine.dart';
import 'calculator_state.dart';

part 'calculator_controller.g.dart';

@riverpod
class CalculatorController extends _$CalculatorController {
  final MonteCarloEngine _engine = MonteCarloEngine();
  final HandEvaluator _handEvaluator = HandEvaluator();

  @override
  CalculatorState build() {
    // Initialize with 2 players (Hero + 1 opponent)
    return CalculatorState(
      players: [
        const Player(id: 'hero', index: 0, isHero: true, isSelected: true),
        const Player(id: 'player_1', index: 1),
      ],
    );
  }

  /// Add a new player
  void addPlayer() {
    if (!state.canAddPlayer) return;

    final newIndex = state.players.length;
    final newPlayer = Player(id: 'player_$newIndex', index: newIndex);

    state = state.copyWith(players: [...state.players, newPlayer]);
  }

  /// Remove a player by index
  void removePlayer(int index) {
    if (!state.canRemovePlayer || index == 0) return; // Can't remove hero

    final newPlayers = List<Player>.from(state.players)..removeAt(index);

    // Reindex remaining players
    final reindexedPlayers = newPlayers.asMap().entries.map((entry) {
      return entry.value.copyWith(index: entry.key);
    }).toList();

    state = state.copyWith(
      players: reindexedPlayers,
      selectedPlayerIndex: state.selectedPlayerIndex >= reindexedPlayers.length
          ? reindexedPlayers.length - 1
          : state.selectedPlayerIndex,
    );
  }

  /// Select a player for card input
  void selectPlayer(int index) {
    if (index >= state.players.length) return;

    final updatedPlayers = state.players.asMap().entries.map((entry) {
      return entry.value.copyWith(isSelected: entry.key == index);
    }).toList();

    state = state.copyWith(
      players: updatedPlayers,
      selectedPlayerIndex: index,
      selectionTarget: SelectionTarget.player,
    );
  }

  /// Set selection target (board or player)
  void setSelectionTarget(SelectionTarget target) {
    state = state.copyWith(selectionTarget: target);
  }

  /// Set board phase
  void setBoardPhase(BoardPhase phase) {
    // Trim board cards if switching to lower phase
    List<PlayingCard> newBoardCards = state.boardCards;
    if (state.boardCards.length > phase.cardCount) {
      newBoardCards = state.boardCards.sublist(0, phase.cardCount);
    }

    state = state.copyWith(boardPhase: phase, boardCards: newBoardCards);
    _updateHeroHandRank();
  }

  /// Add a card based on current selection target
  void addCard(PlayingCard card) {
    if (state.isCardUsed(card)) return;

    switch (state.selectionTarget) {
      case SelectionTarget.player:
        _addCardToPlayer(card);
        break;
      case SelectionTarget.board:
        _addCardToBoard(card);
        break;
    }
  }

  void _addCardToPlayer(PlayingCard card) {
    final player = state.selectedPlayer;
    if (player == null || !player.canAddCard) return;

    final updatedPlayers = state.players.map((p) {
      if (p.id == player.id) {
        return p.copyWith(holeCards: [...p.holeCards, card]);
      }
      return p;
    }).toList();

    state = state.copyWith(players: updatedPlayers);

    // Auto-switch to next player or board after 2 cards
    final updatedPlayer = updatedPlayers[state.selectedPlayerIndex];
    if (updatedPlayer.hasCompleteHand) {
      // Find next player without complete hand
      final nextPlayerIndex = updatedPlayers.indexWhere(
        (p) => !p.hasCompleteHand && p.index > state.selectedPlayerIndex,
      );

      if (nextPlayerIndex != -1) {
        selectPlayer(nextPlayerIndex);
      } else {
        // All players have cards, switch to board
        state = state.copyWith(selectionTarget: SelectionTarget.board);
      }
    }

    _updateHeroHandRank();
  }

  void _addCardToBoard(PlayingCard card) {
    if (!state.canAddToBoard) return;

    state = state.copyWith(boardCards: [...state.boardCards, card]);

    _updateHeroHandRank();
  }

  /// Remove card from a player's hand
  void removeCardFromPlayer(int playerIndex, int cardIndex) {
    if (playerIndex >= state.players.length) return;

    final player = state.players[playerIndex];
    if (cardIndex >= player.holeCards.length) return;

    final newHoleCards = List<PlayingCard>.from(player.holeCards)
      ..removeAt(cardIndex);

    final updatedPlayers = state.players.map((p) {
      if (p.id == player.id) {
        return p.copyWith(holeCards: newHoleCards, equity: null);
      }
      return p;
    }).toList();

    state = state.copyWith(players: updatedPlayers);
    _updateHeroHandRank();
  }

  /// Remove card from board
  void removeCardFromBoard(int index) {
    if (index >= state.boardCards.length) return;

    final newBoard = List<PlayingCard>.from(state.boardCards)..removeAt(index);
    state = state.copyWith(boardCards: newBoard);
    _updateHeroHandRank();
  }

  /// Clear all board cards
  void clearBoard() {
    state = state.copyWith(boardCards: [], heroHandRank: null);
    _clearAllEquity();
  }

  /// Clear all - reset everything
  void reset() {
    state = CalculatorState(
      players: [
        const Player(id: 'hero', index: 0, isHero: true, isSelected: true),
        const Player(id: 'player_1', index: 1),
      ],
    );
  }

  /// Toggle range mode for a player
  void togglePlayerRange(int playerIndex) {
    if (playerIndex >= state.players.length || playerIndex == 0) return;

    final updatedPlayers = state.players.map((p) {
      if (p.index == playerIndex) {
        return p.copyWith(
          useRange: !p.useRange,
          holeCards: [], // Clear cards when using range
          selectedRange: {}, // Clear range when toggling
        );
      }
      return p;
    }).toList();

    state = state.copyWith(players: updatedPlayers);
  }

  /// Set selected range for a player
  void setPlayerRange(int playerIndex, Set<String> range) {
    if (playerIndex >= state.players.length || playerIndex == 0) return;

    final updatedPlayers = state.players.map((p) {
      if (p.index == playerIndex) {
        return p.copyWith(
          useRange: true,
          holeCards: [], // Clear cards when using range
          selectedRange: range,
        );
      }
      return p;
    }).toList();

    state = state.copyWith(players: updatedPlayers);
  }

  /// Clear player range and switch back to card mode
  void clearPlayerRange(int playerIndex) {
    if (playerIndex >= state.players.length || playerIndex == 0) return;

    final updatedPlayers = state.players.map((p) {
      if (p.index == playerIndex) {
        return p.copyWith(useRange: false, selectedRange: {});
      }
      return p;
    }).toList();

    state = state.copyWith(players: updatedPlayers);
  }

  /// Calculate equity for all players
  Future<void> calculateEquity() async {
    if (!state.canCalculate) {
      state = state.copyWith(errorMessage: 'Hero must have 2 cards');
      return;
    }

    state = state.copyWith(isCalculating: true, errorMessage: null);

    try {
      final results = await _engine.calculateMultiPlayerEquity(
        players: state.players,
        communityCards: state.boardCards,
      );

      // Update players with their equity
      final updatedPlayers = state.players.map((player) {
        final result = results[player.id];
        if (result != null) {
          return player.copyWith(
            equity: PlayerEquity(
              winPercentage: result.winPercentage,
              tiePercentage: result.tiePercentage,
              losePercentage: result.losePercentage,
            ),
          );
        }
        return player;
      }).toList();

      state = state.copyWith(players: updatedPlayers, isCalculating: false);
    } catch (e) {
      state = state.copyWith(
        isCalculating: false,
        errorMessage: 'Calculation failed: $e',
      );
    }
  }

  void _updateHeroHandRank() {
    final hero = state.hero;
    if (hero == null) return;

    final allCards = [...hero.holeCards, ...state.boardCards];
    if (allCards.length < 5) {
      state = state.copyWith(heroHandRank: null);
      return;
    }

    final evaluated = _handEvaluator.evaluate(allCards);
    state = state.copyWith(heroHandRank: evaluated.rank.displayName);
  }

  void _clearAllEquity() {
    final updatedPlayers = state.players.map((p) {
      return p.copyWith(equity: null);
    }).toList();

    state = state.copyWith(players: updatedPlayers);
  }

  /// Add a betting action for a player
  void addBettingAction({
    required String playerId,
    required BettingAction action,
    double amount = 0,
  }) {
    final newAction = PlayerAction(
      playerId: playerId,
      round: _getCurrentBettingRound(),
      action: action,
      amount: amount,
    );

    state = state.copyWith(
      bettingHistory: [...state.bettingHistory, newAction],
      potSize: state.potSize + amount,
    );
  }

  /// Clear betting history
  void clearBettingHistory() {
    state = state.copyWith(bettingHistory: [], potSize: 0);
  }

  /// Get current betting round based on board cards
  BettingRound _getCurrentBettingRound() {
    final cardCount = state.boardCards.length;
    if (cardCount == 0) return BettingRound.preflop;
    if (cardCount <= 3) return BettingRound.flop;
    if (cardCount == 4) return BettingRound.turn;
    return BettingRound.river;
  }

  /// Get current betting round (public)
  BettingRound get currentBettingRound => _getCurrentBettingRound();
}
