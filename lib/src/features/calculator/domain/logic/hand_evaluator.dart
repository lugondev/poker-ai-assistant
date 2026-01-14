import '../entities/card_entity.dart';
import '../entities/hand_rank.dart';

class HandEvaluator {
  EvaluatedHand evaluate(List<PlayingCard> cards) {
    if (cards.length < 5) {
      return const EvaluatedHand(rank: HandRank.highCard, tiebreakers: []);
    }

    final bestHand = _findBestFiveCardHand(cards);
    return _evaluateFiveCards(bestHand);
  }

  List<PlayingCard> _findBestFiveCardHand(List<PlayingCard> cards) {
    if (cards.length == 5) return cards;

    List<PlayingCard>? bestHand;
    EvaluatedHand? bestEval;

    final combinations = _getCombinations(cards, 5);
    for (final combo in combinations) {
      final eval = _evaluateFiveCards(combo);
      if (bestEval == null || eval.compareTo(bestEval) > 0) {
        bestEval = eval;
        bestHand = combo;
      }
    }

    return bestHand ?? cards.take(5).toList();
  }

  List<List<PlayingCard>> _getCombinations(List<PlayingCard> cards, int r) {
    final result = <List<PlayingCard>>[];
    _combine(cards, r, 0, [], result);
    return result;
  }

  void _combine(
    List<PlayingCard> cards,
    int r,
    int start,
    List<PlayingCard> current,
    List<List<PlayingCard>> result,
  ) {
    if (current.length == r) {
      result.add(List.from(current));
      return;
    }

    for (var i = start; i < cards.length; i++) {
      current.add(cards[i]);
      _combine(cards, r, i + 1, current, result);
      current.removeLast();
    }
  }

  EvaluatedHand _evaluateFiveCards(List<PlayingCard> cards) {
    final sortedCards = List<PlayingCard>.from(cards)
      ..sort((a, b) => b.rank.value.compareTo(a.rank.value));

    final isFlush = _isFlush(sortedCards);
    final straightHighCard = _getStraightHighCard(sortedCards);
    final isStraight = straightHighCard != null;

    if (isFlush && isStraight) {
      if (straightHighCard == 14) {
        return EvaluatedHand(
          rank: HandRank.royalFlush,
          tiebreakers: [straightHighCard],
        );
      }
      return EvaluatedHand(
        rank: HandRank.straightFlush,
        tiebreakers: [straightHighCard],
      );
    }

    final rankCounts = _getRankCounts(sortedCards);
    final sortedCounts = rankCounts.entries.toList()
      ..sort((a, b) {
        final countCompare = b.value.compareTo(a.value);
        if (countCompare != 0) return countCompare;
        return b.key.compareTo(a.key);
      });

    final counts = sortedCounts.map((e) => e.value).toList();
    final ranksOrdered = sortedCounts.map((e) => e.key).toList();

    if (counts.isNotEmpty && counts[0] == 4) {
      return EvaluatedHand(
        rank: HandRank.fourOfAKind,
        tiebreakers: ranksOrdered,
      );
    }

    if (counts.length >= 2 && counts[0] == 3 && counts[1] >= 2) {
      return EvaluatedHand(rank: HandRank.fullHouse, tiebreakers: ranksOrdered);
    }

    if (isFlush) {
      return EvaluatedHand(
        rank: HandRank.flush,
        tiebreakers: sortedCards.map((c) => c.rank.value).toList(),
      );
    }

    if (isStraight) {
      return EvaluatedHand(
        rank: HandRank.straight,
        tiebreakers: [straightHighCard],
      );
    }

    if (counts.isNotEmpty && counts[0] == 3) {
      return EvaluatedHand(
        rank: HandRank.threeOfAKind,
        tiebreakers: ranksOrdered,
      );
    }

    if (counts.length >= 2 && counts[0] == 2 && counts[1] == 2) {
      return EvaluatedHand(rank: HandRank.twoPair, tiebreakers: ranksOrdered);
    }

    if (counts.isNotEmpty && counts[0] == 2) {
      return EvaluatedHand(rank: HandRank.onePair, tiebreakers: ranksOrdered);
    }

    return EvaluatedHand(
      rank: HandRank.highCard,
      tiebreakers: sortedCards.map((c) => c.rank.value).toList(),
    );
  }

  bool _isFlush(List<PlayingCard> cards) {
    if (cards.isEmpty) return false;
    final suit = cards.first.suit;
    return cards.every((c) => c.suit == suit);
  }

  int? _getStraightHighCard(List<PlayingCard> cards) {
    final values = cards.map((c) => c.rank.value).toSet().toList()
      ..sort((a, b) => b.compareTo(a));

    if (values.length < 5) return null;

    for (var i = 0; i <= values.length - 5; i++) {
      if (values[i] - values[i + 4] == 4) {
        return values[i];
      }
    }

    if (values.contains(14) &&
        values.contains(5) &&
        values.contains(4) &&
        values.contains(3) &&
        values.contains(2)) {
      return 5;
    }

    return null;
  }

  Map<int, int> _getRankCounts(List<PlayingCard> cards) {
    final counts = <int, int>{};
    for (final card in cards) {
      counts[card.rank.value] = (counts[card.rank.value] ?? 0) + 1;
    }
    return counts;
  }
}
