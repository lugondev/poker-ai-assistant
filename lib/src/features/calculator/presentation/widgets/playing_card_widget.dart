import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../domain/entities/card_entity.dart';

class PlayingCardWidget extends StatelessWidget {
  final PlayingCard? card;
  final bool isEmpty;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;
  final double width;
  final double height;
  final bool showQuestionMark;

  const PlayingCardWidget({
    super.key,
    this.card,
    this.isEmpty = false,
    this.isSelected = false,
    this.onTap,
    this.onRemove,
    this.width = 60,
    this.height = 84,
    this.showQuestionMark = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmpty || card == null) {
      return _buildEmptySlot();
    }
    return _buildCard();
  }

  Widget _buildEmptySlot() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.grey.shade400,
            width: isSelected ? 2 : 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: showQuestionMark
              ? Text(
                  '?',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: height * 0.5,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Icon(
                  Icons.add,
                  color: isSelected ? Colors.amber : Colors.grey.shade400,
                  size: 24,
                ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    final cardData = card!;
    final color = cardData.suit.isRed
        ? Colors.red.shade600
        : Colors.grey.shade900;

    return GestureDetector(
          onTap: onTap,
          onLongPress: onRemove,
          child: Stack(
            children: [
              Container(
                width: width,
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  border: isSelected
                      ? Border.all(color: Colors.amber, width: 3)
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cardData.rank.symbol,
                      style: TextStyle(
                        color: color,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      cardData.suit.symbol,
                      style: TextStyle(color: color, fontSize: 20),
                    ),
                  ],
                ),
              ),
              if (onRemove != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 200.ms)
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 200.ms,
          curve: Curves.easeOutBack,
        );
  }
}
