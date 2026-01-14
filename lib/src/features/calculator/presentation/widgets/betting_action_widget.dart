import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/player.dart';

/// Widget to display and select betting actions
class BettingActionSelector extends StatelessWidget {
  final BettingRound currentRound;
  final void Function(BettingAction action, double? amount) onActionSelected;
  final double? currentBet;
  final double potSize;

  const BettingActionSelector({
    super.key,
    required this.currentRound,
    required this.onActionSelected,
    this.currentBet,
    this.potSize = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Action - ${currentRound.displayName}',
                style: GoogleFonts.roboto(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (potSize > 0)
                Text(
                  'Pot: \$${potSize.toStringAsFixed(0)}',
                  style: GoogleFonts.robotoMono(
                    color: Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _ActionChip(
                label: 'Fold',
                color: Colors.red.shade700,
                onTap: () => onActionSelected(BettingAction.fold, null),
              ),
              const SizedBox(width: 8),
              _ActionChip(
                label: currentBet == null || currentBet == 0 ? 'Check' : 'Call',
                color: Colors.blue.shade700,
                onTap: () => onActionSelected(
                  currentBet == null || currentBet == 0
                      ? BettingAction.check
                      : BettingAction.call,
                  currentBet,
                ),
              ),
              const SizedBox(width: 8),
              _ActionChip(
                label: currentBet == null || currentBet == 0 ? 'Bet' : 'Raise',
                color: Colors.green.shade700,
                onTap: () => _showBetDialog(context),
              ),
              const SizedBox(width: 8),
              _ActionChip(
                label: 'All-In',
                color: Colors.purple.shade700,
                onTap: () => onActionSelected(BettingAction.allIn, null),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBetDialog(BuildContext context) {
    final controller = TextEditingController();
    final isBet = currentBet == null || currentBet == 0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          isBet ? 'Enter Bet Amount' : 'Enter Raise Amount',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Amount',
            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixText: '\$ ',
            prefixStyle: const TextStyle(color: Colors.white),
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
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.roboto(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(controller.text);
              if (amount != null && amount > 0) {
                onActionSelected(
                  isBet ? BettingAction.bet : BettingAction.raise,
                  amount,
                );
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              'Confirm',
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionChip({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget to display betting history
class BettingHistoryWidget extends StatelessWidget {
  final List<PlayerAction> actions;
  final List<String> playerNames;

  const BettingHistoryWidget({
    super.key,
    required this.actions,
    required this.playerNames,
  });

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    // Group actions by round
    final groupedActions = <BettingRound, List<PlayerAction>>{};
    for (final action in actions) {
      groupedActions.putIfAbsent(action.round, () => []).add(action);
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Betting History',
            style: GoogleFonts.roboto(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ...groupedActions.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key.displayName,
                  style: GoogleFonts.roboto(
                    color: Colors.amber,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                ...entry.value.map((action) {
                  final playerName = _getPlayerName(action.playerId);
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 2),
                    child: Row(
                      children: [
                        Text(
                          '$playerName: ',
                          style: GoogleFonts.roboto(
                            color: Colors.white60,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          action.action.displayName,
                          style: GoogleFonts.roboto(
                            color: _getActionColor(action.action),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (action.amount > 0)
                          Text(
                            ' \$${action.amount.toStringAsFixed(0)}',
                            style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 6),
              ],
            );
          }),
        ],
      ),
    );
  }

  String _getPlayerName(String playerId) {
    if (playerId == 'hero') return 'Hero';
    final index = int.tryParse(playerId.replaceAll('player_', ''));
    if (index != null && index < playerNames.length) {
      return playerNames[index];
    }
    return playerId;
  }

  Color _getActionColor(BettingAction action) {
    switch (action) {
      case BettingAction.fold:
        return Colors.red;
      case BettingAction.check:
      case BettingAction.call:
        return Colors.blue;
      case BettingAction.bet:
      case BettingAction.raise:
        return Colors.green;
      case BettingAction.allIn:
        return Colors.purple;
    }
  }
}
