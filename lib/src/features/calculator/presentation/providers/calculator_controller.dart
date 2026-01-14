import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/card_entity.dart';
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
    return const CalculatorState();
  }

  void setSelectionTarget(SelectionTarget target) {
    state = state.copyWith(selectionTarget: target);
  }

  void addCard(PlayingCard card) {
    if (state.isCardUsed(card)) return;

    switch (state.selectionTarget) {
      case SelectionTarget.playerHand:
        if (state.canAddToHand) {
          final newHand = [...state.playerHand, card];
          state = state.copyWith(
            playerHand: newHand,
            errorMessage: null,
            currentHandRank: _evaluateCurrentHand(newHand, state.boardCards),
          );
          if (newHand.length == 2) {
            state = state.copyWith(selectionTarget: SelectionTarget.board);
          }
        }
        break;
      case SelectionTarget.board:
        if (state.canAddToBoard) {
          final newBoard = [...state.boardCards, card];
          state = state.copyWith(
            boardCards: newBoard,
            errorMessage: null,
            currentHandRank: _evaluateCurrentHand(state.playerHand, newBoard),
          );
        }
        break;
    }
  }

  void removeCardFromHand(int index) {
    if (index < state.playerHand.length) {
      final newHand = List<PlayingCard>.from(state.playerHand)..removeAt(index);
      state = state.copyWith(
        playerHand: newHand,
        equityResult: null,
        currentHandRank: _evaluateCurrentHand(newHand, state.boardCards),
      );
    }
  }

  void removeCardFromBoard(int index) {
    if (index < state.boardCards.length) {
      final newBoard = List<PlayingCard>.from(state.boardCards)
        ..removeAt(index);
      state = state.copyWith(
        boardCards: newBoard,
        equityResult: null,
        currentHandRank: _evaluateCurrentHand(state.playerHand, newBoard),
      );
    }
  }

  void setOpponentCount(int count) {
    if (count >= 1 && count <= 9) {
      state = state.copyWith(opponentCount: count);
    }
  }

  String? _evaluateCurrentHand(
    List<PlayingCard> playerHand,
    List<PlayingCard> boardCards,
  ) {
    final allCards = [...playerHand, ...boardCards];
    if (allCards.length < 5) return null;

    final evaluated = _handEvaluator.evaluate(allCards);
    return evaluated.rank.displayName;
  }

  void reset() {
    state = const CalculatorState();
  }

  void clearBoard() {
    state = state.copyWith(
      boardCards: [],
      equityResult: null,
      currentHandRank: null,
    );
  }

  Future<void> calculateEquity() async {
    if (!state.canCalculate) {
      state = state.copyWith(errorMessage: 'Select 2 cards for your hand');
      return;
    }

    state = state.copyWith(isCalculating: true, errorMessage: null);

    try {
      final result = await _engine.calculateEquity(
        playerHand: state.playerHand,
        communityCards: state.boardCards,
        opponentCount: state.opponentCount,
      );

      state = state.copyWith(equityResult: result, isCalculating: false);
    } catch (e) {
      state = state.copyWith(
        isCalculating: false,
        errorMessage: 'Calculation failed',
      );
    }
  }
}
