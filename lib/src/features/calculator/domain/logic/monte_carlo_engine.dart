import 'dart:isolate';
import 'dart:math';

import '../entities/card_entity.dart';
import '../entities/hand_rank.dart';
import '../entities/player.dart';
import 'hand_evaluator.dart';

/// Parameters for Monte Carlo simulation to pass to Isolate
class MonteCarloParams {
  final List<Map<String, dynamic>> playersData;
  final List<Map<String, int>> communityCardsData;
  final int simulations;

  MonteCarloParams({
    required this.playersData,
    required this.communityCardsData,
    required this.simulations,
  });

  static MonteCarloParams fromPlayersAndCards({
    required List<Player> players,
    required List<PlayingCard> communityCards,
    required int simulations,
  }) {
    return MonteCarloParams(
      playersData: players.map((p) {
        return {
          'id': p.id,
          'holeCards': p.holeCards
              .map((c) => {'rank': c.rank.index, 'suit': c.suit.index})
              .toList(),
          'useRange': p.useRange,
        };
      }).toList(),
      communityCardsData: communityCards
          .map((c) => {'rank': c.rank.index, 'suit': c.suit.index})
          .toList(),
      simulations: simulations,
    );
  }
}

/// Result data that can be passed back from Isolate
class MonteCarloResultData {
  final Map<String, PlayerResultData> playerResults;
  final int simulations;

  MonteCarloResultData({
    required this.playerResults,
    required this.simulations,
  });
}

class PlayerResultData {
  final String playerId;
  final int wins;
  final int ties;
  final int losses;

  PlayerResultData({
    required this.playerId,
    required this.wins,
    required this.ties,
    required this.losses,
  });

  double get winPercentage => wins / (wins + ties + losses) * 100;
  double get tiePercentage => ties / (wins + ties + losses) * 100;
  double get losePercentage => losses / (wins + ties + losses) * 100;
}

class MonteCarloEngine {
  static const int defaultSimulations = 10000;

  /// Calculate equity for a single player against random opponents
  Future<EquityResult> calculateEquity({
    required List<PlayingCard> playerHand,
    required List<PlayingCard> communityCards,
    int opponentCount = 1,
    int simulations = defaultSimulations,
  }) async {
    // Create player list for multi-player calculation
    final players = <Player>[
      Player(id: 'hero', index: 0, isHero: true, holeCards: playerHand),
      for (var i = 0; i < opponentCount; i++)
        Player(id: 'opponent_$i', index: i + 1, useRange: true),
    ];

    final results = await calculateMultiPlayerEquity(
      players: players,
      communityCards: communityCards,
      simulations: simulations,
    );

    final heroResult = results['hero'];
    if (heroResult == null) {
      return const EquityResult(
        winPercentage: 0,
        tiePercentage: 0,
        losePercentage: 100,
        handStrength: 'Error',
        simulationsRun: 0,
      );
    }

    return EquityResult(
      winPercentage: heroResult.winPercentage,
      tiePercentage: heroResult.tiePercentage,
      losePercentage: heroResult.losePercentage,
      handStrength: _getHandStrengthLabel(heroResult.winPercentage),
      simulationsRun: simulations,
    );
  }

  /// Calculate equity for multiple players simultaneously
  Future<Map<String, EquityResult>> calculateMultiPlayerEquity({
    required List<Player> players,
    required List<PlayingCard> communityCards,
    int simulations = defaultSimulations,
  }) async {
    // Filter out players without cards and not using range
    final activePlayers = players
        .where((p) => p.holeCards.isNotEmpty || p.useRange)
        .toList();

    if (activePlayers.isEmpty) {
      return {};
    }

    final params = MonteCarloParams.fromPlayersAndCards(
      players: activePlayers,
      communityCards: communityCards,
      simulations: simulations,
    );

    // Run simulation in Isolate
    final resultData = await Isolate.run(
      () => _runMultiPlayerSimulation(params),
    );

    // Convert to EquityResult map
    final results = <String, EquityResult>{};
    for (final entry in resultData.playerResults.entries) {
      final playerResult = entry.value;
      results[entry.key] = EquityResult(
        winPercentage: playerResult.winPercentage,
        tiePercentage: playerResult.tiePercentage,
        losePercentage: playerResult.losePercentage,
        handStrength: _getHandStrengthLabel(playerResult.winPercentage),
        simulationsRun: simulations,
      );
    }

    return results;
  }

