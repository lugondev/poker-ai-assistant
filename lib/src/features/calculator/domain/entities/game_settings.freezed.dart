// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameSettings {

/// Small blind amount
 double get smallBlind;/// Big blind amount
 double get bigBlind;/// Ante amount (0 = no ante)
 double get ante;/// Default starting stack for new players
 double get defaultStack;/// Game type
 GameType get gameType;/// Currency symbol for display
 String get currencySymbol;
/// Create a copy of GameSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameSettingsCopyWith<GameSettings> get copyWith => _$GameSettingsCopyWithImpl<GameSettings>(this as GameSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameSettings&&(identical(other.smallBlind, smallBlind) || other.smallBlind == smallBlind)&&(identical(other.bigBlind, bigBlind) || other.bigBlind == bigBlind)&&(identical(other.ante, ante) || other.ante == ante)&&(identical(other.defaultStack, defaultStack) || other.defaultStack == defaultStack)&&(identical(other.gameType, gameType) || other.gameType == gameType)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol));
}


@override
int get hashCode => Object.hash(runtimeType,smallBlind,bigBlind,ante,defaultStack,gameType,currencySymbol);

@override
String toString() {
  return 'GameSettings(smallBlind: $smallBlind, bigBlind: $bigBlind, ante: $ante, defaultStack: $defaultStack, gameType: $gameType, currencySymbol: $currencySymbol)';
}


}

/// @nodoc
abstract mixin class $GameSettingsCopyWith<$Res>  {
  factory $GameSettingsCopyWith(GameSettings value, $Res Function(GameSettings) _then) = _$GameSettingsCopyWithImpl;
@useResult
$Res call({
 double smallBlind, double bigBlind, double ante, double defaultStack, GameType gameType, String currencySymbol
});




}
/// @nodoc
class _$GameSettingsCopyWithImpl<$Res>
    implements $GameSettingsCopyWith<$Res> {
  _$GameSettingsCopyWithImpl(this._self, this._then);

  final GameSettings _self;
  final $Res Function(GameSettings) _then;

/// Create a copy of GameSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? smallBlind = null,Object? bigBlind = null,Object? ante = null,Object? defaultStack = null,Object? gameType = null,Object? currencySymbol = null,}) {
  return _then(_self.copyWith(
smallBlind: null == smallBlind ? _self.smallBlind : smallBlind // ignore: cast_nullable_to_non_nullable
as double,bigBlind: null == bigBlind ? _self.bigBlind : bigBlind // ignore: cast_nullable_to_non_nullable
as double,ante: null == ante ? _self.ante : ante // ignore: cast_nullable_to_non_nullable
as double,defaultStack: null == defaultStack ? _self.defaultStack : defaultStack // ignore: cast_nullable_to_non_nullable
as double,gameType: null == gameType ? _self.gameType : gameType // ignore: cast_nullable_to_non_nullable
as GameType,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GameSettings].
extension GameSettingsPatterns on GameSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameSettings value)  $default,){
final _that = this;
switch (_that) {
case _GameSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameSettings value)?  $default,){
final _that = this;
switch (_that) {
case _GameSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double smallBlind,  double bigBlind,  double ante,  double defaultStack,  GameType gameType,  String currencySymbol)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameSettings() when $default != null:
return $default(_that.smallBlind,_that.bigBlind,_that.ante,_that.defaultStack,_that.gameType,_that.currencySymbol);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double smallBlind,  double bigBlind,  double ante,  double defaultStack,  GameType gameType,  String currencySymbol)  $default,) {final _that = this;
switch (_that) {
case _GameSettings():
return $default(_that.smallBlind,_that.bigBlind,_that.ante,_that.defaultStack,_that.gameType,_that.currencySymbol);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double smallBlind,  double bigBlind,  double ante,  double defaultStack,  GameType gameType,  String currencySymbol)?  $default,) {final _that = this;
switch (_that) {
case _GameSettings() when $default != null:
return $default(_that.smallBlind,_that.bigBlind,_that.ante,_that.defaultStack,_that.gameType,_that.currencySymbol);case _:
  return null;

}
}

}

/// @nodoc


