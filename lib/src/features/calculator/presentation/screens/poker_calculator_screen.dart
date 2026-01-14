import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/calculator_controller.dart';
import '../providers/calculator_state.dart';
import '../widgets/card_selector_widget.dart';
import '../widgets/equity_display_widget.dart';
import '../widgets/playing_card_widget.dart';

class PokerCalculatorScreen extends ConsumerWidget {
  const PokerCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorControllerProvider);
    final controller = ref.read(calculatorControllerProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF0D1F12),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(controller),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    EquityDisplayWidget(
                      result: state.equityResult,
                      isCalculating: state.isCalculating,
                    ),
                    const SizedBox(height: 24),
                    _buildBoardSection(context, state, controller),
                    const SizedBox(height: 24),
                    _buildPlayerHandSection(context, state, controller),
                    const SizedBox(height: 24),
                    _buildOpponentSelector(ref),
                    const SizedBox(height: 16),
                    _buildCalculateButton(state, controller),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            CardSelectorWidget(
              onCardSelected: controller.addCard,
              usedCards: state.usedCards.toSet(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(CalculatorController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'POKER AI',
            style: GoogleFonts.orbitron(
              color: Colors.lightGreenAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: controller.reset,
            icon: const Icon(Icons.refresh, color: Colors.white54),
            tooltip: 'Reset',
          ),
        ],
      ),
    );
  }

  Widget _buildBoardSection(
    BuildContext context,
    CalculatorState state,
    CalculatorController controller,
  ) {
    final isActive = state.selectionTarget == SelectionTarget.board;

    return GestureDetector(
      onTap: () => controller.setSelectionTarget(SelectionTarget.board),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.amber.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? Colors.amber.withValues(alpha: 0.5)
                : Colors.white12,
            width: isActive ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'COMMUNITY CARDS',
                  style: GoogleFonts.roboto(
                    color: isActive ? Colors.amber : Colors.white54,
                    fontSize: 12,
                    letterSpacing: 1.5,
                  ),
                ),
                if (state.boardCards.isNotEmpty)
                  GestureDetector(
                    onTap: controller.clearBoard,
                    child: Text(
                      'CLEAR',
                      style: GoogleFonts.roboto(
                        color: Colors.red.shade300,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                final cardWidth =
                    (availableWidth - 40) / 5; // 40 = padding between cards
                final cardHeight = cardWidth * 1.4;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final card = index < state.boardCards.length
                        ? state.boardCards[index]
                        : null;
                    final isNextEmpty = state.boardCards.length == index;

                    return PlayingCardWidget(
                      card: card,
                      isEmpty: card == null,
                      isSelected: isActive && isNextEmpty,
                      width: cardWidth,
                      height: cardHeight,
                      onRemove: card != null
                          ? () => controller.removeCardFromBoard(index)
                          : null,
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerHandSection(
    BuildContext context,
    CalculatorState state,
    CalculatorController controller,
  ) {
    final isActive = state.selectionTarget == SelectionTarget.playerHand;

    return GestureDetector(
      onTap: () => controller.setSelectionTarget(SelectionTarget.playerHand),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.lightGreenAccent.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? Colors.lightGreenAccent.withValues(alpha: 0.5)
                : Colors.white12,
            width: isActive ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              'YOUR HAND',
              style: GoogleFonts.roboto(
                color: isActive ? Colors.lightGreenAccent : Colors.white54,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                final card = index < state.playerHand.length
                    ? state.playerHand[index]
                    : null;
                return PlayingCardWidget(
                  card: card,
                  isEmpty: card == null,
                  isSelected: isActive && card == null,
                  width: 70,
                  height: 98,
                  onRemove: card != null
                      ? () => controller.removeCardFromHand(index)
                      : null,
                );
              }),
            ),
            if (state.currentHandRank != null) ...[
              const SizedBox(height: 12),
              Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.amber.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      state.currentHandRank!,
                      style: GoogleFonts.roboto(
                        color: Colors.amber,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    curve: Curves.elasticOut,
                  )
                  .shimmer(
                    delay: 300.ms,
                    duration: 1000.ms,
                    color: Colors.amber.withValues(alpha: 0.3),
                  ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOpponentSelector(WidgetRef ref) {
    final state = ref.watch(calculatorControllerProvider);
    final controller = ref.read(calculatorControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'OPPONENTS: ',
            style: GoogleFonts.roboto(
              color: Colors.white54,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 16),
          ...List.generate(6, (index) {
            final count = index + 1;
            final isSelected = state.opponentCount == count;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => controller.setOpponentCount(count),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.lightGreenAccent
                        : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? Colors.lightGreenAccent
                          : Colors.white24,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      count.toString(),
                      style: GoogleFonts.robotoMono(
                        color: isSelected ? Colors.black : Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCalculateButton(
    CalculatorState state,
    CalculatorController controller,
  ) {
    final canCalculate = state.canCalculate && !state.isCalculating;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: canCalculate ? () => controller.calculateEquity() : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canCalculate
              ? Colors.lightGreenAccent
              : Colors.grey.shade800,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: canCalculate ? 4 : 0,
        ),
        child: state.isCalculating
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'CALCULATE EQUITY',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
      ),
    );
  }
}
