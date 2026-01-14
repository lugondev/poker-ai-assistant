// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Player {

 String get id; int get index; List<PlayingCard> get holeCards; PlayerEquity? get equity; bool get isHero; bool get isSelected; bool get useRange;/// Selected hand range for opponents (e.g., {'AA', 'AKs', 'KK'})
 Set<String> get selectedRange;
/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerCopyWith<Player> get copyWith => _$PlayerCopyWithImpl<Player>(this as Player, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Player&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index)&&const DeepCollectionEquality().equals(other.holeCards, holeCards)&&(identical(other.equity, equity) || other.equity == equity)&&(identical(other.isHero, isHero) || other.isHero == isHero)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.useRange, useRange) || other.useRange == useRange)&&const DeepCollectionEquality().equals(other.selectedRange, selectedRange));
}


@override
int get hashCode => Object.hash(runtimeType,id,index,const DeepCollectionEquality().hash(holeCards),equity,isHero,isSelected,useRange,const DeepCollectionEquality().hash(selectedRange));

@override
String toString() {
  return 'Player(id: $id, index: $index, holeCards: $holeCards, equity: $equity, isHero: $isHero, isSelected: $isSelected, useRange: $useRange, selectedRange: $selectedRange)';
}


}

/// @nodoc
abstract mixin class $PlayerCopyWith<$Res>  {
  factory $PlayerCopyWith(Player value, $Res Function(Player) _then) = _$PlayerCopyWithImpl;
@useResult
$Res call({
 String id, int index, List<PlayingCard> holeCards, PlayerEquity? equity, bool isHero, bool isSelected, bool useRange, Set<String> selectedRange
});


$PlayerEquityCopyWith<$Res>? get equity;

}
/// @nodoc
class _$PlayerCopyWithImpl<$Res>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._self, this._then);

  final Player _self;
  final $Res Function(Player) _then;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? index = null,Object? holeCards = null,Object? equity = freezed,Object? isHero = null,Object? isSelected = null,Object? useRange = null,Object? selectedRange = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,holeCards: null == holeCards ? _self.holeCards : holeCards // ignore: cast_nullable_to_non_nullable
as List<PlayingCard>,equity: freezed == equity ? _self.equity : equity // ignore: cast_nullable_to_non_nullable
as PlayerEquity?,isHero: null == isHero ? _self.isHero : isHero // ignore: cast_nullable_to_non_nullable
as bool,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,useRange: null == useRange ? _self.useRange : useRange // ignore: cast_nullable_to_non_nullable
as bool,selectedRange: null == selectedRange ? _self.selectedRange : selectedRange // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}
/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerEquityCopyWith<$Res>? get equity {
    if (_self.equity == null) {
    return null;
  }

  return $PlayerEquityCopyWith<$Res>(_self.equity!, (value) {
    return _then(_self.copyWith(equity: value));
  });
}
}


/// Adds pattern-matching-related methods to [Player].
extension PlayerPatterns on Player {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Player value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Player() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Player value)  $default,){
final _that = this;
switch (_that) {
case _Player():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Player value)?  $default,){
final _that = this;
switch (_that) {
case _Player() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int index,  List<PlayingCard> holeCards,  PlayerEquity? equity,  bool isHero,  bool isSelected,  bool useRange,  Set<String> selectedRange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.index,_that.holeCards,_that.equity,_that.isHero,_that.isSelected,_that.useRange,_that.selectedRange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int index,  List<PlayingCard> holeCards,  PlayerEquity? equity,  bool isHero,  bool isSelected,  bool useRange,  Set<String> selectedRange)  $default,) {final _that = this;
switch (_that) {
case _Player():
return $default(_that.id,_that.index,_that.holeCards,_that.equity,_that.isHero,_that.isSelected,_that.useRange,_that.selectedRange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int index,  List<PlayingCard> holeCards,  PlayerEquity? equity,  bool isHero,  bool isSelected,  bool useRange,  Set<String> selectedRange)?  $default,) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.index,_that.holeCards,_that.equity,_that.isHero,_that.isSelected,_that.useRange,_that.selectedRange);case _:
  return null;

}
}

}

