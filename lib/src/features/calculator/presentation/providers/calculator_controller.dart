import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/card_entity.dart';
import '../../domain/entities/game_settings.dart';
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
    final settings = const GameSettings();
    return CalculatorState(
      gameSettings: settings,
      players: [
        Player(
          id: 'hero',
          index: 0,
          isHero: true,
          isSelected: true,
          stack: settings.defaultStack,
          position: PlayerPosition.btn,
        ),
        Player(
          id: 'player_1',
          index: 1,
          stack: settings.defaultStack,
          position: PlayerPosition.bb,
        ),
      ],
    );
  }

  /// Update game settings
  void updateGameSettings(GameSettings settings) {
    // Update all player stacks if they haven't been modified
    final updatedPlayers = state.players.map((p) {
      if (p.stack == state.gameSettings.defaultStack) {
        return p.copyWith(stack: settings.defaultStack);
      }
      return p;
    }).toList();

    state = state.copyWith(gameSettings: settings, players: updatedPlayers);
  }

  /// Add a new player
  void addPlayer() {
    if (!state.canAddPlayer) return;

    final newIndex = state.players.length;
    final positions = PlayerPosition.getPositionsForPlayerCount(newIndex + 1);

    // Reassign positions to all players
    final updatedPlayers = state.players.asMap().entries.map((entry) {
      return entry.value.copyWith(position: positions[entry.key]);
    }).toList();

    final newPlayer = Player(
      id: 'player_$newIndex',
      index: newIndex,
      stack: state.gameSettings.defaultStack,
      position: positions[newIndex],
    );

    state = state.copyWith(players: [...updatedPlayers, newPlayer]);
  }

  /// Remove a player by index
  void removePlayer(int index) {
    if (!state.canRemovePlayer || index == 0) return; // Can't remove hero

    final newPlayers = List<Player>.from(state.players)..removeAt(index);
    final positions = PlayerPosition.getPositionsForPlayerCount(
      newPlayers.length,
    );

    // Reindex remaining players and reassign positions
    final reindexedPlayers = newPlayers.asMap().entries.map((entry) {
      return entry.value.copyWith(
        index: entry.key,
        position: positions[entry.key],
      );
    }).toList();

    state = state.copyWith(
      players: reindexedPlayers,
      selectedPlayerIndex: state.selectedPlayerIndex >= reindexedPlayers.length
          ? reindexedPlayers.length - 1
          : state.selectedPlayerIndex,
    );
  }

  /// Update player stack
  void updatePlayerStack(int playerIndex, double newStack) {
    if (playerIndex >= state.players.length) return;

    final updatedPlayers = state.players.map((p) {
      if (p.index == playerIndex) {
        return p.copyWith(stack: newStack);
      }
      return p;
    }).toList();

    state = state.copyWith(players: updatedPlayers);
  }

  /// Start a new hand with blinds posted
  void startNewHand() {
    final settings = state.gameSettings;

    // Find SB and BB positions
    final sbIndex = state.players.indexWhere(
      (p) => p.position == PlayerPosition.sb,
    );
    final bbIndex = state.players.indexWhere(
      (p) => p.position == PlayerPosition.bb,
    );

    var updatedPlayers = state.players.map((p) {
      var player = p.copyWith(
        isFolded: false,
        isAllIn: false,
        currentBet: 0,
        totalInvested: 0,
        hasActed: false,
        equity: null,
        holeCards: [],
      );

      // Post ante if applicable
      if (settings.ante > 0) {
        final anteAmount = settings.ante.clamp(0.0, player.stack);
        player = player.copyWith(
          stack: player.stack - anteAmount,
          totalInvested: anteAmount,
        );
      }

      return player;
    }).toList();

    // Post small blind
    if (sbIndex >= 0) {
      final sbPlayer = updatedPlayers[sbIndex];
      final sbAmount = settings.smallBlind.clamp(0.0, sbPlayer.stack);
      updatedPlayers[sbIndex] = sbPlayer.copyWith(
        stack: sbPlayer.stack - sbAmount,
        currentBet: sbAmount,
        totalInvested: sbPlayer.totalInvested + sbAmount,
        isAllIn: sbAmount >= sbPlayer.stack,
      );
    }

    // Post big blind
    if (bbIndex >= 0) {
      final bbPlayer = updatedPlayers[bbIndex];
      final bbAmount = settings.bigBlind.clamp(0.0, bbPlayer.stack);
      updatedPlayers[bbIndex] = bbPlayer.copyWith(
        stack: bbPlayer.stack - bbAmount,
        currentBet: bbAmount,
        totalInvested: bbPlayer.totalInvested + bbAmount,
        isAllIn: bbAmount >= bbPlayer.stack,
      );
    }

    // Calculate initial pot
    final initialPot = updatedPlayers.fold(
      0.0,
      (sum, p) => sum + p.totalInvested,
    );

    // Determine first to act (UTG preflop, or SB postflop)
    final preflopOrder = PlayerPosition.getPreflopOrder(state.players.length);
    final firstToActPosition = preflopOrder.first;
    final firstToActIndex = updatedPlayers.indexWhere(
      (p) => p.position == firstToActPosition && p.canAct,
    );

    // Mark current turn
    updatedPlayers = updatedPlayers.asMap().entries.map((entry) {
      return entry.value.copyWith(isCurrentTurn: entry.key == firstToActIndex);
    }).toList();

    state = state.copyWith(
      players: updatedPlayers,
      potSize: initialPot,
      boardCards: [],
      heroHandRank: null,
      isHandInProgress: true,
      currentTurnIndex: firstToActIndex,
      bettingState: BettingState(
        currentBet: settings.bigBlind,
        minRaise: settings.bigBlind,
        mainPot: initialPot,
      ),
      bettingHistory: [],
    );
  }

  /// Process a player action
  void processAction({
    required int playerIndex,
    required BettingAction action,
    double amount = 0,
  }) {
    if (playerIndex >= state.players.length) return;
    if (!state.isHandInProgress) return;

    final player = state.players[playerIndex];
    if (!player.canAct || !player.isCurrentTurn) return;

    var updatedPlayers = List<Player>.from(state.players);
    var newPot = state.potSize;
    var newBettingState = state.bettingState;

    switch (action) {
      case BettingAction.fold:
        updatedPlayers[playerIndex] = player.copyWith(
          isFolded: true,
          isCurrentTurn: false,
          hasActed: true,
        );
        break;

      case BettingAction.check:
        if (state.bettingState.currentBet > player.currentBet) {
          // Can't check, must call
          return;
        }
        updatedPlayers[playerIndex] = player.copyWith(
          isCurrentTurn: false,
          hasActed: true,
        );
        break;

      case BettingAction.call:
        final callAmount = (state.bettingState.currentBet - player.currentBet)
            .clamp(0, player.stack);
        updatedPlayers[playerIndex] = player.copyWith(
          stack: player.stack - callAmount,
          currentBet: player.currentBet + callAmount,
          totalInvested: player.totalInvested + callAmount,
          isCurrentTurn: false,
          hasActed: true,
          isAllIn: callAmount >= player.stack,
        );
        newPot += callAmount;
        break;

      case BettingAction.bet:
      case BettingAction.raise:
        final totalBet = amount;
        final raiseAmount = totalBet - player.currentBet;
        if (raiseAmount > player.stack) {
          // Not enough chips, treat as all-in
          return processAction(
            playerIndex: playerIndex,
            action: BettingAction.allIn,
          );
        }
        updatedPlayers[playerIndex] = player.copyWith(
          stack: player.stack - raiseAmount,
          currentBet: totalBet,
          totalInvested: player.totalInvested + raiseAmount,
          isCurrentTurn: false,
          hasActed: true,
        );
        newPot += raiseAmount;
        newBettingState = newBettingState.copyWith(
          currentBet: totalBet,
          minRaise: totalBet - state.bettingState.currentBet,
          lastAggressorIndex: playerIndex,
        );
        // Reset hasActed for other players who need to respond
        updatedPlayers = updatedPlayers.map((p) {
          if (p.index != playerIndex && p.canAct) {
            return p.copyWith(hasActed: false);
          }
          return p;
        }).toList();
        break;

      case BettingAction.allIn:
        final allInAmount = player.stack;
        final newBet = player.currentBet + allInAmount;
        updatedPlayers[playerIndex] = player.copyWith(
          stack: 0,
          currentBet: newBet,
          totalInvested: player.totalInvested + allInAmount,
          isCurrentTurn: false,
          hasActed: true,
          isAllIn: true,
        );
        newPot += allInAmount;
        if (newBet > state.bettingState.currentBet) {
          newBettingState = newBettingState.copyWith(
            currentBet: newBet,
            lastAggressorIndex: playerIndex,
          );
          // Reset hasActed for other players
          updatedPlayers = updatedPlayers.map((p) {
            if (p.index != playerIndex && p.canAct) {
              return p.copyWith(hasActed: false);
            }
            return p;
          }).toList();
        }
        break;
    }

    // Record action in history
    final newAction = PlayerAction(
      playerId: player.id,
      round: currentBettingRound,
      action: action,
      amount: amount,
    );

    // Find next player to act
    final nextPlayerIndex = _findNextPlayerToAct(updatedPlayers, playerIndex);

    if (nextPlayerIndex == -1) {
      // Betting round complete
      _completeBettingRound(updatedPlayers, newPot, newBettingState, newAction);
    } else {
      // Set next player's turn
      updatedPlayers = updatedPlayers.map((p) {
        return p.copyWith(isCurrentTurn: p.index == nextPlayerIndex);
      }).toList();

      state = state.copyWith(
        players: updatedPlayers,
        potSize: newPot,
        bettingState: newBettingState,
        currentTurnIndex: nextPlayerIndex,
        bettingHistory: [...state.bettingHistory, newAction],
      );
    }
  }

  int _findNextPlayerToAct(List<Player> players, int currentIndex) {
    final activePlayers = players
        .where((p) => p.canAct && !p.hasActed)
        .toList();
    if (activePlayers.isEmpty) return -1;

    // Get action order based on current round
    final isPreflop = state.boardCards.isEmpty;
    final actionOrder = isPreflop
        ? PlayerPosition.getPreflopOrder(players.length)
        : PlayerPosition.getPostflopOrder(players.length);

    // Find next player in action order
    for (final position in actionOrder) {
      final playerIndex = players.indexWhere(
        (p) => p.position == position && p.canAct && !p.hasActed,
      );
      if (playerIndex != -1) {
        return playerIndex;
      }
    }

    return -1;
  }

  void _completeBettingRound(
    List<Player> players,
    double pot,
    BettingState bettingState,
    PlayerAction lastAction,
  ) {
    // Reset current bets for next round
    final updatedPlayers = players.map((p) {
      return p.copyWith(currentBet: 0, hasActed: false, isCurrentTurn: false);
    }).toList();

    // Check if hand is over (only one player remaining)
    final playersInHand = updatedPlayers.where((p) => p.isInHand).toList();
    if (playersInHand.length <= 1) {
      // Hand over
      state = state.copyWith(
        players: updatedPlayers,
        potSize: pot,
        isHandInProgress: false,
        currentTurnIndex: -1,
        bettingHistory: [...state.bettingHistory, lastAction],
      );
      return;
    }

    // Find first to act in next round (postflop order)
    final postflopOrder = PlayerPosition.getPostflopOrder(
      updatedPlayers.length,
    );
    int nextPlayerIndex = -1;
    for (final position in postflopOrder) {
      final idx = updatedPlayers.indexWhere(
        (p) => p.position == position && p.canAct,
      );
      if (idx != -1) {
        nextPlayerIndex = idx;
        break;
      }
    }

    final finalPlayers = updatedPlayers.map((p) {
      return p.copyWith(isCurrentTurn: p.index == nextPlayerIndex);
    }).toList();

    state = state.copyWith(
      players: finalPlayers,
      potSize: pot,
      currentTurnIndex: nextPlayerIndex,
      bettingState: BettingState(
        currentBet: 0,
        minRaise: state.gameSettings.bigBlind,
        mainPot: pot,
      ),
      bettingHistory: [...state.bettingHistory, lastAction],
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
    final settings = state.gameSettings;
    state = CalculatorState(
      gameSettings: settings,
      players: [
        Player(
          id: 'hero',
          index: 0,
          isHero: true,
          isSelected: true,
          stack: settings.defaultStack,
          position: PlayerPosition.btn,
        ),
        Player(
          id: 'player_1',
          index: 1,
          stack: settings.defaultStack,
          position: PlayerPosition.bb,
        ),
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

  /// Add a betting action for a player (legacy - use processAction instead)
  void addBettingAction({
    required String playerId,
    required BettingAction action,
    double amount = 0,
  }) {
    final playerIndex = state.players.indexWhere((p) => p.id == playerId);
    if (playerIndex == -1) return;

    processAction(playerIndex: playerIndex, action: action, amount: amount);
  }

  /// Clear betting history
  void clearBettingHistory() {
    state = state.copyWith(
      bettingHistory: [],
      potSize: 0,
      bettingState: const BettingState(),
    );
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

  /// Move dealer button to next position
  void moveDealerButton() {
    final newIndex = (state.dealerButtonIndex + 1) % state.players.length;
    setDealerPosition(newIndex);
  }

  /// Set dealer button to specific player index
  /// This will automatically reassign SB, BB, and other positions
  void setDealerPosition(int playerIndex) {
    if (playerIndex < 0 || playerIndex >= state.players.length) return;

    // Reassign positions based on new dealer
    final positions = PlayerPosition.getPositionsForPlayerCount(
      state.players.length,
    );
    final updatedPlayers = state.players.asMap().entries.map((entry) {
      final relativeIndex =
          (entry.key - playerIndex + state.players.length) %
          state.players.length;
      return entry.value.copyWith(position: positions[relativeIndex]);
    }).toList();

    state = state.copyWith(
      dealerButtonIndex: playerIndex,
      players: updatedPlayers,
    );
  }

  /// Reorder players in the list (for drag-and-drop)
  void reorderPlayers(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= state.players.length) return;
    if (newIndex < 0 || newIndex > state.players.length) return;

    // Adjust newIndex if moving down in the list
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final players = List<Player>.from(state.players);
    final movedPlayer = players.removeAt(oldIndex);
    players.insert(newIndex, movedPlayer);

    // Recalculate dealer button index if it was affected
    int newDealerIndex = state.dealerButtonIndex;
    if (oldIndex == state.dealerButtonIndex) {
      newDealerIndex = newIndex;
    } else if (oldIndex < state.dealerButtonIndex &&
        newIndex >= state.dealerButtonIndex) {
      newDealerIndex -= 1;
    } else if (oldIndex > state.dealerButtonIndex &&
        newIndex <= state.dealerButtonIndex) {
      newDealerIndex += 1;
    }

    // Reindex players and reassign positions
    final positions = PlayerPosition.getPositionsForPlayerCount(players.length);
    final reindexedPlayers = players.asMap().entries.map((entry) {
      final relativeIndex =
          (entry.key - newDealerIndex + players.length) % players.length;
      return entry.value.copyWith(
        index: entry.key,
        position: positions[relativeIndex],
      );
    }).toList();

    // Update selected player index if needed
    int newSelectedIndex = state.selectedPlayerIndex;
    if (oldIndex == state.selectedPlayerIndex) {
      newSelectedIndex = newIndex;
    } else if (oldIndex < state.selectedPlayerIndex &&
        newIndex >= state.selectedPlayerIndex) {
      newSelectedIndex -= 1;
    } else if (oldIndex > state.selectedPlayerIndex &&
        newIndex <= state.selectedPlayerIndex) {
      newSelectedIndex += 1;
    }

    state = state.copyWith(
      players: reindexedPlayers,
      dealerButtonIndex: newDealerIndex,
      selectedPlayerIndex: newSelectedIndex.clamp(
        0,
        reindexedPlayers.length - 1,
      ),
    );
  }

  /// Set a specific player as Small Blind
  /// (Adjusts dealer position so this player becomes SB)
  void setPlayerAsSB(int playerIndex) {
    if (playerIndex < 0 || playerIndex >= state.players.length) return;
    // The player before SB is the dealer (BTN)
    final newDealerIndex =
        (playerIndex - 1 + state.players.length) % state.players.length;
    setDealerPosition(newDealerIndex);
  }

  /// Set a specific player as Big Blind
  /// (Adjusts dealer position so this player becomes BB)
  void setPlayerAsBB(int playerIndex) {
    if (playerIndex < 0 || playerIndex >= state.players.length) return;
    // The player 2 positions before BB is the dealer (BTN)
    final newDealerIndex =
        (playerIndex - 2 + state.players.length) % state.players.length;
    setDealerPosition(newDealerIndex);
  }
}
