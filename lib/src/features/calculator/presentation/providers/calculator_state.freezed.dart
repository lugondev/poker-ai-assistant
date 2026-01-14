// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculator_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalculatorState {

/// List of players (first player is always Hero)
 List<Player> get players;/// Community cards on the board
 List<PlayingCard> get boardCards;/// Current board phase
 BoardPhase get boardPhase;/// Currently selected player index for card input
 int get selectedPlayerIndex;/// Current selection target
 SelectionTarget get selectionTarget;/// Is calculation in progress
 bool get isCalculating;/// Error message
 String? get errorMessage;/// Current hand rank for hero
 String? get heroHandRank;/// Total pot size for odds calculation
 double get potSize;/// List of betting actions for analysis
 List<PlayerAction> get bettingHistory;/// Game settings (blinds, stack, etc.)
 GameSettings get gameSettings;/// Current betting state
 BettingState get bettingState;/// Index of player whose turn it is to act
 int get currentTurnIndex;/// Is hand in progress (cards dealt, betting active)
 bool get isHandInProgress;/// Dealer button position (player index)
 int get dealerButtonIndex;
/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculatorStateCopyWith<CalculatorState> get copyWith => _$CalculatorStateCopyWithImpl<CalculatorState>(this as CalculatorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculatorState&&const DeepCollectionEquality().equals(other.players, players)&&const DeepCollectionEquality().equals(other.boardCards, boardCards)&&(identical(other.boardPhase, boardPhase) || other.boardPhase == boardPhase)&&(identical(other.selectedPlayerIndex, selectedPlayerIndex) || other.selectedPlayerIndex == selectedPlayerIndex)&&(identical(other.selectionTarget, selectionTarget) || other.selectionTarget == selectionTarget)&&(identical(other.isCalculating, isCalculating) || other.isCalculating == isCalculating)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.heroHandRank, heroHandRank) || other.heroHandRank == heroHandRank)&&(identical(other.potSize, potSize) || other.potSize == potSize)&&const DeepCollectionEquality().equals(other.bettingHistory, bettingHistory)&&(identical(other.gameSettings, gameSettings) || other.gameSettings == gameSettings)&&(identical(other.bettingState, bettingState) || other.bettingState == bettingState)&&(identical(other.currentTurnIndex, currentTurnIndex) || other.currentTurnIndex == currentTurnIndex)&&(identical(other.isHandInProgress, isHandInProgress) || other.isHandInProgress == isHandInProgress)&&(identical(other.dealerButtonIndex, dealerButtonIndex) || other.dealerButtonIndex == dealerButtonIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(players),const DeepCollectionEquality().hash(boardCards),boardPhase,selectedPlayerIndex,selectionTarget,isCalculating,errorMessage,heroHandRank,potSize,const DeepCollectionEquality().hash(bettingHistory),gameSettings,bettingState,currentTurnIndex,isHandInProgress,dealerButtonIndex);

@override
String toString() {
  return 'CalculatorState(players: $players, boardCards: $boardCards, boardPhase: $boardPhase, selectedPlayerIndex: $selectedPlayerIndex, selectionTarget: $selectionTarget, isCalculating: $isCalculating, errorMessage: $errorMessage, heroHandRank: $heroHandRank, potSize: $potSize, bettingHistory: $bettingHistory, gameSettings: $gameSettings, bettingState: $bettingState, currentTurnIndex: $currentTurnIndex, isHandInProgress: $isHandInProgress, dealerButtonIndex: $dealerButtonIndex)';
}


}

