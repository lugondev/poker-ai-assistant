import 'dart:isolate';
import 'dart:math';

import '../entities/card_entity.dart';
import 'hand_evaluator.dart';

/// Parameters for Monte Carlo simulation to pass to Isolate
class MonteCarloParams {
  final List<Map<String, int>> playerHandData;
  final List<Map<String, int>> communityCardsData;
  final int opponentCount;
  final int simulations;

  MonteCarloParams({
    required this.playerHandData,
    required this.communityCardsData,
    required this.opponentCount,
    required this.simulations,
  });

  static MonteCarloParams fromCards({
    required List<PlayingCard> playerHand,
    required List<PlayingCard> communityCards,
    required int opponentCount,
    required int simulations,
  }) {
    return MonteCarloParams(
      playerHandData: playerHand
          .map((c) => {'rank': c.rank.index, 'suit': c.suit.index})
          .toList(),
      communityCardsData: communityCards
          .map((c) => {'rank': c.rank.index, 'suit': c.suit.index})
          .toList(),
      opponentCount: opponentCount,
      simulations: simulations,
    );
  }

  List<PlayingCard> get playerHand => playerHandData
      .map(
        (m) => PlayingCard(
          rank: Rank.values[m['rank']!],
          suit: Suit.values[m['suit']!],
        ),
      )
      .toList();

  List<PlayingCard> get communityCards => communityCardsData
      .map(
        (m) => PlayingCard(
          rank: Rank.values[m['rank']!],
          suit: Suit.values[m['suit']!],
        ),
      )
      .toList();
}

/// Result data that can be passed back from Isolate
class MonteCarloResultData {
  final int wins;
  final int ties;
  final int losses;
  final int simulations;

  MonteCarloResultData({
    required this.wins,
    required this.ties,
    required this.losses,
    required this.simulations,
  });
}

class MonteCarloEngine {
  static const int defaultSimulations = 10000;

  /// Calculate equity using Isolate for better performance
  Future<EquityResult> calculateEquity({
    required List<PlayingCard> playerHand,
    required List<PlayingCard> communityCards,
    int opponentCount = 1,
    int simulations = defaultSimulations,
  }) async {
    if (playerHand.length != 2) {
      return const EquityResult(
        winPercentage: 0,
        tiePercentage: 0,
        losePercentage: 100,
        handStrength: 'Invalid Hand',
        simulationsRun: 0,
      );
    }

    final params = MonteCarloParams.fromCards(
      playerHand: playerHand,
      communityCards: communityCards,
      opponentCount: opponentCount,
      simulations: simulations,
    );

    // Run simulation in Isolate
    final resultData = await Isolate.run(() => _runSimulation(params));

    final winPercentage = (resultData.wins / resultData.simulations) * 100;
    final tiePercentage = (resultData.ties / resultData.simulations) * 100;
    final losePercentage = (resultData.losses / resultData.simulations) * 100;

    return EquityResult(
      winPercentage: winPercentage,
      tiePercentage: tiePercentage,
      losePercentage: losePercentage,
      handStrength: _getHandStrengthLabel(winPercentage),
      simulationsRun: resultData.simulations,
    );
  }

  /// Static function that runs in Isolate
  static MonteCarloResultData _runSimulation(MonteCarloParams params) {
    final evaluator = HandEvaluator();
    final random = Random();

    final playerHand = params.playerHand;
    final communityCards = params.communityCards;

    final usedCards = {...playerHand, ...communityCards};
    final deck = PlayingCard.fullDeck
        .where((card) => !usedCards.contains(card))
        .toList();

    int wins = 0;
    int ties = 0;
    int losses = 0;

    for (var i = 0; i < params.simulations; i++) {
      final result = _simulateHand(
        evaluator: evaluator,
        random: random,
        playerHand: playerHand,
        communityCards: communityCards,
        deck: List.from(deck),
        opponentCount: params.opponentCount,
      );

      switch (result) {
        case 1:
          wins++;
          break;
        case 0:
          ties++;
          break;
        case -1:
          losses++;
          break;
      }
    }

    return MonteCarloResultData(
      wins: wins,
      ties: ties,
      losses: losses,
      simulations: params.simulations,
    );
  }

  static int _simulateHand({
    required HandEvaluator evaluator,
    required Random random,
    required List<PlayingCard> playerHand,
    required List<PlayingCard> communityCards,
    required List<PlayingCard> deck,
    required int opponentCount,
  }) {
    _shuffleDeck(deck, random);

    final remainingCommunity = 5 - communityCards.length;
    final simulatedCommunity = List<PlayingCard>.from(communityCards);
    var deckIndex = 0;

    for (var i = 0; i < remainingCommunity; i++) {
      simulatedCommunity.add(deck[deckIndex++]);
    }

    final playerCards = [...playerHand, ...simulatedCommunity];
    final playerEval = evaluator.evaluate(playerCards);

    var playerWins = true;
    var isTie = false;

    for (var o = 0; o < opponentCount; o++) {
      final opponentHand = [deck[deckIndex++], deck[deckIndex++]];
      final opponentCards = [...opponentHand, ...simulatedCommunity];
      final opponentEval = evaluator.evaluate(opponentCards);

      final comparison = playerEval.compareTo(opponentEval);
      if (comparison < 0) {
        playerWins = false;
        isTie = false;
        break;
      } else if (comparison == 0) {
        isTie = true;
      }
    }

    if (!playerWins) return -1;
    if (isTie) return 0;
    return 1;
  }

  static void _shuffleDeck(List<PlayingCard> deck, Random random) {
    for (var i = deck.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = deck[i];
      deck[i] = deck[j];
      deck[j] = temp;
    }
  }

  static String _getHandStrengthLabel(double winPercentage) {
    if (winPercentage >= 75) return 'Monster';
    if (winPercentage >= 60) return 'Strong';
    if (winPercentage >= 45) return 'Good';
    if (winPercentage >= 30) return 'Marginal';
    if (winPercentage >= 15) return 'Weak';
    return 'Fold';
  }
}

class EquityResult {
  final double winPercentage;
  final double tiePercentage;
  final double losePercentage;
  final String handStrength;
  final int simulationsRun;

  const EquityResult({
    required this.winPercentage,
    required this.tiePercentage,
    required this.losePercentage,
    required this.handStrength,
    required this.simulationsRun,
  });

  double get equity => winPercentage + (tiePercentage / 2);

  String get recommendation {
    if (equity >= 70) return 'RAISE';
    if (equity >= 50) return 'CALL / RAISE';
    if (equity >= 35) return 'CALL';
    if (equity >= 20) return 'CHECK / FOLD';
    return 'FOLD';
  }
}
