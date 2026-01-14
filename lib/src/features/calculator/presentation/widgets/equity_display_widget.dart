import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/logic/monte_carlo_engine.dart';

class EquityDisplayWidget extends StatelessWidget {
  final EquityResult? result;
  final bool isCalculating;

  const EquityDisplayWidget({
    super.key,
    this.result,
    this.isCalculating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0.4),
            Colors.black.withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: isCalculating ? _buildLoadingState() : _buildResultState(),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        const CircularProgressIndicator(
              color: Colors.lightGreenAccent,
              strokeWidth: 3,
            )
            .animate(onPlay: (controller) => controller.repeat())
            .rotate(duration: 1000.ms),
        const SizedBox(height: 12),
        const Text(
              'Calculating...',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            )
            .animate()
            .fadeIn(duration: 300.ms)
            .shimmer(
              duration: 1500.ms,
              color: Colors.lightGreenAccent.withValues(alpha: 0.3),
            ),
      ],
    );
  }

  Widget _buildResultState() {
    if (result == null) {
      return _buildEmptyState();
    }

    final equityColor = _getEquityColor(result!.equity);

    return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EQUITY',
                      style: GoogleFonts.roboto(
                        color: Colors.white54,
                        fontSize: 11,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                          '${result!.equity.toStringAsFixed(1)}%',
                          style: GoogleFonts.robotoMono(
                            color: equityColor,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .scale(
                          begin: const Offset(0.5, 0.5),
                          end: const Offset(1, 1),
                          duration: 400.ms,
                          curve: Curves.elasticOut,
                        ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'RECOMMENDATION',
                      style: GoogleFonts.roboto(
                        color: Colors.white54,
                        fontSize: 11,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: equityColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: equityColor.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            result!.recommendation,
                            style: GoogleFonts.robotoCondensed(
                              color: equityColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 300.ms)
                        .slideX(begin: 0.3, end: 0, duration: 300.ms),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildStatsRow(),
          ],
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.95, 0.95), duration: 300.ms);
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('WIN', result!.winPercentage, Colors.green, 0),
        _buildStatItem('TIE', result!.tiePercentage, Colors.amber, 1),
        _buildStatItem('LOSE', result!.losePercentage, Colors.red, 2),
      ],
    );
  }

  Widget _buildStatItem(String label, double value, Color color, int index) {
    return Column(
          children: [
            Text(
              label,
              style: GoogleFonts.roboto(
                color: Colors.white38,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${value.toStringAsFixed(1)}%',
              style: GoogleFonts.robotoMono(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 300 + index * 100))
        .slideY(begin: 0.3, end: 0, duration: 300.ms);
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Icon(Icons.casino_outlined, color: Colors.white24, size: 48)
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.1, 1.1),
              duration: 1500.ms,
            ),
        const SizedBox(height: 12),
        Text(
          'Select your cards and calculate',
          style: GoogleFonts.roboto(color: Colors.white38, fontSize: 14),
        ).animate().fadeIn(duration: 500.ms),
      ],
    );
  }

  Color _getEquityColor(double equity) {
    if (equity >= 70) return Colors.lightGreenAccent;
    if (equity >= 50) return Colors.greenAccent;
    if (equity >= 35) return Colors.amberAccent;
    if (equity >= 20) return Colors.orangeAccent;
    return Colors.redAccent;
  }
}