/// @nodoc
abstract mixin class $CalculatorStateCopyWith<$Res>  {
  factory $CalculatorStateCopyWith(CalculatorState value, $Res Function(CalculatorState) _then) = _$CalculatorStateCopyWithImpl;
@useResult
$Res call({
 List<Player> players, List<PlayingCard> boardCards, BoardPhase boardPhase, int selectedPlayerIndex, SelectionTarget selectionTarget, bool isCalculating, String? errorMessage, String? heroHandRank, double potSize, List<PlayerAction> bettingHistory, GameSettings gameSettings, BettingState bettingState, int currentTurnIndex, bool isHandInProgress, int dealerButtonIndex
});


$GameSettingsCopyWith<$Res> get gameSettings;$BettingStateCopyWith<$Res> get bettingState;

}
/// @nodoc
class _$CalculatorStateCopyWithImpl<$Res>
    implements $CalculatorStateCopyWith<$Res> {
  _$CalculatorStateCopyWithImpl(this._self, this._then);

  final CalculatorState _self;
  final $Res Function(CalculatorState) _then;

/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? players = null,Object? boardCards = null,Object? boardPhase = null,Object? selectedPlayerIndex = null,Object? selectionTarget = null,Object? isCalculating = null,Object? errorMessage = freezed,Object? heroHandRank = freezed,Object? potSize = null,Object? bettingHistory = null,Object? gameSettings = null,Object? bettingState = null,Object? currentTurnIndex = null,Object? isHandInProgress = null,Object? dealerButtonIndex = null,}) {
  return _then(_self.copyWith(
players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<Player>,boardCards: null == boardCards ? _self.boardCards : boardCards // ignore: cast_nullable_to_non_nullable
as List<PlayingCard>,boardPhase: null == boardPhase ? _self.boardPhase : boardPhase // ignore: cast_nullable_to_non_nullable
as BoardPhase,selectedPlayerIndex: null == selectedPlayerIndex ? _self.selectedPlayerIndex : selectedPlayerIndex // ignore: cast_nullable_to_non_nullable
as int,selectionTarget: null == selectionTarget ? _self.selectionTarget : selectionTarget // ignore: cast_nullable_to_non_nullable
as SelectionTarget,isCalculating: null == isCalculating ? _self.isCalculating : isCalculating // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,heroHandRank: freezed == heroHandRank ? _self.heroHandRank : heroHandRank // ignore: cast_nullable_to_non_nullable
as String?,potSize: null == potSize ? _self.potSize : potSize // ignore: cast_nullable_to_non_nullable
as double,bettingHistory: null == bettingHistory ? _self.bettingHistory : bettingHistory // ignore: cast_nullable_to_non_nullable
as List<PlayerAction>,gameSettings: null == gameSettings ? _self.gameSettings : gameSettings // ignore: cast_nullable_to_non_nullable
as GameSettings,bettingState: null == bettingState ? _self.bettingState : bettingState // ignore: cast_nullable_to_non_nullable
as BettingState,currentTurnIndex: null == currentTurnIndex ? _self.currentTurnIndex : currentTurnIndex // ignore: cast_nullable_to_non_nullable
as int,isHandInProgress: null == isHandInProgress ? _self.isHandInProgress : isHandInProgress // ignore: cast_nullable_to_non_nullable
as bool,dealerButtonIndex: null == dealerButtonIndex ? _self.dealerButtonIndex : dealerButtonIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameSettingsCopyWith<$Res> get gameSettings {
  
  return $GameSettingsCopyWith<$Res>(_self.gameSettings, (value) {
    return _then(_self.copyWith(gameSettings: value));
  });
}/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BettingStateCopyWith<$Res> get bettingState {
  
  return $BettingStateCopyWith<$Res>(_self.bettingState, (value) {
    return _then(_self.copyWith(bettingState: value));
  });
}
}


/// Adds pattern-matching-related methods to [CalculatorState].
extension CalculatorStatePatterns on CalculatorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalculatorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalculatorState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalculatorState value)  $default,){
final _that = this;
switch (_that) {
case _CalculatorState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalculatorState value)?  $default,){
final _that = this;
switch (_that) {
case _CalculatorState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Player> players,  List<PlayingCard> boardCards,  BoardPhase boardPhase,  int selectedPlayerIndex,  SelectionTarget selectionTarget,  bool isCalculating,  String? errorMessage,  String? heroHandRank,  double potSize,  List<PlayerAction> bettingHistory,  GameSettings gameSettings,  BettingState bettingState,  int currentTurnIndex,  bool isHandInProgress,  int dealerButtonIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculatorState() when $default != null:
return $default(_that.players,_that.boardCards,_that.boardPhase,_that.selectedPlayerIndex,_that.selectionTarget,_that.isCalculating,_that.errorMessage,_that.heroHandRank,_that.potSize,_that.bettingHistory,_that.gameSettings,_that.bettingState,_that.currentTurnIndex,_that.isHandInProgress,_that.dealerButtonIndex);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Player> players,  List<PlayingCard> boardCards,  BoardPhase boardPhase,  int selectedPlayerIndex,  SelectionTarget selectionTarget,  bool isCalculating,  String? errorMessage,  String? heroHandRank,  double potSize,  List<PlayerAction> bettingHistory,  GameSettings gameSettings,  BettingState bettingState,  int currentTurnIndex,  bool isHandInProgress,  int dealerButtonIndex)  $default,) {final _that = this;
switch (_that) {
case _CalculatorState():
return $default(_that.players,_that.boardCards,_that.boardPhase,_that.selectedPlayerIndex,_that.selectionTarget,_that.isCalculating,_that.errorMessage,_that.heroHandRank,_that.potSize,_that.bettingHistory,_that.gameSettings,_that.bettingState,_that.currentTurnIndex,_that.isHandInProgress,_that.dealerButtonIndex);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Player> players,  List<PlayingCard> boardCards,  BoardPhase boardPhase,  int selectedPlayerIndex,  SelectionTarget selectionTarget,  bool isCalculating,  String? errorMessage,  String? heroHandRank,  double potSize,  List<PlayerAction> bettingHistory,  GameSettings gameSettings,  BettingState bettingState,  int currentTurnIndex,  bool isHandInProgress,  int dealerButtonIndex)?  $default,) {final _that = this;
switch (_that) {
case _CalculatorState() when $default != null:
return $default(_that.players,_that.boardCards,_that.boardPhase,_that.selectedPlayerIndex,_that.selectionTarget,_that.isCalculating,_that.errorMessage,_that.heroHandRank,_that.potSize,_that.bettingHistory,_that.gameSettings,_that.bettingState,_that.currentTurnIndex,_that.isHandInProgress,_that.dealerButtonIndex);case _:
  return null;

}
}

}

