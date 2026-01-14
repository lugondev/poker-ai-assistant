enum HandRank {
  highCard(1, 'High Card'),
  onePair(2, 'One Pair'),
  twoPair(3, 'Two Pair'),
  threeOfAKind(4, 'Three of a Kind'),
  straight(5, 'Straight'),
  flush(6, 'Flush'),
  fullHouse(7, 'Full House'),
  fourOfAKind(8, 'Four of a Kind'),
  straightFlush(9, 'Straight Flush'),
  royalFlush(10, 'Royal Flush');

  final int value;
  final String displayName;

  const HandRank(this.value, this.displayName);

  bool operator >(HandRank other) => value > other.value;
  bool operator <(HandRank other) => value < other.value;
  bool operator >=(HandRank other) => value >= other.value;
  bool operator <=(HandRank other) => value <= other.value;
}

class EvaluatedHand {
  final HandRank rank;
  final List<int> tiebreakers;

  const EvaluatedHand({required this.rank, required this.tiebreakers});

  int compareTo(EvaluatedHand other) {
    if (rank.value != other.rank.value) {
      return rank.value.compareTo(other.rank.value);
    }

    for (
      var i = 0;
      i < tiebreakers.length && i < other.tiebreakers.length;
      i++
    ) {
      if (tiebreakers[i] != other.tiebreakers[i]) {
        return tiebreakers[i].compareTo(other.tiebreakers[i]);
      }
    }

    return 0;
  }
}
