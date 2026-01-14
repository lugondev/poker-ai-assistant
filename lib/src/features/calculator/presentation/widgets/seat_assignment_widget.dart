import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/game_settings.dart';
import '../../domain/entities/player.dart';

/// Widget for visual table seat assignment with circular poker table layout
class SeatAssignmentWidget extends StatefulWidget {
  final List<Player> players;
  final int dealerButtonIndex;
  final void Function(int newDealerIndex) onDealerChanged;
  final void Function(int oldIndex, int newIndex) onPlayersReordered;
  final VoidCallback? onClose;

  const SeatAssignmentWidget({
    super.key,
    required this.players,
    required this.dealerButtonIndex,
    required this.onDealerChanged,
    required this.onPlayersReordered,
    this.onClose,
  });

  @override
  State<SeatAssignmentWidget> createState() => _SeatAssignmentWidgetState();
}

class _SeatAssignmentWidgetState extends State<SeatAssignmentWidget> {
  late int _selectedDealerIndex;
  int? _draggedPlayerIndex;

  @override
  void initState() {
    super.initState();
    _selectedDealerIndex = widget.dealerButtonIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildTableVisualization(),
          _buildInstructions(),
          _buildPositionLegend(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.event_seat, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Table Positions',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: widget.onClose,
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTableVisualization() {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final centerX = constraints.maxWidth / 2;
          final centerY = constraints.maxHeight / 2;
          final tableRadiusX = constraints.maxWidth * 0.38;
          final tableRadiusY = constraints.maxHeight * 0.35;
          final seatRadius = constraints.maxWidth * 0.44;
          final seatRadiusY = constraints.maxHeight * 0.42;

          return Stack(
            children: [
              // Poker table (oval)
              Center(
                child: Container(
                  width: tableRadiusX * 2,
                  height: tableRadiusY * 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.green.shade800, Colors.green.shade900],
                    ),
                    borderRadius: BorderRadius.circular(tableRadiusX),
                    border: Border.all(color: Colors.brown.shade700, width: 8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'TAP SEAT',
                          style: GoogleFonts.roboto(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'TO SET BTN',
                          style: GoogleFonts.roboto(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Player seats arranged around the table
              ...List.generate(widget.players.length, (index) {
                final angle = _getSeatAngle(index, widget.players.length);
                final x = centerX + seatRadius * math.cos(angle);
                final y = centerY + seatRadiusY * math.sin(angle);

                return Positioned(
                  left: x - 36,
                  top: y - 36,
                  child: _buildSeat(index),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  double _getSeatAngle(int index, int totalPlayers) {
    // Start from bottom center and go clockwise
    const startAngle = math.pi / 2; // Bottom
    final angleStep = 2 * math.pi / totalPlayers;
    return startAngle + (index * angleStep);
  }

  Widget _buildSeat(int playerIndex) {
    final player = widget.players[playerIndex];
    final position = _getPositionForSeat(playerIndex);
    final isDealer = playerIndex == _selectedDealerIndex;
    final isSB = position == PlayerPosition.sb;
    final isBB = position == PlayerPosition.bb;
    final isDragged = _draggedPlayerIndex == playerIndex;

    return GestureDetector(
      onTap: () => _setDealerPosition(playerIndex),
      onLongPress: () => setState(() => _draggedPlayerIndex = playerIndex),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDragged
              ? Colors.blue.withValues(alpha: 0.3)
              : player.isHero
              ? Colors.amber.shade800
              : Colors.grey.shade800,
          border: Border.all(
            color: isDealer
                ? Colors.blue
                : isSB || isBB
                ? Colors.orange
                : Colors.grey.shade600,
            width: isDealer || isSB || isBB ? 3 : 2,
          ),
          boxShadow: isDealer
              ? [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            // Player info
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    player.isHero ? 'Hero' : 'P${player.index + 1}',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getPositionColor(position),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      position?.shortName ?? '?',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Dealer button indicator
            if (isDealer)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Text(
                      'D',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  PlayerPosition? _getPositionForSeat(int seatIndex) {
    final positions = PlayerPosition.getPositionsForPlayerCount(
      widget.players.length,
    );
    final relativeIndex =
        (seatIndex - _selectedDealerIndex + widget.players.length) %
        widget.players.length;
    if (relativeIndex < positions.length) {
      return positions[relativeIndex];
    }
    return null;
  }

  Color _getPositionColor(PlayerPosition? position) {
    if (position == null) return Colors.grey.shade600;
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

  void _setDealerPosition(int playerIndex) {
    setState(() {
      _selectedDealerIndex = playerIndex;
    });
  }

  Widget _buildInstructions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade800.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue.shade300, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Tap a seat to assign the Dealer Button (BTN). SB and BB will be assigned automatically to the next players.',
                style: GoogleFonts.roboto(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionLegend() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem('BTN', Colors.blue.shade700, 'Dealer'),
          const SizedBox(width: 16),
          _buildLegendItem('SB', Colors.orange.shade700, 'Small Blind'),
          const SizedBox(width: 16),
          _buildLegendItem('BB', Colors.orange.shade700, 'Big Blind'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String description) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          description,
          style: GoogleFonts.roboto(color: Colors.white54, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: widget.onClose,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.roboto(color: Colors.white70, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                widget.onDealerChanged(_selectedDealerIndex);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Apply',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Quick position selector popup for inline position changes
class PositionSelectorPopup extends StatelessWidget {
  final List<Player> players;
  final int currentPlayerIndex;
  final int dealerButtonIndex;
  final void Function(int newDealerIndex) onDealerChanged;

  const PositionSelectorPopup({
    super.key,
    required this.players,
    required this.currentPlayerIndex,
    required this.dealerButtonIndex,
    required this.onDealerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assign Position',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Set this player as:',
            style: GoogleFonts.roboto(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPositionButton(
                context,
                'BTN',
                Colors.blue.shade700,
                'Dealer',
                () {
                  // Set current player as dealer
                  onDealerChanged(currentPlayerIndex);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 8),
              _buildPositionButton(
                context,
                'SB',
                Colors.orange.shade700,
                'Small Blind',
                () {
                  // Set the previous player as dealer so current is SB
                  final newDealer =
                      (currentPlayerIndex - 1 + players.length) %
                      players.length;
                  onDealerChanged(newDealer);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 8),
              _buildPositionButton(
                context,
                'BB',
                Colors.orange.shade700,
                'Big Blind',
                () {
                  // Set 2 positions back as dealer so current is BB
                  final newDealer =
                      (currentPlayerIndex - 2 + players.length) %
                      players.length;
                  onDealerChanged(newDealer);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPositionButton(
    BuildContext context,
    String label,
    Color color,
    String tooltip,
    VoidCallback onTap,
  ) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows a modal bottom sheet with seat assignment
Future<int?> showSeatAssignmentModal(
  BuildContext context, {
  required List<Player> players,
  required int dealerButtonIndex,
  required void Function(int oldIndex, int newIndex) onPlayersReordered,
}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) => SeatAssignmentWidget(
        players: players,
        dealerButtonIndex: dealerButtonIndex,
        onDealerChanged: (newIndex) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(newIndex);
          }
        },
        onPlayersReordered: onPlayersReordered,
        onClose: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
    ),
  );
}

/// Shows a popup for quick position assignment
void showPositionSelectorPopup(
  BuildContext context, {
  required List<Player> players,
  required int currentPlayerIndex,
  required int dealerButtonIndex,
  required void Function(int newDealerIndex) onDealerChanged,
  required Offset position,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        // Dismiss on tap outside
        Positioned.fill(
          child: GestureDetector(
            onTap: () => entry.remove(),
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          left: position.dx - 80,
          top: position.dy + 10,
          child: Material(
            color: Colors.transparent,
            child: PositionSelectorPopup(
              players: players,
              currentPlayerIndex: currentPlayerIndex,
              dealerButtonIndex: dealerButtonIndex,
              onDealerChanged: (newIndex) {
                onDealerChanged(newIndex);
                entry.remove();
              },
            ),
          ),
        ),
      ],
    ),
  );

  overlay.insert(entry);
}