/// @nodoc


class _CalculatorState extends CalculatorState {
  const _CalculatorState({final  List<Player> players = const [], final  List<PlayingCard> boardCards = const [], this.boardPhase = BoardPhase.flop, this.selectedPlayerIndex = 0, this.selectionTarget = SelectionTarget.player, this.isCalculating = false, this.errorMessage = null, this.heroHandRank = null, this.potSize = 0, final  List<PlayerAction> bettingHistory = const [], this.gameSettings = const GameSettings(), this.bettingState = const BettingState(), this.currentTurnIndex = -1, this.isHandInProgress = false, this.dealerButtonIndex = 0}): _players = players,_boardCards = boardCards,_bettingHistory = bettingHistory,super._();
  

/// List of players (first player is always Hero)
 final  List<Player> _players;
/// List of players (first player is always Hero)
@override@JsonKey() List<Player> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}

/// Community cards on the board
 final  List<PlayingCard> _boardCards;
/// Community cards on the board
@override@JsonKey() List<PlayingCard> get boardCards {
  if (_boardCards is EqualUnmodifiableListView) return _boardCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_boardCards);
}

/// Current board phase
@override@JsonKey() final  BoardPhase boardPhase;
/// Currently selected player index for card input
@override@JsonKey() final  int selectedPlayerIndex;
/// Current selection target
@override@JsonKey() final  SelectionTarget selectionTarget;
/// Is calculation in progress
@override@JsonKey() final  bool isCalculating;
/// Error message
@override@JsonKey() final  String? errorMessage;
/// Current hand rank for hero
@override@JsonKey() final  String? heroHandRank;
/// Total pot size for odds calculation
@override@JsonKey() final  double potSize;
/// List of betting actions for analysis
 final  List<PlayerAction> _bettingHistory;
/// List of betting actions for analysis
@override@JsonKey() List<PlayerAction> get bettingHistory {
  if (_bettingHistory is EqualUnmodifiableListView) return _bettingHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bettingHistory);
}

/// Game settings (blinds, stack, etc.)
@override@JsonKey() final  GameSettings gameSettings;
/// Current betting state
@override@JsonKey() final  BettingState bettingState;
/// Index of player whose turn it is to act
@override@JsonKey() final  int currentTurnIndex;
/// Is hand in progress (cards dealt, betting active)
@override@JsonKey() final  bool isHandInProgress;
/// Dealer button position (player index)
@override@JsonKey() final  int dealerButtonIndex;

/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculatorStateCopyWith<_CalculatorState> get copyWith => __$CalculatorStateCopyWithImpl<_CalculatorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculatorState&&const DeepCollectionEquality().equals(other._players, _players)&&const DeepCollectionEquality().equals(other._boardCards, _boardCards)&&(identical(other.boardPhase, boardPhase) || other.boardPhase == boardPhase)&&(identical(other.selectedPlayerIndex, selectedPlayerIndex) || other.selectedPlayerIndex == selectedPlayerIndex)&&(identical(other.selectionTarget, selectionTarget) || other.selectionTarget == selectionTarget)&&(identical(other.isCalculating, isCalculating) || other.isCalculating == isCalculating)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.heroHandRank, heroHandRank) || other.heroHandRank == heroHandRank)&&(identical(other.potSize, potSize) || other.potSize == potSize)&&const DeepCollectionEquality().equals(other._bettingHistory, _bettingHistory)&&(identical(other.gameSettings, gameSettings) || other.gameSettings == gameSettings)&&(identical(other.bettingState, bettingState) || other.bettingState == bettingState)&&(identical(other.currentTurnIndex, currentTurnIndex) || other.currentTurnIndex == currentTurnIndex)&&(identical(other.isHandInProgress, isHandInProgress) || other.isHandInProgress == isHandInProgress)&&(identical(other.dealerButtonIndex, dealerButtonIndex) || other.dealerButtonIndex == dealerButtonIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_players),const DeepCollectionEquality().hash(_boardCards),boardPhase,selectedPlayerIndex,selectionTarget,isCalculating,errorMessage,heroHandRank,potSize,const DeepCollectionEquality().hash(_bettingHistory),gameSettings,bettingState,currentTurnIndex,isHandInProgress,dealerButtonIndex);

