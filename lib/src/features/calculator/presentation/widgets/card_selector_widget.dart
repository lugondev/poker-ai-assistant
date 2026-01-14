import 'package:flutter/material.dart';

import '../../domain/entities/card_entity.dart';

class CardSelectorWidget extends StatelessWidget {
  final Function(PlayingCard) onCardSelected;
  final Set<PlayingCard> usedCards;

  const CardSelectorWidget({
    super.key,
    required this.onCardSelected,
    required this.usedCards,
  });

  bool _isCardUsed(PlayingCard card) {
    return usedCards.any((c) => c.rank == card.rank && c.suit == card.suit);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ...Suit.values.map((suit) => _buildSuitRow(context, suit)),
        ],
      ),
    );
  }

  Widget _buildSuitRow(BuildContext context, Suit suit) {
    final suitColor = suit.isRed ? Colors.red.shade400 : Colors.grey.shade300;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 16) / 13 - 2;
    final clampedWidth = cardWidth.clamp(22.0, 30.0);
    final cardHeight = clampedWidth * 1.3;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: Rank.values.map((rank) {
          final card = PlayingCard(rank: rank, suit: suit);
          final isUsed = _isCardUsed(card);

          return Expanded(
            child: GestureDetector(
              onTap: isUsed ? null : () => onCardSelected(card),
              child: Container(
                height: cardHeight,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: isUsed
                      ? Colors.grey.shade800.withValues(alpha: 0.5)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isUsed ? Colors.grey.shade700 : Colors.grey.shade400,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rank.symbol,
                      style: TextStyle(
                        color: isUsed ? Colors.grey.shade600 : suitColor,
                        fontSize: clampedWidth * 0.45,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    Text(
                      suit.symbol,
                      style: TextStyle(
                        color: isUsed ? Colors.grey.shade600 : suitColor,
                        fontSize: clampedWidth * 0.4,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
