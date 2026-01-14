import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/player.dart';

/// Widget for displaying detailed player statistics
class PlayerStatsWidget extends StatelessWidget {
  final Player player;
  final List<String> boardCards;
  final VoidCallback? onClose;

  const PlayerStatsWidget({
    super.key,
    required this.player,
    this.boardCards = const [],
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final equity = player.equity;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: player.isHero
                  ? Colors.amber.shade800
                  : Colors.grey.shade800,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      player.isHero ? Icons.star : Icons.person,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      player.displayName,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hand info
                _buildSection('Hand Information', [
                  _buildInfoRow('Cards', _getCardsDisplay()),
                  if (player.useRange)
                    _buildInfoRow('Range', player.rangeDescription),
                ]),

                const SizedBox(height: 16),

                // Equity Stats
                if (equity != null) ...[
                  _buildSection('Equity Statistics', [
                    _buildEquityBar('Win', equity.winPercentage, Colors.green),
                    _buildEquityBar('Tie', equity.tiePercentage, Colors.amber),
                    _buildEquityBar('Lose', equity.losePercentage, Colors.red),
                  ]),

                  const SizedBox(height: 16),

                  // Overall Equity
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Equity: ',
                          style: GoogleFonts.roboto(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${equity.equity.toStringAsFixed(2)}%',
                          style: GoogleFonts.robotoMono(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Additional Stats
                  _buildSection('Detailed Breakdown', [
                    _buildInfoRow(
                      'Win Rate',
                      '${equity.winPercentage.toStringAsFixed(2)}%',
                    ),
                    _buildInfoRow(
                      'Tie Rate',
                      '${equity.tiePercentage.toStringAsFixed(2)}%',
                    ),
                    _buildInfoRow(
                      'Lose Rate',
                      '${equity.losePercentage.toStringAsFixed(2)}%',
                    ),
                    _buildInfoRow('Expected Value', _calculateEV(equity)),
                  ]),
                ] else
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Text(
                        'Calculate equity to see statistics',
                        style: GoogleFonts.roboto(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Close button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCardsDisplay() {
    if (player.useRange) {
      return 'Using Range';
    }
    if (player.holeCards.isEmpty) {
      return 'No cards';
    }
    return player.holeCards.map((c) => c.displayName).join(' ');
  }

  String _calculateEV(PlayerEquity equity) {
    // Simple EV calculation assuming 1:1 pot odds
    final ev =
        (equity.winPercentage / 100) * 1 +
        (equity.tiePercentage / 100) * 0 +
        (equity.losePercentage / 100) * -1;
    final sign = ev >= 0 ? '+' : '';
    return '$sign${ev.toStringAsFixed(3)}';
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade800.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(color: Colors.white54, fontSize: 14),
          ),
          Text(
            value,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquityBar(String label, double percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.roboto(color: Colors.white70, fontSize: 13),
              ),
              Text(
                '${percentage.toStringAsFixed(2)}%',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade700,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows a modal bottom sheet with player stats
Future<void> showPlayerStatsModal(
  BuildContext context, {
  required Player player,
  List<String> boardCards = const [],
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) => PlayerStatsWidget(
        player: player,
        boardCards: boardCards,
        onClose: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
    ),
  );
}