class _GameSettings extends GameSettings {
  const _GameSettings({this.smallBlind = 1, this.bigBlind = 2, this.ante = 0, this.defaultStack = 100, this.gameType = GameType.cashGame, this.currencySymbol = '\$'}): super._();
  

/// Small blind amount
@override@JsonKey() final  double smallBlind;
/// Big blind amount
@override@JsonKey() final  double bigBlind;
/// Ante amount (0 = no ante)
@override@JsonKey() final  double ante;
/// Default starting stack for new players
@override@JsonKey() final  double defaultStack;
/// Game type
@override@JsonKey() final  GameType gameType;
/// Currency symbol for display
@override@JsonKey() final  String currencySymbol;

/// Create a copy of GameSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameSettingsCopyWith<_GameSettings> get copyWith => __$GameSettingsCopyWithImpl<_GameSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameSettings&&(identical(other.smallBlind, smallBlind) || other.smallBlind == smallBlind)&&(identical(other.bigBlind, bigBlind) || other.bigBlind == bigBlind)&&(identical(other.ante, ante) || other.ante == ante)&&(identical(other.defaultStack, defaultStack) || other.defaultStack == defaultStack)&&(identical(other.gameType, gameType) || other.gameType == gameType)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol));
}


@override
int get hashCode => Object.hash(runtimeType,smallBlind,bigBlind,ante,defaultStack,gameType,currencySymbol);

@override
String toString() {
  return 'GameSettings(smallBlind: $smallBlind, bigBlind: $bigBlind, ante: $ante, defaultStack: $defaultStack, gameType: $gameType, currencySymbol: $currencySymbol)';
}


}