  /// Static function that runs in Isolate
  static MonteCarloResultData _runMultiPlayerSimulation(
    MonteCarloParams params,
  ) {
    final evaluator = HandEvaluator();
    final random = Random();

    // Parse player data
    final players = params.playersData.map((data) {
      final holeCards = (data['holeCards'] as List).map((m) {
        final cardMap = m as Map<String, int>;
        return PlayingCard(
          rank: Rank.values[cardMap['rank']!],
          suit: Suit.values[cardMap['suit']!],
        );
      }).toList();

      return _SimPlayer(
        id: data['id'] as String,
        holeCards: holeCards,
        useRange: data['useRange'] as bool,
      );
    }).toList();

    // Parse community cards
    final communityCards = params.communityCardsData.map((m) {
      return PlayingCard(
        rank: Rank.values[m['rank']!],
        suit: Suit.values[m['suit']!],
      );
    }).toList();

    // Initialize results
    final results = <String, _SimResult>{};
    for (final player in players) {
      results[player.id] = _SimResult();
    }

    // Get used cards
    final usedCards = <PlayingCard>{};
    for (final player in players) {
      usedCards.addAll(player.holeCards);
    }
    usedCards.addAll(communityCards);

    final deck = PlayingCard.fullDeck
        .where((card) => !usedCards.contains(card))
        .toList();

    // Run simulations
    for (var i = 0; i < params.simulations; i++) {
      _simulateHand(
        evaluator: evaluator,
        random: random,
        players: players,
        communityCards: communityCards,
        deck: List.from(deck),
        results: results,
      );
    }

    // Convert to result data
    final playerResults = <String, PlayerResultData>{};
    for (final entry in results.entries) {
      playerResults[entry.key] = PlayerResultData(
        playerId: entry.key,
        wins: entry.value.wins,
        ties: entry.value.ties,
        losses: entry.value.losses,
      );
    }

    return MonteCarloResultData(
      playerResults: playerResults,
      simulations: params.simulations,
    );
  }

  static void _simulateHand({
    required HandEvaluator evaluator,
    required Random random,
    required List<_SimPlayer> players,
    required List<PlayingCard> communityCards,
    required List<PlayingCard> deck,
    required Map<String, _SimResult> results,
  }) {
    _shuffleDeck(deck, random);

    var deckIndex = 0;

    // Deal cards to players using range
    final playerHands = <String, List<PlayingCard>>{};
    for (final player in players) {
      if (player.useRange) {
        playerHands[player.id] = [deck[deckIndex++], deck[deckIndex++]];
      } else {
        playerHands[player.id] = player.holeCards;
      }
    }

    // Complete community cards
    final remainingCommunity = 5 - communityCards.length;
    final simulatedCommunity = List<PlayingCard>.from(communityCards);
    for (var i = 0; i < remainingCommunity; i++) {
      simulatedCommunity.add(deck[deckIndex++]);
    }

    // Evaluate all hands
    final evaluations = <String, EvaluatedHand>{};
    for (final player in players) {
      final hand = playerHands[player.id]!;
      final allCards = [...hand, ...simulatedCommunity];
      evaluations[player.id] = evaluator.evaluate(allCards);
    }

    // Find winner(s)
    EvaluatedHand? bestEval;
    final winners = <String>[];

    for (final entry in evaluations.entries) {
      if (bestEval == null) {
        bestEval = entry.value;
        winners.add(entry.key);
      } else {
        final comparison = entry.value.compareTo(bestEval);
        if (comparison > 0) {
          bestEval = entry.value;
          winners.clear();
          winners.add(entry.key);
        } else if (comparison == 0) {
          winners.add(entry.key);
        }
      }
    }

    // Update results
    final isTie = winners.length > 1;
    for (final player in players) {
      if (winners.contains(player.id)) {
        if (isTie) {
          results[player.id]!.ties++;
        } else {
          results[player.id]!.wins++;
        }
      } else {
        results[player.id]!.losses++;
      }
    }
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

/// Internal player representation for simulation
class _SimPlayer {
  final String id;
  final List<PlayingCard> holeCards;
  final bool useRange;

  _SimPlayer({
    required this.id,
    required this.holeCards,
    required this.useRange,
  });
}

/// Internal result tracker
class _SimResult {
  int wins = 0;
  int ties = 0;
  int losses = 0;
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
