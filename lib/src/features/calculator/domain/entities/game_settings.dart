import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_settings.freezed.dart';

/// Player position at the poker table
enum PlayerPosition {
  btn('BTN', 'Button', 0),
  sb('SB', 'Small Blind', 1),
  bb('BB', 'Big Blind', 2),
  utg('UTG', 'Under the Gun', 3),
  utg1('UTG+1', 'UTG+1', 4),
  utg2('UTG+2', 'UTG+2', 5),
  mp('MP', 'Middle Position', 6),
  mp1('MP+1', 'MP+1', 7),
  hj('HJ', 'Hijack', 8),
  co('CO', 'Cutoff', 9);

  final String shortName;
  final String fullName;
  final int order;
  const PlayerPosition(this.shortName, this.fullName, this.order);

  /// Get positions for a given number of players
  static List<PlayerPosition> getPositionsForPlayerCount(int count) {
    switch (count) {
      case 2:
        return [btn, bb]; // Heads-up: BTN is SB
      case 3:
        return [btn, sb, bb];
      case 4:
        return [btn, sb, bb, utg];
      case 5:
        return [btn, sb, bb, utg, co];
      case 6:
        return [btn, sb, bb, utg, hj, co];
      case 7:
        return [btn, sb, bb, utg, mp, hj, co];
      case 8:
        return [btn, sb, bb, utg, utg1, mp, hj, co];
      case 9:
        return [btn, sb, bb, utg, utg1, utg2, mp, hj, co];
      case 10:
        return [btn, sb, bb, utg, utg1, utg2, mp, mp1, hj, co];
      default:
        return [btn, sb, bb];
    }
  }

  /// Get preflop action order (UTG acts first, BTN acts last)
  static List<PlayerPosition> getPreflopOrder(int playerCount) {
    final positions = getPositionsForPlayerCount(playerCount);
    // Preflop: UTG -> ... -> BTN -> SB -> BB
    final order = <PlayerPosition>[];

    // Add positions from UTG onwards
    for (final pos in positions) {
      if (pos != btn && pos != sb && pos != bb) {
        order.add(pos);
      }
    }
    // Then BTN, SB, BB
    if (positions.contains(btn)) order.add(btn);
    if (positions.contains(sb)) order.add(sb);
    if (positions.contains(bb)) order.add(bb);

    return order;
  }

  /// Get postflop action order (SB acts first, BTN acts last)
  static List<PlayerPosition> getPostflopOrder(int playerCount) {
    final positions = getPositionsForPlayerCount(playerCount);
    // Postflop: SB -> BB -> UTG -> ... -> BTN
    final order = <PlayerPosition>[];

    if (positions.contains(sb)) order.add(sb);
    if (positions.contains(bb)) order.add(bb);

    for (final pos in positions) {
      if (pos != btn && pos != sb && pos != bb) {
        order.add(pos);
      }
    }

    if (positions.contains(btn)) order.add(btn);

    return order;
  }
}

/// Game settings for the poker session
@freezed
abstract class GameSettings with _$GameSettings {
  const GameSettings._();

  const factory GameSettings({
    /// Small blind amount
    @Default(1) double smallBlind,

    /// Big blind amount
    @Default(2) double bigBlind,

    /// Ante amount (0 = no ante)
    @Default(0) double ante,

    /// Default starting stack for new players
    @Default(100) double defaultStack,

    /// Game type
    @Default(GameType.cashGame) GameType gameType,

    /// Currency symbol for display
    @Default('\$') String currencySymbol,
  }) = _GameSettings;

  /// Get big blind in terms of small blinds
  double get bbToSb => bigBlind / smallBlind;

  /// Format amount for display
  String formatAmount(double amount) {
    if (amount >= 1000) {
      return '$currencySymbol${(amount / 1000).toStringAsFixed(1)}k';
    }
    if (amount == amount.roundToDouble()) {
      return '$currencySymbol${amount.toInt()}';
    }
    return '$currencySymbol${amount.toStringAsFixed(2)}';
  }

  /// Format stack in BB
  String formatStackInBB(double stack) {
    final bb = stack / bigBlind;
    return '${bb.toStringAsFixed(1)} BB';
  }
}

/// Type of poker game
enum GameType {
  cashGame('Cash Game'),
  tournament('Tournament'),
  sitAndGo('Sit & Go');

  final String displayName;
  const GameType(this.displayName);
}

/// Represents the current betting state in a round
@freezed
abstract class BettingState with _$BettingState {
  const BettingState._();

  const factory BettingState({
    /// Current bet amount to call
    @Default(0) double currentBet,

    /// Minimum raise amount
    @Default(0) double minRaise,

    /// Total pot size (main pot)
    @Default(0) double mainPot,

    /// Side pots (for all-in situations)
    @Default([]) List<SidePot> sidePots,

    /// Index of player whose turn it is
    @Default(0) int currentPlayerIndex,

    /// Number of players who have acted this round
    @Default(0) int actedCount,

    /// Is betting round complete
    @Default(false) bool isRoundComplete,

    /// Last aggressor index
    @Default(-1) int lastAggressorIndex,
  }) = _BettingState;

  /// Total pot including all side pots
  double get totalPot =>
      mainPot + sidePots.fold(0.0, (sum, sp) => sum + sp.amount);
}

/// Side pot for all-in situations
@freezed
abstract class SidePot with _$SidePot {
  const factory SidePot({
    required double amount,
    required List<String> eligiblePlayerIds,
  }) = _SidePot;
}

/// Preset blind structures for quick setup
class BlindPreset {
  final String name;
  final double smallBlind;
  final double bigBlind;
  final double? ante;
  final double defaultStack;

  const BlindPreset({
    required this.name,
    required this.smallBlind,
    required this.bigBlind,
    this.ante,
    required this.defaultStack,
  });

  static const List<BlindPreset> presets = [
    BlindPreset(name: '1/2', smallBlind: 1, bigBlind: 2, defaultStack: 200),
    BlindPreset(name: '2/5', smallBlind: 2, bigBlind: 5, defaultStack: 500),
    BlindPreset(name: '5/10', smallBlind: 5, bigBlind: 10, defaultStack: 1000),
    BlindPreset(
      name: '10/20',
      smallBlind: 10,
      bigBlind: 20,
      defaultStack: 2000,
    ),
    BlindPreset(
      name: '25/50',
      smallBlind: 25,
      bigBlind: 50,
      defaultStack: 5000,
    ),
    BlindPreset(
      name: '50/100',
      smallBlind: 50,
      bigBlind: 100,
      defaultStack: 10000,
    ),
    BlindPreset(
      name: '100/200',
      smallBlind: 100,
      bigBlind: 200,
      defaultStack: 20000,
    ),
    BlindPreset(
      name: '100/200/25a',
      smallBlind: 100,
      bigBlind: 200,
      ante: 25,
      defaultStack: 20000,
    ),
  ];
}