/// @nodoc
abstract mixin class _$GameSettingsCopyWith<$Res> implements $GameSettingsCopyWith<$Res> {
  factory _$GameSettingsCopyWith(_GameSettings value, $Res Function(_GameSettings) _then) = __$GameSettingsCopyWithImpl;
@override @useResult
$Res call({
 double smallBlind, double bigBlind, double ante, double defaultStack, GameType gameType, String currencySymbol
});




}
/// @nodoc
class __$GameSettingsCopyWithImpl<$Res>
    implements _$GameSettingsCopyWith<$Res> {
  __$GameSettingsCopyWithImpl(this._self, this._then);

  final _GameSettings _self;
  final $Res Function(_GameSettings) _then;

/// Create a copy of GameSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? smallBlind = null,Object? bigBlind = null,Object? ante = null,Object? defaultStack = null,Object? gameType = null,Object? currencySymbol = null,}) {
  return _then(_GameSettings(
smallBlind: null == smallBlind ? _self.smallBlind : smallBlind // ignore: cast_nullable_to_non_nullable
as double,bigBlind: null == bigBlind ? _self.bigBlind : bigBlind // ignore: cast_nullable_to_non_nullable
as double,ante: null == ante ? _self.ante : ante // ignore: cast_nullable_to_non_nullable
as double,defaultStack: null == defaultStack ? _self.defaultStack : defaultStack // ignore: cast_nullable_to_non_nullable
as double,gameType: null == gameType ? _self.gameType : gameType // ignore: cast_nullable_to_non_nullable
as GameType,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BettingState {

/// Current bet amount to call
 double get currentBet;/// Minimum raise amount
 double get minRaise;/// Total pot size (main pot)
 double get mainPot;/// Side pots (for all-in situations)
 List<SidePot> get sidePots;/// Index of player whose turn it is
 int get currentPlayerIndex;/// Number of players who have acted this round
 int get actedCount;/// Is betting round complete
 bool get isRoundComplete;/// Last aggressor index
 int get lastAggressorIndex;
/// Create a copy of BettingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BettingStateCopyWith<BettingState> get copyWith => _$BettingStateCopyWithImpl<BettingState>(this as BettingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BettingState&&(identical(other.currentBet, currentBet) || other.currentBet == currentBet)&&(identical(other.minRaise, minRaise) || other.minRaise == minRaise)&&(identical(other.mainPot, mainPot) || other.mainPot == mainPot)&&const DeepCollectionEquality().equals(other.sidePots, sidePots)&&(identical(other.currentPlayerIndex, currentPlayerIndex) || other.currentPlayerIndex == currentPlayerIndex)&&(identical(other.actedCount, actedCount) || other.actedCount == actedCount)&&(identical(other.isRoundComplete, isRoundComplete) || other.isRoundComplete == isRoundComplete)&&(identical(other.lastAggressorIndex, lastAggressorIndex) || other.lastAggressorIndex == lastAggressorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,currentBet,minRaise,mainPot,const DeepCollectionEquality().hash(sidePots),currentPlayerIndex,actedCount,isRoundComplete,lastAggressorIndex);

@override
String toString() {
  return 'BettingState(currentBet: $currentBet, minRaise: $minRaise, mainPot: $mainPot, sidePots: $sidePots, currentPlayerIndex: $currentPlayerIndex, actedCount: $actedCount, isRoundComplete: $isRoundComplete, lastAggressorIndex: $lastAggressorIndex)';
}


}

/// @nodoc
abstract mixin class $BettingStateCopyWith<$Res>  {
  factory $BettingStateCopyWith(BettingState value, $Res Function(BettingState) _then) = _$BettingStateCopyWithImpl;
@useResult
$Res call({
 double currentBet, double minRaise, double mainPot, List<SidePot> sidePots, int currentPlayerIndex, int actedCount, bool isRoundComplete, int lastAggressorIndex
});




}
/// @nodoc
class _$BettingStateCopyWithImpl<$Res>
    implements $BettingStateCopyWith<$Res> {
  _$BettingStateCopyWithImpl(this._self, this._then);

  final BettingState _self;
  final $Res Function(BettingState) _then;

/// Create a copy of BettingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentBet = null,Object? minRaise = null,Object? mainPot = null,Object? sidePots = null,Object? currentPlayerIndex = null,Object? actedCount = null,Object? isRoundComplete = null,Object? lastAggressorIndex = null,}) {
  return _then(_self.copyWith(
currentBet: null == currentBet ? _self.currentBet : currentBet // ignore: cast_nullable_to_non_nullable
as double,minRaise: null == minRaise ? _self.minRaise : minRaise // ignore: cast_nullable_to_non_nullable
as double,mainPot: null == mainPot ? _self.mainPot : mainPot // ignore: cast_nullable_to_non_nullable
as double,sidePots: null == sidePots ? _self.sidePots : sidePots // ignore: cast_nullable_to_non_nullable
as List<SidePot>,currentPlayerIndex: null == currentPlayerIndex ? _self.currentPlayerIndex : currentPlayerIndex // ignore: cast_nullable_to_non_nullable
as int,actedCount: null == actedCount ? _self.actedCount : actedCount // ignore: cast_nullable_to_non_nullable
as int,isRoundComplete: null == isRoundComplete ? _self.isRoundComplete : isRoundComplete // ignore: cast_nullable_to_non_nullable
as bool,lastAggressorIndex: null == lastAggressorIndex ? _self.lastAggressorIndex : lastAggressorIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BettingState].
extension BettingStatePatterns on BettingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BettingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BettingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BettingState value)  $default,){
final _that = this;
switch (_that) {
case _BettingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BettingState value)?  $default,){
final _that = this;
switch (_that) {
case _BettingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double currentBet,  double minRaise,  double mainPot,  List<SidePot> sidePots,  int currentPlayerIndex,  int actedCount,  bool isRoundComplete,  int lastAggressorIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BettingState() when $default != null:
return $default(_that.currentBet,_that.minRaise,_that.mainPot,_that.sidePots,_that.currentPlayerIndex,_that.actedCount,_that.isRoundComplete,_that.lastAggressorIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double currentBet,  double minRaise,  double mainPot,  List<SidePot> sidePots,  int currentPlayerIndex,  int actedCount,  bool isRoundComplete,  int lastAggressorIndex)  $default,) {final _that = this;
switch (_that) {
case _BettingState():
return $default(_that.currentBet,_that.minRaise,_that.mainPot,_that.sidePots,_that.currentPlayerIndex,_that.actedCount,_that.isRoundComplete,_that.lastAggressorIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double currentBet,  double minRaise,  double mainPot,  List<SidePot> sidePots,  int currentPlayerIndex,  int actedCount,  bool isRoundComplete,  int lastAggressorIndex)?  $default,) {final _that = this;
switch (_that) {
case _BettingState() when $default != null:
return $default(_that.currentBet,_that.minRaise,_that.mainPot,_that.sidePots,_that.currentPlayerIndex,_that.actedCount,_that.isRoundComplete,_that.lastAggressorIndex);case _:
  return null;

}
}

}

/// @nodoc


class _BettingState extends BettingState {
  const _BettingState({this.currentBet = 0, this.minRaise = 0, this.mainPot = 0, final  List<SidePot> sidePots = const [], this.currentPlayerIndex = 0, this.actedCount = 0, this.isRoundComplete = false, this.lastAggressorIndex = -1}): _sidePots = sidePots,super._();
  

/// Current bet amount to call
@override@JsonKey() final  double currentBet;
/// Minimum raise amount
@override@JsonKey() final  double minRaise;
/// Total pot size (main pot)
@override@JsonKey() final  double mainPot;
/// Side pots (for all-in situations)
 final  List<SidePot> _sidePots;
/// Side pots (for all-in situations)
@override@JsonKey() List<SidePot> get sidePots {
  if (_sidePots is EqualUnmodifiableListView) return _sidePots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sidePots);
}

/// Index of player whose turn it is
@override@JsonKey() final  int currentPlayerIndex;
/// Number of players who have acted this round
@override@JsonKey() final  int actedCount;
/// Is betting round complete
@override@JsonKey() final  bool isRoundComplete;
/// Last aggressor index
@override@JsonKey() final  int lastAggressorIndex;

/// Create a copy of BettingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BettingStateCopyWith<_BettingState> get copyWith => __$BettingStateCopyWithImpl<_BettingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BettingState&&(identical(other.currentBet, currentBet) || other.currentBet == currentBet)&&(identical(other.minRaise, minRaise) || other.minRaise == minRaise)&&(identical(other.mainPot, mainPot) || other.mainPot == mainPot)&&const DeepCollectionEquality().equals(other._sidePots, _sidePots)&&(identical(other.currentPlayerIndex, currentPlayerIndex) || other.currentPlayerIndex == currentPlayerIndex)&&(identical(other.actedCount, actedCount) || other.actedCount == actedCount)&&(identical(other.isRoundComplete, isRoundComplete) || other.isRoundComplete == isRoundComplete)&&(identical(other.lastAggressorIndex, lastAggressorIndex) || other.lastAggressorIndex == lastAggressorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,currentBet,minRaise,mainPot,const DeepCollectionEquality().hash(_sidePots),currentPlayerIndex,actedCount,isRoundComplete,lastAggressorIndex);

@override
String toString() {
  return 'BettingState(currentBet: $currentBet, minRaise: $minRaise, mainPot: $mainPot, sidePots: $sidePots, currentPlayerIndex: $currentPlayerIndex, actedCount: $actedCount, isRoundComplete: $isRoundComplete, lastAggressorIndex: $lastAggressorIndex)';
}


}

/// @nodoc
abstract mixin class _$BettingStateCopyWith<$Res> implements $BettingStateCopyWith<$Res> {
  factory _$BettingStateCopyWith(_BettingState value, $Res Function(_BettingState) _then) = __$BettingStateCopyWithImpl;
@override @useResult
$Res call({
 double currentBet, double minRaise, double mainPot, List<SidePot> sidePots, int currentPlayerIndex, int actedCount, bool isRoundComplete, int lastAggressorIndex
});




}
/// @nodoc
class __$BettingStateCopyWithImpl<$Res>
    implements _$BettingStateCopyWith<$Res> {
  __$BettingStateCopyWithImpl(this._self, this._then);

  final _BettingState _self;
  final $Res Function(_BettingState) _then;

/// Create a copy of BettingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentBet = null,Object? minRaise = null,Object? mainPot = null,Object? sidePots = null,Object? currentPlayerIndex = null,Object? actedCount = null,Object? isRoundComplete = null,Object? lastAggressorIndex = null,}) {
  return _then(_BettingState(
currentBet: null == currentBet ? _self.currentBet : currentBet // ignore: cast_nullable_to_non_nullable
as double,minRaise: null == minRaise ? _self.minRaise : minRaise // ignore: cast_nullable_to_non_nullable
as double,mainPot: null == mainPot ? _self.mainPot : mainPot // ignore: cast_nullable_to_non_nullable
as double,sidePots: null == sidePots ? _self._sidePots : sidePots // ignore: cast_nullable_to_non_nullable
as List<SidePot>,currentPlayerIndex: null == currentPlayerIndex ? _self.currentPlayerIndex : currentPlayerIndex // ignore: cast_nullable_to_non_nullable
as int,actedCount: null == actedCount ? _self.actedCount : actedCount // ignore: cast_nullable_to_non_nullable
as int,isRoundComplete: null == isRoundComplete ? _self.isRoundComplete : isRoundComplete // ignore: cast_nullable_to_non_nullable
as bool,lastAggressorIndex: null == lastAggressorIndex ? _self.lastAggressorIndex : lastAggressorIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SidePot {

 double get amount; List<String> get eligiblePlayerIds;
/// Create a copy of SidePot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SidePotCopyWith<SidePot> get copyWith => _$SidePotCopyWithImpl<SidePot>(this as SidePot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SidePot&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other.eligiblePlayerIds, eligiblePlayerIds));
}


@override
int get hashCode => Object.hash(runtimeType,amount,const DeepCollectionEquality().hash(eligiblePlayerIds));

@override
String toString() {
  return 'SidePot(amount: $amount, eligiblePlayerIds: $eligiblePlayerIds)';
}


}

/// @nodoc
abstract mixin class $SidePotCopyWith<$Res>  {
  factory $SidePotCopyWith(SidePot value, $Res Function(SidePot) _then) = _$SidePotCopyWithImpl;
@useResult
$Res call({
 double amount, List<String> eligiblePlayerIds
});




}
/// @nodoc
class _$SidePotCopyWithImpl<$Res>
    implements $SidePotCopyWith<$Res> {
  _$SidePotCopyWithImpl(this._self, this._then);

  final SidePot _self;
  final $Res Function(SidePot) _then;

/// Create a copy of SidePot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? eligiblePlayerIds = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,eligiblePlayerIds: null == eligiblePlayerIds ? _self.eligiblePlayerIds : eligiblePlayerIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SidePot].
extension SidePotPatterns on SidePot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SidePot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SidePot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SidePot value)  $default,){
final _that = this;
switch (_that) {
case _SidePot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SidePot value)?  $default,){
final _that = this;
switch (_that) {
case _SidePot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  List<String> eligiblePlayerIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SidePot() when $default != null:
return $default(_that.amount,_that.eligiblePlayerIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  List<String> eligiblePlayerIds)  $default,) {final _that = this;
switch (_that) {
case _SidePot():
return $default(_that.amount,_that.eligiblePlayerIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  List<String> eligiblePlayerIds)?  $default,) {final _that = this;
switch (_that) {
case _SidePot() when $default != null:
return $default(_that.amount,_that.eligiblePlayerIds);case _:
  return null;

}
}

}

/// @nodoc


class _SidePot implements SidePot {
  const _SidePot({required this.amount, required final  List<String> eligiblePlayerIds}): _eligiblePlayerIds = eligiblePlayerIds;
  

@override final  double amount;
 final  List<String> _eligiblePlayerIds;
@override List<String> get eligiblePlayerIds {
  if (_eligiblePlayerIds is EqualUnmodifiableListView) return _eligiblePlayerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eligiblePlayerIds);
}


/// Create a copy of SidePot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SidePotCopyWith<_SidePot> get copyWith => __$SidePotCopyWithImpl<_SidePot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SidePot&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other._eligiblePlayerIds, _eligiblePlayerIds));
}


@override
int get hashCode => Object.hash(runtimeType,amount,const DeepCollectionEquality().hash(_eligiblePlayerIds));

@override
String toString() {
  return 'SidePot(amount: $amount, eligiblePlayerIds: $eligiblePlayerIds)';
}


}

/// @nodoc
abstract mixin class _$SidePotCopyWith<$Res> implements $SidePotCopyWith<$Res> {
  factory _$SidePotCopyWith(_SidePot value, $Res Function(_SidePot) _then) = __$SidePotCopyWithImpl;
@override @useResult
$Res call({
 double amount, List<String> eligiblePlayerIds
});




}
/// @nodoc
class __$SidePotCopyWithImpl<$Res>
    implements _$SidePotCopyWith<$Res> {
  __$SidePotCopyWithImpl(this._self, this._then);

  final _SidePot _self;
  final $Res Function(_SidePot) _then;

/// Create a copy of SidePot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? eligiblePlayerIds = null,}) {
  return _then(_SidePot(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,eligiblePlayerIds: null == eligiblePlayerIds ? _self._eligiblePlayerIds : eligiblePlayerIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
