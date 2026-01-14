import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_entity.freezed.dart';
part 'card_entity.g.dart';

enum Suit {
  hearts,
  diamonds,
  clubs,
  spades;

  String get symbol {
    return switch (this) {
      Suit.hearts => '♥',
      Suit.diamonds => '♦',
      Suit.clubs => '♣',
      Suit.spades => '♠',
    };
  }

  bool get isRed => this == Suit.hearts || this == Suit.diamonds;
}

enum Rank {
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
  ace;

  int get value => index + 2;

  String get symbol {
    return switch (this) {
      Rank.ace => 'A',
      Rank.king => 'K',
      Rank.queen => 'Q',
      Rank.jack => 'J',
      Rank.ten => 'T',
      _ => value.toString(),
    };
  }
}

@freezed
abstract class PlayingCard with _$PlayingCard {
  const PlayingCard._();

  const factory PlayingCard({required Rank rank, required Suit suit}) =
      _PlayingCard;

  factory PlayingCard.fromJson(Map<String, dynamic> json) =>
      _$PlayingCardFromJson(json);

  String get displayName => '${rank.symbol}${suit.symbol}';

  String get shortName => '${rank.symbol}${suit.name[0].toLowerCase()}';

  int get numericValue => rank.value;

  static List<PlayingCard> get fullDeck {
    final deck = <PlayingCard>[];
    for (final suit in Suit.values) {
      for (final rank in Rank.values) {
        deck.add(PlayingCard(rank: rank, suit: suit));
      }
    }
    return deck;
  }
}