/// @nodoc


class _Player extends Player {
  const _Player({required this.id, required this.index, final  List<PlayingCard> holeCards = const [], this.equity = null, this.isHero = false, this.isSelected = false, this.useRange = false, final  Set<String> selectedRange = const {}}): _holeCards = holeCards,_selectedRange = selectedRange,super._();
  

@override final  String id;
@override final  int index;
 final  List<PlayingCard> _holeCards;
@override@JsonKey() List<PlayingCard> get holeCards {
  if (_holeCards is EqualUnmodifiableListView) return _holeCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holeCards);
}

@override@JsonKey() final  PlayerEquity? equity;
@override@JsonKey() final  bool isHero;
@override@JsonKey() final  bool isSelected;
@override@JsonKey() final  bool useRange;
/// Selected hand range for opponents (e.g., {'AA', 'AKs', 'KK'})
 final  Set<String> _selectedRange;
/// Selected hand range for opponents (e.g., {'AA', 'AKs', 'KK'})
@override@JsonKey() Set<String> get selectedRange {
  if (_selectedRange is EqualUnmodifiableSetView) return _selectedRange;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedRange);
}


/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerCopyWith<_Player> get copyWith => __$PlayerCopyWithImpl<_Player>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Player&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index)&&const DeepCollectionEquality().equals(other._holeCards, _holeCards)&&(identical(other.equity, equity) || other.equity == equity)&&(identical(other.isHero, isHero) || other.isHero == isHero)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.useRange, useRange) || other.useRange == useRange)&&const DeepCollectionEquality().equals(other._selectedRange, _selectedRange));
}


@override
int get hashCode => Object.hash(runtimeType,id,index,const DeepCollectionEquality().hash(_holeCards),equity,isHero,isSelected,useRange,const DeepCollectionEquality().hash(_selectedRange));

@override
String toString() {
  return 'Player(id: $id, index: $index, holeCards: $holeCards, equity: $equity, isHero: $isHero, isSelected: $isSelected, useRange: $useRange, selectedRange: $selectedRange)';
}


}

/// @nodoc
abstract mixin class _$PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$PlayerCopyWith(_Player value, $Res Function(_Player) _then) = __$PlayerCopyWithImpl;
@override @useResult
$Res call({
 String id, int index, List<PlayingCard> holeCards, PlayerEquity? equity, bool isHero, bool isSelected, bool useRange, Set<String> selectedRange
});


@override $PlayerEquityCopyWith<$Res>? get equity;

}
/// @nodoc
class __$PlayerCopyWithImpl<$Res>
    implements _$PlayerCopyWith<$Res> {
  __$PlayerCopyWithImpl(this._self, this._then);

  final _Player _self;
  final $Res Function(_Player) _then;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? index = null,Object? holeCards = null,Object? equity = freezed,Object? isHero = null,Object? isSelected = null,Object? useRange = null,Object? selectedRange = null,}) {
  return _then(_Player(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,holeCards: null == holeCards ? _self._holeCards : holeCards // ignore: cast_nullable_to_non_nullable
as List<PlayingCard>,equity: freezed == equity ? _self.equity : equity // ignore: cast_nullable_to_non_nullable
as PlayerEquity?,isHero: null == isHero ? _self.isHero : isHero // ignore: cast_nullable_to_non_nullable
as bool,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,useRange: null == useRange ? _self.useRange : useRange // ignore: cast_nullable_to_non_nullable
as bool,selectedRange: null == selectedRange ? _self._selectedRange : selectedRange // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerEquityCopyWith<$Res>? get equity {
    if (_self.equity == null) {
    return null;
  }

  return $PlayerEquityCopyWith<$Res>(_self.equity!, (value) {
    return _then(_self.copyWith(equity: value));
  });
}
}

/// @nodoc
mixin _$PlayerEquity {

 double get winPercentage; double get tiePercentage; double get losePercentage;
/// Create a copy of PlayerEquity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerEquityCopyWith<PlayerEquity> get copyWith => _$PlayerEquityCopyWithImpl<PlayerEquity>(this as PlayerEquity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerEquity&&(identical(other.winPercentage, winPercentage) || other.winPercentage == winPercentage)&&(identical(other.tiePercentage, tiePercentage) || other.tiePercentage == tiePercentage)&&(identical(other.losePercentage, losePercentage) || other.losePercentage == losePercentage));
}


@override
int get hashCode => Object.hash(runtimeType,winPercentage,tiePercentage,losePercentage);

@override
String toString() {
  return 'PlayerEquity(winPercentage: $winPercentage, tiePercentage: $tiePercentage, losePercentage: $losePercentage)';
}


}

