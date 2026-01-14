import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/chat_message.dart';
import '../../../calculator/presentation/providers/calculator_controller.dart';
import '../../../calculator/presentation/providers/calculator_state.dart';

part 'game_context_provider.g.dart';

/// Provider that builds GameContextSnapshot from current CalculatorState
@riverpod
GameContextSnapshot gameContext(Ref ref) {
  final calcState = ref.watch(calculatorControllerProvider);

  return _buildContextFromState(calcState);
}

/// Build GameContextSnapshot from CalculatorState
GameContextSnapshot _buildContextFromState(CalculatorState state) {
  final hero = state.hero;

  // Get hero cards as display strings
  final heroCards = hero?.holeCards.map((c) => c.displayName).toList() ?? [];

  // Get board cards as display strings
  final boardCards = state.boardCards.map((c) => c.displayName).toList();

  // Determine board phase string
  final boardPhase = _getBoardPhase(state.boardCards.length);

  // Count opponents (excluding hero, excluding folded players)
  final opponentCount = state.players
      .where((p) => !p.isHero && !p.isFolded)
      .length;

  // Get hero equity if calculated
  final heroEquity = hero?.equity?.winPercentage;

  return GameContextSnapshot(
    heroCards: heroCards,
    boardCards: boardCards,
    boardPhase: boardPhase,
    opponentCount: opponentCount,
    potSize: state.potSize,
    amountToCall: state.amountToCall,
    heroEquity: heroEquity,
    potOddsRatio: state.potOddsRatio,
    requiredEquity: state.requiredEquityToCall,
    heroHandRank: state.heroHandRank,
  );
}

/// Get board phase string from card count
String _getBoardPhase(int cardCount) {
  if (cardCount == 0) return 'preflop';
  if (cardCount <= 3) return 'flop';
  if (cardCount == 4) return 'turn';
  return 'river';
}

/// Provider for context-aware quick actions based on game state
@riverpod
List<QuickAction> contextQuickActions(Ref ref) {
  final context = ref.watch(gameContextProvider);

  return _buildQuickActionsForContext(context);
}

/// Build quick actions based on current game context
List<QuickAction> _buildQuickActionsForContext(GameContextSnapshot context) {
  final actions = <QuickAction>[];

  // No cards - general questions
  if (!context.hasHeroCards) {
    return [
      const QuickAction(
        label: 'Hand strength',
        prompt: 'What hands should I play from different positions?',
        icon: 'help',
      ),
      const QuickAction(
        label: 'Position play',
        prompt: 'Explain the importance of position in poker',
        icon: 'position',
      ),
      const QuickAction(
        label: 'Starting hands',
        prompt: 'What are the best starting hands in Texas Hold\'em?',
        icon: 'cards',
      ),
    ];
  }

  // Has cards but no board (preflop)
  if (context.boardPhase == 'preflop') {
    final cardsStr = context.heroCards.join(' ');
    actions.addAll([
      QuickAction(
        label: 'Play $cardsStr?',
        prompt:
            'How should I play ${context.heroCards.join('')} preflop against ${context.opponentCount} opponent${context.opponentCount != 1 ? 's' : ''}?',
        icon: 'cards',
      ),
      QuickAction(
        label: 'Raise sizing',
        prompt:
            'What\'s a good raise size preflop with ${context.heroCards.join('')}?',
        icon: 'bet',
      ),
      const QuickAction(
        label: '3-bet range',
        prompt: 'What hands should I 3-bet with?',
        icon: 'analytics',
      ),
    ]);
  }

  // Has board (postflop)
  if (context.hasBoard) {
    final heroStr = context.heroCards.join(' ');
    final boardStr = context.boardCards.join(' ');
    final handRank = context.heroHandRank;

    actions.addAll([
      QuickAction(
        label: 'Analyze board',
        prompt:
            'Analyze this board: $boardStr with my hand $heroStr${handRank != null ? ' ($handRank)' : ''}',
        icon: 'analytics',
      ),
    ]);

    // Add draw-specific actions on flop/turn
    if (context.boardPhase == 'flop' || context.boardPhase == 'turn') {
      actions.add(
        QuickAction(
          label: 'Drawing odds',
          prompt: 'What are my drawing odds with $heroStr on board $boardStr?',
          icon: 'draw',
        ),
      );
    }

    // Add equity-based decisions if facing a bet
    if (context.amountToCall > 0 && context.potSize > 0) {
      actions.add(
        QuickAction(
          label: 'Call or fold?',
          prompt:
              'Should I call ${context.amountToCall} into a pot of ${context.potSize} with $heroStr on $boardStr? Pot odds are ${context.potOddsRatio}.',
          icon: 'call',
        ),
      );
    }

    // River specific
    if (context.boardPhase == 'river') {
      actions.add(
        QuickAction(
          label: 'Value bet?',
          prompt:
              'Can I value bet $heroStr on $boardStr${handRank != null ? ' ($handRank)' : ''}?',
          icon: 'bet',
        ),
      );
    }
  }

  // Add equity question if equity is calculated
  if (context.heroEquity != null) {
    actions.add(
      QuickAction(
        label: 'Explain ${context.heroEquity!.toStringAsFixed(0)}% equity',
        prompt:
            'Explain why my equity is ${context.heroEquity!.toStringAsFixed(1)}% with ${context.heroCards.join(' ')} on ${context.boardCards.join(' ')}',
        icon: 'percent',
      ),
    );
  }

  // Limit to 4 most relevant actions
  return actions.take(4).toList();
}
