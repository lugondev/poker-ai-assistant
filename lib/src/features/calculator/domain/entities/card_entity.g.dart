// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayingCard _$PlayingCardFromJson(Map<String, dynamic> json) => _PlayingCard(
  rank: $enumDecode(_$RankEnumMap, json['rank']),
  suit: $enumDecode(_$SuitEnumMap, json['suit']),
);

Map<String, dynamic> _$PlayingCardToJson(_PlayingCard instance) =>
    <String, dynamic>{
      'rank': _$RankEnumMap[instance.rank]!,
      'suit': _$SuitEnumMap[instance.suit]!,
    };

const _$RankEnumMap = {
  Rank.two: 'two',
  Rank.three: 'three',
  Rank.four: 'four',
  Rank.five: 'five',
  Rank.six: 'six',
  Rank.seven: 'seven',
  Rank.eight: 'eight',
  Rank.nine: 'nine',
  Rank.ten: 'ten',
  Rank.jack: 'jack',
  Rank.queen: 'queen',
  Rank.king: 'king',
  Rank.ace: 'ace',
};

const _$SuitEnumMap = {
  Suit.hearts: 'hearts',
  Suit.diamonds: 'diamonds',
  Suit.clubs: 'clubs',
  Suit.spades: 'spades',
};
