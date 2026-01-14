import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/card_entity.dart';
import '../../domain/logic/monte_carlo_engine.dart';

part 'calculator_state.freezed.dart';

enum SelectionTarget { playerHand, board }

@freezed
abstract class CalculatorState with _$CalculatorState {
  const CalculatorState._();

  const factory CalculatorState({
    @Default([]) List<PlayingCard> playerHand,
    @Default([]) List<PlayingCard> boardCards,
    @Default(null) EquityResult? equityResult,
    @Default(false) bool isCalculating,
    @Default(SelectionTarget.playerHand) SelectionTarget selectionTarget,
    @Default(null) String? errorMessage,
    @Default(1) int opponentCount,
    @Default(null) String? currentHandRank,
  }) = _CalculatorState;

  bool get canAddToHand => playerHand.length < 2;
  bool get canAddToBoard => boardCards.length < 5;
  bool get canCalculate => playerHand.length == 2;

  List<PlayingCard> get usedCards => [...playerHand, ...boardCards];

  bool isCardUsed(PlayingCard card) =>
      usedCards.any((c) => c.rank == card.rank && c.suit == card.suit);
}
