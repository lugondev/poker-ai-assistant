import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/card_entity.dart';

/// Layout mode for card selection
enum CardSelectorMode {
  /// Full grid: 13 columns x 4 rows (traditional layout)
  fullGrid,

  /// Two-step: Select rank first (2-A), then suit (♥♦♣♠)
  twoStep,
}

/// Shows the card selector bottom sheet
Future<PlayingCard?> showCardSelector({
  required BuildContext context,
  required Set<PlayingCard> usedCards,
}) async {
  return showModalBottomSheet<PlayingCard>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => CardSelectorBottomSheet(usedCards: usedCards),
  );
}

class CardSelectorBottomSheet extends StatefulWidget {
  final Set<PlayingCard> usedCards;

  const CardSelectorBottomSheet({super.key, required this.usedCards});

  @override
  State<CardSelectorBottomSheet> createState() =>
      _CardSelectorBottomSheetState();
}

class _CardSelectorBottomSheetState extends State<CardSelectorBottomSheet>
    with SingleTickerProviderStateMixin {
  // Default mode - can be changed by user toggle
  static CardSelectorMode _persistedMode = CardSelectorMode.fullGrid;

  CardSelectorMode _mode = _persistedMode;
  Rank? _selectedRank;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isCardUsed(PlayingCard card) {
    return widget.usedCards.any(
      (c) => c.rank == card.rank && c.suit == card.suit,
    );
  }

  void _selectCard(PlayingCard card) {
    if (!_isCardUsed(card)) {
      HapticFeedback.lightImpact();
      Navigator.of(context).pop(card);
    }
  }

  void _toggleMode() {
    HapticFeedback.selectionClick();
    setState(() {
      _mode = _mode == CardSelectorMode.fullGrid
          ? CardSelectorMode.twoStep
          : CardSelectorMode.fullGrid;
      _selectedRank = null;
      // Persist for next open
      _persistedMode = _mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 100 * (1 - _animation.value)),
          child: Opacity(opacity: _animation.value, child: child),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF1E1E32), const Color(0xFF12121C)],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.05, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: _mode == CardSelectorMode.fullGrid
                    ? _buildFullGridLayout()
                    : _buildTwoStepLayout(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 12),
          // Title and mode toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Card',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Mode toggle
              GestureDetector(
                onTap: _toggleMode,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _mode == CardSelectorMode.fullGrid
                            ? Icons.grid_view
                            : Icons.view_stream,
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _mode == CardSelectorMode.fullGrid
                            ? 'Grid'
                            : 'Two-Step',
                        style: GoogleFonts.roboto(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.swap_horiz, color: Colors.white54, size: 14),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============ FULL GRID LAYOUT ============
  Widget _buildFullGridLayout() {
    return Padding(
      key: const ValueKey('fullGrid'),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: Suit.values.map((suit) => _buildSuitRow(suit)).toList(),
      ),
    );
  }

  Widget _buildSuitRow(Suit suit) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 12;
    final cardWidth = (availableWidth / 13) - 4;
    final clampedWidth = cardWidth.clamp(26.0, 38.0);
    final cardHeight = clampedWidth * 1.4;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Rank.values.map((rank) {
          final card = PlayingCard(rank: rank, suit: suit);
          final isUsed = _isCardUsed(card);

          return _GridCardCell(
            card: card,
            isUsed: isUsed,
            width: clampedWidth,
            height: cardHeight,
            onTap: () => _selectCard(card),
          );
        }).toList(),
      ),
    );
  }

  // ============ TWO-STEP LAYOUT ============
  Widget _buildTwoStepLayout() {
    return Padding(
      key: const ValueKey('twoStep'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_selectedRank == null) ...[
            // Step 1: Select Rank
            _buildRankSelectionStep(),
          ] else ...[
            // Step 2: Select Suit
            _buildSuitSelectionStep(),
          ],
        ],
      ),
    );
  }

  Widget _buildRankSelectionStep() {
    return Column(
      children: [
        Text(
          'Step 1: Select Rank',
          style: GoogleFonts.roboto(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 12),
        // Ranks: 2-9
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: Rank.values.take(8).map((rank) {
            return _RankButton(
              rank: rank,
              isAvailable: _isRankAvailable(rank),
              onTap: () => _selectRank(rank),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        // Ranks: T, J, Q, K, A
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Rank.values.skip(8).map((rank) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _RankButton(
                rank: rank,
                isAvailable: _isRankAvailable(rank),
                onTap: () => _selectRank(rank),
                isLarge: true,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  bool _isRankAvailable(Rank rank) {
    // Check if at least one suit is available for this rank
    return Suit.values.any((suit) {
      final card = PlayingCard(rank: rank, suit: suit);
      return !_isCardUsed(card);
    });
  }

  void _selectRank(Rank rank) {
    if (_isRankAvailable(rank)) {
      HapticFeedback.selectionClick();
      setState(() {
        _selectedRank = rank;
      });
    }
  }

  Widget _buildSuitSelectionStep() {
    return Column(
      children: [
        // Back button and title
        Row(
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() {
                  _selectedRank = null;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Step 2: Select Suit for ${_selectedRank!.symbol}',
              style: GoogleFonts.roboto(color: Colors.white54, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Suit buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: Suit.values.map((suit) {
            final card = PlayingCard(rank: _selectedRank!, suit: suit);
            final isUsed = _isCardUsed(card);

            return _SuitButton(
              suit: suit,
              rank: _selectedRank!,
              isUsed: isUsed,
              onTap: () => _selectCard(card),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

// ============ GRID CARD CELL ============
class _GridCardCell extends StatefulWidget {
  final PlayingCard card;
  final bool isUsed;
  final double width;
  final double height;
  final VoidCallback onTap;

  const _GridCardCell({
    required this.card,
    required this.isUsed,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  State<_GridCardCell> createState() => _GridCardCellState();
}

class _GridCardCellState extends State<_GridCardCell> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final suitColor = widget.card.suit.isRed
        ? const Color(0xFFE53935)
        : const Color(0xFF1A1A2E);

    return GestureDetector(
      onTapDown: widget.isUsed
          ? null
          : (_) => setState(() => _isPressed = true),
      onTapUp: widget.isUsed
          ? null
          : (_) {
              setState(() => _isPressed = false);
              widget.onTap();
            },
      onTapCancel: widget.isUsed
          ? null
          : () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            gradient: widget.isUsed
                ? null
                : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.grey.shade100],
                  ),
            color: widget.isUsed ? const Color(0xFF252538) : null,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: widget.isUsed
                  ? Colors.transparent
                  : _isPressed
                  ? suitColor.withValues(alpha: 0.8)
                  : Colors.grey.shade300,
              width: _isPressed ? 2 : 1,
            ),
            boxShadow: widget.isUsed
                ? null
                : [
                    BoxShadow(
                      color: _isPressed
                          ? suitColor.withValues(alpha: 0.4)
                          : Colors.black.withValues(alpha: 0.15),
                      blurRadius: _isPressed ? 8 : 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
          ),
          child: widget.isUsed
              ? Center(
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.grey.shade600,
                    size: widget.width * 0.5,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.card.rank.symbol,
                      style: TextStyle(
                        color: suitColor,
                        fontSize: widget.width * 0.45,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),
                    Text(
                      widget.card.suit.symbol,
                      style: TextStyle(
                        color: suitColor,
                        fontSize: widget.width * 0.4,
                        height: 1,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ============ RANK BUTTON (Two-Step Mode) ============
class _RankButton extends StatefulWidget {
  final Rank rank;
  final bool isAvailable;
  final VoidCallback onTap;
  final bool isLarge;

  const _RankButton({
    required this.rank,
    required this.isAvailable,
    required this.onTap,
    this.isLarge = false,
  });

  @override
  State<_RankButton> createState() => _RankButtonState();
}

class _RankButtonState extends State<_RankButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.isLarge ? 56.0 : 38.0;

    return GestureDetector(
      onTapDown: widget.isAvailable
          ? (_) => setState(() => _isPressed = true)
          : null,
      onTapUp: widget.isAvailable
          ? (_) {
              setState(() => _isPressed = false);
              widget.onTap();
            }
          : null,
      onTapCancel: widget.isAvailable
          ? () => setState(() => _isPressed = false)
          : null,
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: widget.isAvailable
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF3A3A5C), const Color(0xFF2A2A42)],
                  )
                : null,
            color: widget.isAvailable ? null : const Color(0xFF1A1A28),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isAvailable
                  ? _isPressed
                        ? Colors.amber
                        : Colors.white.withValues(alpha: 0.2)
                  : Colors.transparent,
              width: _isPressed ? 2 : 1,
            ),
            boxShadow: widget.isAvailable
                ? [
                    BoxShadow(
                      color: _isPressed
                          ? Colors.amber.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.3),
                      blurRadius: _isPressed ? 10 : 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              widget.rank.symbol,
              style: GoogleFonts.robotoMono(
                color: widget.isAvailable ? Colors.white : Colors.grey.shade700,
                fontSize: widget.isLarge ? 24 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============ SUIT BUTTON (Two-Step Mode) ============
class _SuitButton extends StatefulWidget {
  final Suit suit;
  final Rank rank;
  final bool isUsed;
  final VoidCallback onTap;

  const _SuitButton({
    required this.suit,
    required this.rank,
    required this.isUsed,
    required this.onTap,
  });

  @override
  State<_SuitButton> createState() => _SuitButtonState();
}

class _SuitButtonState extends State<_SuitButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isRed = widget.suit.isRed;
    final suitColor = isRed ? const Color(0xFFE53935) : const Color(0xFF2C2C3E);
    final bgColor = isRed ? const Color(0xFFFFF5F5) : const Color(0xFFF5F5F5);

    return GestureDetector(
      onTapDown: widget.isUsed
          ? null
          : (_) => setState(() => _isPressed = true),
      onTapUp: widget.isUsed
          ? null
          : (_) {
              setState(() => _isPressed = false);
              widget.onTap();
            },
      onTapCancel: widget.isUsed
          ? null
          : () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 72,
          height: 96,
          decoration: BoxDecoration(
            color: widget.isUsed ? const Color(0xFF252538) : bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isUsed
                  ? Colors.transparent
                  : _isPressed
                  ? suitColor
                  : Colors.grey.shade300,
              width: _isPressed ? 3 : 2,
            ),
            boxShadow: widget.isUsed
                ? null
                : [
                    BoxShadow(
                      color: _isPressed
                          ? suitColor.withValues(alpha: 0.4)
                          : Colors.black.withValues(alpha: 0.15),
                      blurRadius: _isPressed ? 12 : 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: widget.isUsed
              ? Center(
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.grey.shade600,
                    size: 32,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.rank.symbol,
                      style: TextStyle(
                        color: suitColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.suit.symbol,
                      style: TextStyle(
                        color: suitColor,
                        fontSize: 32,
                        height: 1,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