/// @nodoc
abstract mixin class $PlayerEquityCopyWith<$Res>  {
  factory $PlayerEquityCopyWith(PlayerEquity value, $Res Function(PlayerEquity) _then) = _$PlayerEquityCopyWithImpl;
@useResult
$Res call({
 double winPercentage, double tiePercentage, double losePercentage
});




}
/// @nodoc
class _$PlayerEquityCopyWithImpl<$Res>
    implements $PlayerEquityCopyWith<$Res> {
  _$PlayerEquityCopyWithImpl(this._self, this._then);

  final PlayerEquity _self;
  final $Res Function(PlayerEquity) _then;

/// Create a copy of PlayerEquity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? winPercentage = null,Object? tiePercentage = null,Object? losePercentage = null,}) {
  return _then(_self.copyWith(
winPercentage: null == winPercentage ? _self.winPercentage : winPercentage // ignore: cast_nullable_to_non_nullable
as double,tiePercentage: null == tiePercentage ? _self.tiePercentage : tiePercentage // ignore: cast_nullable_to_non_nullable
as double,losePercentage: null == losePercentage ? _self.losePercentage : losePercentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerEquity].
extension PlayerEquityPatterns on PlayerEquity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerEquity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerEquity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerEquity value)  $default,){
final _that = this;
switch (_that) {
case _PlayerEquity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerEquity value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerEquity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double winPercentage,  double tiePercentage,  double losePercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerEquity() when $default != null:
return $default(_that.winPercentage,_that.tiePercentage,_that.losePercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double winPercentage,  double tiePercentage,  double losePercentage)  $default,) {final _that = this;
switch (_that) {
case _PlayerEquity():
return $default(_that.winPercentage,_that.tiePercentage,_that.losePercentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double winPercentage,  double tiePercentage,  double losePercentage)?  $default,) {final _that = this;
switch (_that) {
case _PlayerEquity() when $default != null:
return $default(_that.winPercentage,_that.tiePercentage,_that.losePercentage);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerEquity extends PlayerEquity {
  const _PlayerEquity({required this.winPercentage, required this.tiePercentage, this.losePercentage = 0}): super._();
  

@override final  double winPercentage;
@override final  double tiePercentage;
@override@JsonKey() final  double losePercentage;

/// Create a copy of PlayerEquity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerEquityCopyWith<_PlayerEquity> get copyWith => __$PlayerEquityCopyWithImpl<_PlayerEquity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerEquity&&(identical(other.winPercentage, winPercentage) || other.winPercentage == winPercentage)&&(identical(other.tiePercentage, tiePercentage) || other.tiePercentage == tiePercentage)&&(identical(other.losePercentage, losePercentage) || other.losePercentage == losePercentage));
}


@override
int get hashCode => Object.hash(runtimeType,winPercentage,tiePercentage,losePercentage);

@override
String toString() {
  return 'PlayerEquity(winPercentage: $winPercentage, tiePercentage: $tiePercentage, losePercentage: $losePercentage)';
}


}

/// @nodoc
abstract mixin class _$PlayerEquityCopyWith<$Res> implements $PlayerEquityCopyWith<$Res> {
  factory _$PlayerEquityCopyWith(_PlayerEquity value, $Res Function(_PlayerEquity) _then) = __$PlayerEquityCopyWithImpl;
@override @useResult
$Res call({
 double winPercentage, double tiePercentage, double losePercentage
});




}
/// @nodoc
class __$PlayerEquityCopyWithImpl<$Res>
    implements _$PlayerEquityCopyWith<$Res> {
  __$PlayerEquityCopyWithImpl(this._self, this._then);

  final _PlayerEquity _self;
  final $Res Function(_PlayerEquity) _then;

/// Create a copy of PlayerEquity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? winPercentage = null,Object? tiePercentage = null,Object? losePercentage = null,}) {
  return _then(_PlayerEquity(
winPercentage: null == winPercentage ? _self.winPercentage : winPercentage // ignore: cast_nullable_to_non_nullable
as double,tiePercentage: null == tiePercentage ? _self.tiePercentage : tiePercentage // ignore: cast_nullable_to_non_nullable
as double,losePercentage: null == losePercentage ? _self.losePercentage : losePercentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$PlayerAction {

 String get playerId; BettingRound get round; BettingAction get action; double get amount;
/// Create a copy of PlayerAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerActionCopyWith<PlayerAction> get copyWith => _$PlayerActionCopyWithImpl<PlayerAction>(this as PlayerAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerAction&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.round, round) || other.round == round)&&(identical(other.action, action) || other.action == action)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,playerId,round,action,amount);

@override
String toString() {
  return 'PlayerAction(playerId: $playerId, round: $round, action: $action, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $PlayerActionCopyWith<$Res>  {
  factory $PlayerActionCopyWith(PlayerAction value, $Res Function(PlayerAction) _then) = _$PlayerActionCopyWithImpl;
@useResult
$Res call({
 String playerId, BettingRound round, BettingAction action, double amount
});




}
/// @nodoc
class _$PlayerActionCopyWithImpl<$Res>
    implements $PlayerActionCopyWith<$Res> {
  _$PlayerActionCopyWithImpl(this._self, this._then);

  final PlayerAction _self;
  final $Res Function(PlayerAction) _then;

/// Create a copy of PlayerAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? round = null,Object? action = null,Object? amount = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as BettingRound,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as BettingAction,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerAction].
extension PlayerActionPatterns on PlayerAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerAction value)  $default,){
final _that = this;
switch (_that) {
case _PlayerAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerAction value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  BettingRound round,  BettingAction action,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerAction() when $default != null:
return $default(_that.playerId,_that.round,_that.action,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  BettingRound round,  BettingAction action,  double amount)  $default,) {final _that = this;
switch (_that) {
case _PlayerAction():
return $default(_that.playerId,_that.round,_that.action,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  BettingRound round,  BettingAction action,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _PlayerAction() when $default != null:
return $default(_that.playerId,_that.round,_that.action,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerAction implements PlayerAction {
  const _PlayerAction({required this.playerId, required this.round, required this.action, this.amount = 0});
  

@override final  String playerId;
@override final  BettingRound round;
@override final  BettingAction action;
@override@JsonKey() final  double amount;

/// Create a copy of PlayerAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerActionCopyWith<_PlayerAction> get copyWith => __$PlayerActionCopyWithImpl<_PlayerAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerAction&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.round, round) || other.round == round)&&(identical(other.action, action) || other.action == action)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,playerId,round,action,amount);

@override
String toString() {
  return 'PlayerAction(playerId: $playerId, round: $round, action: $action, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$PlayerActionCopyWith<$Res> implements $PlayerActionCopyWith<$Res> {
  factory _$PlayerActionCopyWith(_PlayerAction value, $Res Function(_PlayerAction) _then) = __$PlayerActionCopyWithImpl;
@override @useResult
$Res call({
 String playerId, BettingRound round, BettingAction action, double amount
});




}
/// @nodoc
class __$PlayerActionCopyWithImpl<$Res>
    implements _$PlayerActionCopyWith<$Res> {
  __$PlayerActionCopyWithImpl(this._self, this._then);

  final _PlayerAction _self;
  final $Res Function(_PlayerAction) _then;

/// Create a copy of PlayerAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? round = null,Object? action = null,Object? amount = null,}) {
  return _then(_PlayerAction(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as BettingRound,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as BettingAction,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