@override
String toString() {
  return 'CalculatorState(players: $players, boardCards: $boardCards, boardPhase: $boardPhase, selectedPlayerIndex: $selectedPlayerIndex, selectionTarget: $selectionTarget, isCalculating: $isCalculating, errorMessage: $errorMessage, heroHandRank: $heroHandRank, potSize: $potSize, bettingHistory: $bettingHistory, gameSettings: $gameSettings, bettingState: $bettingState, currentTurnIndex: $currentTurnIndex, isHandInProgress: $isHandInProgress, dealerButtonIndex: $dealerButtonIndex)';
}


}

/// @nodoc
abstract mixin class _$CalculatorStateCopyWith<$Res> implements $CalculatorStateCopyWith<$Res> {
  factory _$CalculatorStateCopyWith(_CalculatorState value, $Res Function(_CalculatorState) _then) = __$CalculatorStateCopyWithImpl;
@override @useResult
$Res call({
 List<Player> players, List<PlayingCard> boardCards, BoardPhase boardPhase, int selectedPlayerIndex, SelectionTarget selectionTarget, bool isCalculating, String? errorMessage, String? heroHandRank, double potSize, List<PlayerAction> bettingHistory, GameSettings gameSettings, BettingState bettingState, int currentTurnIndex, bool isHandInProgress, int dealerButtonIndex
});


@override $GameSettingsCopyWith<$Res> get gameSettings;@override $BettingStateCopyWith<$Res> get bettingState;

}
/// @nodoc
class __$CalculatorStateCopyWithImpl<$Res>
    implements _$CalculatorStateCopyWith<$Res> {
  __$CalculatorStateCopyWithImpl(this._self, this._then);

  final _CalculatorState _self;
  final $Res Function(_CalculatorState) _then;

/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? players = null,Object? boardCards = null,Object? boardPhase = null,Object? selectedPlayerIndex = null,Object? selectionTarget = null,Object? isCalculating = null,Object? errorMessage = freezed,Object? heroHandRank = freezed,Object? potSize = null,Object? bettingHistory = null,Object? gameSettings = null,Object? bettingState = null,Object? currentTurnIndex = null,Object? isHandInProgress = null,Object? dealerButtonIndex = null,}) {
  return _then(_CalculatorState(
players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<Player>,boardCards: null == boardCards ? _self._boardCards : boardCards // ignore: cast_nullable_to_non_nullable
as List<PlayingCard>,boardPhase: null == boardPhase ? _self.boardPhase : boardPhase // ignore: cast_nullable_to_non_nullable
as BoardPhase,selectedPlayerIndex: null == selectedPlayerIndex ? _self.selectedPlayerIndex : selectedPlayerIndex // ignore: cast_nullable_to_non_nullable
as int,selectionTarget: null == selectionTarget ? _self.selectionTarget : selectionTarget // ignore: cast_nullable_to_non_nullable
as SelectionTarget,isCalculating: null == isCalculating ? _self.isCalculating : isCalculating // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,heroHandRank: freezed == heroHandRank ? _self.heroHandRank : heroHandRank // ignore: cast_nullable_to_non_nullable
as String?,potSize: null == potSize ? _self.potSize : potSize // ignore: cast_nullable_to_non_nullable
as double,bettingHistory: null == bettingHistory ? _self._bettingHistory : bettingHistory // ignore: cast_nullable_to_non_nullable
as List<PlayerAction>,gameSettings: null == gameSettings ? _self.gameSettings : gameSettings // ignore: cast_nullable_to_non_nullable
as GameSettings,bettingState: null == bettingState ? _self.bettingState : bettingState // ignore: cast_nullable_to_non_nullable
as BettingState,currentTurnIndex: null == currentTurnIndex ? _self.currentTurnIndex : currentTurnIndex // ignore: cast_nullable_to_non_nullable
as int,isHandInProgress: null == isHandInProgress ? _self.isHandInProgress : isHandInProgress // ignore: cast_nullable_to_non_nullable
as bool,dealerButtonIndex: null == dealerButtonIndex ? _self.dealerButtonIndex : dealerButtonIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameSettingsCopyWith<$Res> get gameSettings {
  
  return $GameSettingsCopyWith<$Res>(_self.gameSettings, (value) {
    return _then(_self.copyWith(gameSettings: value));
  });
}/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BettingStateCopyWith<$Res> get bettingState {
  
  return $BettingStateCopyWith<$Res>(_self.bettingState, (value) {
    return _then(_self.copyWith(bettingState: value));
  });
}
}

// dart format on
