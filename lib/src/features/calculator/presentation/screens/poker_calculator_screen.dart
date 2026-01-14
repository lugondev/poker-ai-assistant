import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/player.dart';
import '../providers/calculator_controller.dart';
import '../providers/calculator_state.dart';
import '../widgets/betting_action_widget.dart';
import '../widgets/card_selector_widget.dart';
import '../widgets/player_stats_widget.dart';
import '../widgets/playing_card_widget.dart';
import '../widgets/range_selector_widget.dart';

class PokerCalculatorScreen extends ConsumerWidget {
  const PokerCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorControllerProvider);
    final controller = ref.read(calculatorControllerProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(controller),
            _buildBoardPhaseTabs(state, controller),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _buildBoardSection(context, state, controller),
                    const SizedBox(height: 16),
                    _buildPlayersHeader(state, controller),
                    const SizedBox(height: 8),
                    ...state.players.map(
                      (player) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _PlayerRow(
                          player: player,
                          isSelected: state.selectedPlayerIndex == player.index,
                          onSelect: () => controller.selectPlayer(player.index),
                          onRemove: player.isHero
                              ? null
                              : () => controller.removePlayer(player.index),
                          onRemoveCard: (cardIndex) => controller
                              .removeCardFromPlayer(player.index, cardIndex),
                          onRangeSelected: (range) =>
                              controller.setPlayerRange(player.index, range),
                          onShowStats: () =>
                              showPlayerStatsModal(context, player: player),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildBettingSection(state, controller),
                    const SizedBox(height: 16),
                    _buildActionButtons(state, controller),
                    const SizedBox(height: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Texas Hold\'em Equity Calculator',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: controller.reset,
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Menu',
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoardPhaseTabs(
    CalculatorState state,
    CalculatorController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: BoardPhase.values.map((phase) {
          final isSelected = state.boardPhase == phase;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.setBoardPhase(phase),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    phase.displayName,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.blue.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
            color: isActive ? Colors.blue : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final card = index < state.boardCards.length
                ? state.boardCards[index]
                : null;
            final isEnabled = index < state.boardPhase.cardCount;

            return Opacity(
              opacity: isEnabled ? 1.0 : 0.3,
              child: PlayingCardWidget(
                card: card,
                isEmpty: card == null,
                isSelected: isActive && card == null && isEnabled,
                width: 56,
                height: 78,
                showQuestionMark: card == null,
                onRemove: card != null
                    ? () => controller.removeCardFromBoard(index)
                    : null,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPlayersHeader(
    CalculatorState state,
    CalculatorController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Players remaining: ${state.playerCount}',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (state.heroHandRank != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
            ),
            child: Text(
              state.heroHandRank!,
              style: GoogleFonts.roboto(
                color: Colors.amber,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBettingSection(
    CalculatorState state,
    CalculatorController controller,
  ) {
    return Column(
      children: [
        BettingActionSelector(
          currentRound: controller.currentBettingRound,
          potSize: state.potSize,
          onActionSelected: (action, amount) {
            controller.addBettingAction(
              playerId: 'hero',
              action: action,
              amount: amount ?? 0,
            );
          },
        ),
        if (state.bettingHistory.isNotEmpty) ...[
          const SizedBox(height: 12),
          BettingHistoryWidget(
            actions: state.bettingHistory,
            playerNames: state.players.map((p) => p.displayName).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButtons(
    CalculatorState state,
    CalculatorController controller,
  ) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: state.canAddPlayer ? controller.addPlayer : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              '+ Player',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: controller.reset,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              'Clear',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: state.canCalculate
                ? () => controller.calculateEquity()
                : null,
            icon: state.isCalculating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.help_outline, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class _PlayerRow extends StatelessWidget {
  final Player player;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback? onRemove;
  final void Function(int) onRemoveCard;
  final void Function(Set<String>) onRangeSelected;
  final VoidCallback onShowStats;

  const _PlayerRow({
    required this.player,
    required this.isSelected,
    required this.onSelect,
    this.onRemove,
    required this.onRemoveCard,
    required this.onRangeSelected,
    required this.onShowStats,
  });

  @override
  Widget build(BuildContext context) {
    final isUsingRange = player.useRange && !player.isHero;

    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            // Player header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: player.isHero
                    ? Colors.amber.shade800
                    : Colors.grey.shade700,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (player.isHero)
                    const Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(Icons.star, color: Colors.white, size: 14),
                    ),
                  Text(
                    player.displayName,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: player.isHero
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  if (isUsingRange) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        player.rangeDescription.isNotEmpty
                            ? player.rangeDescription
                            : 'Range',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Player content
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  // Hole cards or Range indicator
                  if (isUsingRange)
                    _buildRangeIndicator(context)
                  else
                    Row(
                      children: List.generate(2, (index) {
                        final card = index < player.holeCards.length
                            ? player.holeCards[index]
                            : null;
                        return PlayingCardWidget(
                          card: card,
                          isEmpty: card == null,
                          isSelected: isSelected && card == null,
                          width: 52,
                          height: 72,
                          showQuestionMark: card == null,
                          onRemove: card != null
                              ? () => onRemoveCard(index)
                              : null,
                        );
                      }),
                    ),
                  const SizedBox(width: 16),
                  // Equity display
                  Expanded(child: _buildEquityDisplay()),
                  // Action buttons
                  Column(
                    children: [
                      if (onRemove != null)
                        _ActionButton(
                          label: 'X',
                          onTap: onRemove!,
                          color: Colors.red.shade700,
                        ),
                      const SizedBox(height: 4),
                      if (!player.isHero)
                        _ActionButton(
                          label: isUsingRange ? 'Cards' : 'Range',
                          onTap: () => _showRangeSelector(context),
                          color: isUsingRange ? Colors.orange : Colors.purple,
                        ),
                      const SizedBox(height: 4),
                      _ActionButton(
                        label: 'Stats',
                        onTap: onShowStats,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 200.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildRangeIndicator(BuildContext context) {
    return GestureDetector(
      onTap: () => _showRangeSelector(context),
      child: Container(
        width: 108,
        height: 72,
        decoration: BoxDecoration(
          color: Colors.purple.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.purple.withValues(alpha: 0.6),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.grid_view, color: Colors.purple.shade300, size: 24),
            const SizedBox(height: 4),
            Text(
              'Tap to edit',
              style: GoogleFonts.roboto(
                color: Colors.purple.shade300,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showRangeSelector(BuildContext context) async {
    if (player.isHero) return;

    final selectedRange = await showRangeSelectorModal(
      context,
      initialSelectedHands: player.selectedRange,
    );

    if (selectedRange != null) {
      onRangeSelected(selectedRange);
    }
  }

  Widget _buildEquityDisplay() {
    final equity = player.equity;

    if (equity == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatRow('Equity', '--'),
          _buildStatRow('Win', '--'),
          _buildStatRow('Tie', '--'),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatRow(
          'Equity',
          '${equity.equity.toStringAsFixed(2)}%',
          isLarge: true,
        ),
        _buildStatRow('Win', '${equity.winPercentage.toStringAsFixed(2)}%'),
        _buildStatRow('Tie', '${equity.tiePercentage.toStringAsFixed(2)}%'),
      ],
    );
  }

  Widget _buildStatRow(String label, String value, {bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: GoogleFonts.roboto(color: Colors.white70, fontSize: 12),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: isLarge ? 18 : 14,
              fontWeight: isLarge ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }
}
