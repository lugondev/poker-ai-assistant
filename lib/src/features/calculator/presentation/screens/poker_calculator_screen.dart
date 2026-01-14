import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/game_settings.dart';
import '../../domain/entities/player.dart';
import '../providers/calculator_controller.dart';
import '../providers/calculator_state.dart';
import '../widgets/betting_action_widget.dart';
import '../widgets/card_selector_widget.dart';
import '../widgets/game_settings_widget.dart';
import '../widgets/player_stats_widget.dart';
import '../widgets/playing_card_widget.dart';
import '../widgets/range_selector_widget.dart';
import '../widgets/seat_assignment_widget.dart';

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
            _buildHeader(context, state, controller),
            _buildGameInfoBar(state, controller),
            _buildBoardPhaseTabs(state, controller),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _buildBoardSection(context, state, controller),
                    const SizedBox(height: 12),
                    _buildPotAndOddsSection(state),
                    const SizedBox(height: 12),
                    _buildPlayersHeader(context, state, controller),
                    const SizedBox(height: 8),
                    ...state.players.map(
                      (player) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _PlayerRow(
                          player: player,
                          isSelected: state.selectedPlayerIndex == player.index,
                          gameSettings: state.gameSettings,
                          players: state.players,
                          dealerButtonIndex: state.dealerButtonIndex,
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
                          onStackChanged: (newStack) => controller
                              .updatePlayerStack(player.index, newStack),
                          onDealerChanged: controller.setDealerPosition,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildBettingSection(state, controller),
                    const SizedBox(height: 16),
                    _buildActionButtons(context, state, controller),
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

  Widget _buildHeader(
    BuildContext context,
    CalculatorState state,
    CalculatorController controller,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // App Logo
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/logo-transparent.png',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Poker AA',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Settings button
              IconButton(
                onPressed: () => _showGameSettings(context, state, controller),
                icon: const Icon(Icons.settings, color: Colors.white70),
                tooltip: 'Game Settings',
              ),
              // New Hand button
              TextButton(
                onPressed: controller.startNewHand,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'New Hand',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGameInfoBar(
    CalculatorState state,
    CalculatorController controller,
  ) {
    final settings = state.gameSettings;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade800.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoChip(
            'Blinds',
            '${settings.formatAmount(settings.smallBlind)}/${settings.formatAmount(settings.bigBlind)}',
          ),
          if (settings.ante > 0)
            _buildInfoChip('Ante', settings.formatAmount(settings.ante)),
          _buildInfoChip(
            'Stack',
            settings.formatStackInBB(settings.defaultStack),
          ),
          _buildInfoChip(settings.gameType.displayName, ''),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(color: Colors.white54, fontSize: 10),
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Future<void> _showGameSettings(
    BuildContext context,
    CalculatorState state,
    CalculatorController controller,
  ) async {
    final newSettings = await showGameSettingsModal(
      context,
      currentSettings: state.gameSettings,
    );

    if (newSettings != null) {
      controller.updateGameSettings(newSettings);
    }
  }

  Widget _buildBoardPhaseTabs(
    CalculatorState state,
    CalculatorController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

  Widget _buildPotAndOddsSection(CalculatorState state) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildOddsItem(
            'Pot',
            state.gameSettings.formatAmount(state.potSize),
            Colors.amber,
          ),
          _buildOddsItem(
            'To Call',
            state.gameSettings.formatAmount(state.amountToCall),
            Colors.orange,
          ),
          _buildOddsItem('Pot Odds', state.potOddsRatio, Colors.cyan),
          _buildOddsItem(
            'Need Equity',
            '${state.requiredEquityToCall.toStringAsFixed(1)}%',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildOddsItem(String label, String value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(color: Colors.white54, fontSize: 10),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.robotoMono(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayersHeader(
    BuildContext context,
    CalculatorState state,
    CalculatorController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Players: ${state.playerCount}',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            // Table positions button
            GestureDetector(
              onTap: () => _showSeatAssignment(context, state, controller),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.event_seat, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Seats',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            if (state.heroHandRank != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.amber.withValues(alpha: 0.5),
                  ),
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
        ),
      ],
    );
  }

  Future<void> _showSeatAssignment(
    BuildContext context,
    CalculatorState state,
    CalculatorController controller,
  ) async {
    final newDealerIndex = await showSeatAssignmentModal(
      context,
      players: state.players,
      dealerButtonIndex: state.dealerButtonIndex,
      onPlayersReordered: controller.reorderPlayers,
    );

    if (newDealerIndex != null) {
      controller.setDealerPosition(newDealerIndex);
    }
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
          currentBet: state.bettingState.currentBet,
          onActionSelected: (action, amount) {
            // Find current player to act
            final currentPlayerIndex = state.currentTurnIndex >= 0
                ? state.currentTurnIndex
                : state.players.indexWhere((p) => p.isHero);

            if (currentPlayerIndex >= 0) {
              controller.processAction(
                playerIndex: currentPlayerIndex,
                action: action,
                amount: amount ?? 0,
              );
            }
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
    BuildContext context,
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
              backgroundColor: Colors.grey.shade700,
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
            gradient: LinearGradient(
              colors: [Colors.green.shade600, Colors.green.shade800],
            ),
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
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.calculate, color: Colors.white),
            tooltip: 'Calculate Equity',
          ),
        ),
      ],
    );
  }
}

class _PlayerRow extends StatelessWidget {
  final Player player;
  final bool isSelected;
  final GameSettings gameSettings;
  final List<Player> players;
  final int dealerButtonIndex;
  final VoidCallback onSelect;
  final VoidCallback? onRemove;
  final void Function(int) onRemoveCard;
  final void Function(Set<String>) onRangeSelected;
  final VoidCallback onShowStats;
  final void Function(double) onStackChanged;
  final void Function(int) onDealerChanged;

  const _PlayerRow({
    required this.player,
    required this.isSelected,
    required this.gameSettings,
    required this.players,
    required this.dealerButtonIndex,
    required this.onSelect,
    this.onRemove,
    required this.onRemoveCard,
    required this.onRangeSelected,
    required this.onShowStats,
    required this.onStackChanged,
    required this.onDealerChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isUsingRange = player.useRange && !player.isHero;
    final isFolded = player.isFolded;
    final isCurrentTurn = player.isCurrentTurn;

    return GestureDetector(
      onTap: onSelect,
      child: Opacity(
        opacity: isFolded ? 0.5 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isCurrentTurn
                  ? Colors.green
                  : isSelected
                  ? Colors.amber
                  : Colors.transparent,
              width: isCurrentTurn ? 3 : 2,
            ),
          ),
          child: Column(
            children: [
              // Player header
              _buildPlayerHeader(
                context,
                isUsingRange,
                isFolded,
                isCurrentTurn,
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
                    const SizedBox(width: 12),
                    // Equity and stack display
                    Expanded(child: _buildEquityAndStackDisplay(context)),
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
      ),
    ).animate().fadeIn(duration: 200.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildPlayerHeader(
    BuildContext context,
    bool isUsingRange,
    bool isFolded,
    bool isCurrentTurn,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: player.isHero
            ? Colors.amber.shade800
            : isCurrentTurn
            ? Colors.green.shade700
            : Colors.grey.shade700,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
      ),
      child: Row(
        children: [
          // Position badge - tappable to change position
          if (player.position != null)
            GestureDetector(
              onTap: () => _showPositionSelector(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: _getPositionColor(player.position!),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      player.position!.shortName,
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.edit,
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 10,
                    ),
                  ],
                ),
              ),
            ),
          // Player name and status
          if (player.isHero)
            const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.star, color: Colors.white, size: 14),
            ),
          Text(
            player.displayName,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 13,
              fontWeight: player.isHero ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isFolded)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'FOLDED',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (player.isAllIn)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'ALL-IN',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isCurrentTurn)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'YOUR TURN',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const Spacer(),
          // Range indicator
          if (isUsingRange)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                player.rangeDescription.isNotEmpty
                    ? player.rangeDescription
                    : 'Range',
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 10),
              ),
            ),
        ],
      ),
    );
  }

  Color _getPositionColor(PlayerPosition position) {
    switch (position) {
      case PlayerPosition.btn:
        return Colors.blue.shade700;
      case PlayerPosition.sb:
      case PlayerPosition.bb:
        return Colors.orange.shade700;
      default:
        return Colors.grey.shade600;
    }
  }

  void _showPositionSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Set ${player.displayName} as:',
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionOption(
              dialogContext,
              'BTN',
              'Dealer Button',
              Colors.blue.shade700,
              () {
                onDealerChanged(player.index);
                Navigator.of(dialogContext).pop();
              },
            ),
            const SizedBox(height: 8),
            _buildPositionOption(
              dialogContext,
              'SB',
              'Small Blind',
              Colors.orange.shade700,
              () {
                // Set dealer to previous player
                final newDealer =
                    (player.index - 1 + players.length) % players.length;
                onDealerChanged(newDealer);
                Navigator.of(dialogContext).pop();
              },
            ),
            const SizedBox(height: 8),
            _buildPositionOption(
              dialogContext,
              'BB',
              'Big Blind',
              Colors.orange.shade700,
              () {
                // Set dealer to 2 positions back
                final newDealer =
                    (player.index - 2 + players.length) % players.length;
                onDealerChanged(newDealer);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.roboto(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionOption(
    BuildContext context,
    String position,
    String description,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                position,
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              description,
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 16,
            ),
          ],
        ),
      ),
    );
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

  Widget _buildEquityAndStackDisplay(BuildContext context) {
    final equity = player.equity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stack display
        GestureDetector(
          onTap: () => _showStackEditDialog(context),
          child: Row(
            children: [
              Icon(
                Icons.monetization_on,
                color: Colors.amber.shade300,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                player.formatStack(gameSettings.currencySymbol),
                style: GoogleFonts.robotoMono(
                  color: Colors.amber,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${gameSettings.formatStackInBB(player.stack)})',
                style: GoogleFonts.roboto(color: Colors.white54, fontSize: 10),
              ),
            ],
          ),
        ),
        if (player.currentBet > 0)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              'Bet: ${gameSettings.formatAmount(player.currentBet)}',
              style: GoogleFonts.roboto(color: Colors.orange, fontSize: 11),
            ),
          ),
        const SizedBox(height: 4),
        // Equity stats
        if (equity == null) ...[
          _buildStatRow('Equity', '--'),
          _buildStatRow('Win', '--'),
        ] else ...[
          _buildStatRow(
            'Equity',
            '${equity.equity.toStringAsFixed(1)}%',
            isLarge: true,
          ),
          _buildStatRow('Win', '${equity.winPercentage.toStringAsFixed(1)}%'),
        ],
      ],
    );
  }

  void _showStackEditDialog(BuildContext context) {
    final controller = TextEditingController(
      text: player.stack.toStringAsFixed(0),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Edit Stack - ${player.displayName}',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixText: gameSettings.currencySymbol,
            prefixStyle: const TextStyle(color: Colors.white70),
            hintText: 'Enter stack amount',
            hintStyle: TextStyle(color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (Navigator.of(dialogContext).canPop()) {
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.roboto(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newStack = double.tryParse(controller.text);
              if (newStack != null && newStack > 0) {
                onStackChanged(newStack);
                if (Navigator.of(dialogContext).canPop()) {
                  Navigator.of(dialogContext).pop();
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text('Save', style: GoogleFonts.roboto(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, {bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          SizedBox(
            width: 45,
            child: Text(
              label,
              style: GoogleFonts.roboto(color: Colors.white70, fontSize: 11),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: isLarge ? 16 : 12,
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
