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

 List<PlayingCard> get playerHand; List<PlayingCard> get boardCards; EquityResult? get equityResult; bool get isCalculating; SelectionTarget get selectionTarget; String? get errorMessage; int get opponentCount; String? get currentHandRank;
/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculatorStateCopyWith<CalculatorState> get copyWith => _$CalculatorStateCopyWithImpl<CalculatorState>(this as CalculatorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculatorState&&const DeepCollectionEquality().equals(other.playerHand, playerHand)&&const DeepCollectionEquality().equals(other.boardCards, boardCards)&&(identical(other.equityResult, equityResult) || other.equityResult == equityResult)&&(identical(other.isCalculating, isCalculating) || other.isCalculating == isCalculating)&&(identical(other.selectionTarget, selectionTarget) || other.selectionTarget == selectionTarget)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.opponentCount, opponentCount) || other.opponentCount == opponentCount)&&(identical(other.currentHandRank, currentHandRank) || other.currentHandRank == currentHandRank));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(playerHand),const DeepCollectionEquality().hash(boardCards),equityResult,isCalculating,selectionTarget,errorMessage,opponentCount,currentHandRank);

@override
String toString() {
  return 'CalculatorState(playerHand: $playerHand, boardCards: $boardCards, equityResult: $equityResult, isCalculating: $isCalculating, selectionTarget: $selectionTarget, errorMessage: $errorMessage, opponentCount: $opponentCount, currentHandRank: $currentHandRank)';
}


}

/// @nodoc
abstract mixin class $CalculatorStateCopyWith<$Res>  {
  factory $CalculatorStateCopyWith(CalculatorState value, $Res Function(CalculatorState) _then) = _$CalculatorStateCopyWithImpl;
@useResult
$Res call({
 List<PlayingCard> playerHand, List<PlayingCard> boardCards, EquityResult? equityResult, bool isCalculating, SelectionTarget selectionTarget, String? errorMessage, int opponentCount, String? currentHandRank
});




}
/// @nodoc
class _$CalculatorStateCopyWithImpl<$Res>
    implements $CalculatorStateCopyWith<$Res> {
  _$CalculatorStateCopyWithImpl(this._self, this._then);

  final CalculatorState _self;
  final $Res Function(CalculatorState) _then;

/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerHand = null,Object? boardCards = null,Object? equityResult = freezed,Object? isCalculating = null,Object? selectionTarget = null,Object? errorMessage = freezed,Object? opponentCount = null,Object? currentHandRank = freezed,}) {
  return _then(_self.copyWith(
playerHand: null == playerHand ? _self.playerHand : playerHand // ignore: cast_nullable_to_non_nullable
as List<PlayingCard>,boardCards: null == boardCards ? _self.boardCards : boardCards // ignore: cast_nullable_to_non_nullable
as List<PlayingCard>,equityResult: freezed == equityResult ? _self.equityResult : equityResult // ignore: cast_nullable_to_non_nullable
as EquityResult?,isCalculating: null == isCalculating ? _self.isCalculating : isCalculating // ignore: cast_nullable_to_non_nullable
as bool,selectionTarget: null == selectionTarget ? _self.selectionTarget : selectionTarget // ignore: cast_nullable_to_non_nullable
as SelectionTarget,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,opponentCount: null == opponentCount ? _self.opponentCount : opponentCount // ignore: cast_nullable_to_non_nullable
as int,currentHandRank: freezed == currentHandRank ? _self.currentHandRank : currentHandRank // ignore: cast_nullable_to_non_nullable
as String?,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlayingCard> playerHand,  List<PlayingCard> boardCards,  EquityResult? equityResult,  bool isCalculating,  SelectionTarget selectionTarget,  String? errorMessage,  int opponentCount,  String? currentHandRank)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculatorState() when $default != null:
return $default(_that.playerHand,_that.boardCards,_that.equityResult,_that.isCalculating,_that.selectionTarget,_that.errorMessage,_that.opponentCount,_that.currentHandRank);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlayingCard> playerHand,  List<PlayingCard> boardCards,  EquityResult? equityResult,  bool isCalculating,  SelectionTarget selectionTarget,  String? errorMessage,  int opponentCount,  String? currentHandRank)  $default,) {final _that = this;
switch (_that) {
case _CalculatorState():
return $default(_that.playerHand,_that.boardCards,_that.equityResult,_that.isCalculating,_that.selectionTarget,_that.errorMessage,_that.opponentCount,_that.currentHandRank);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlayingCard> playerHand,  List<PlayingCard> boardCards,  EquityResult? equityResult,  bool isCalculating,  SelectionTarget selectionTarget,  String? errorMessage,  int opponentCount,  String? currentHandRank)?  $default,) {final _that = this;
switch (_that) {
case _CalculatorState() when $default != null:
return $default(_that.playerHand,_that.boardCards,_that.equityResult,_that.isCalculating,_that.selectionTarget,_that.errorMessage,_that.opponentCount,_that.currentHandRank);case _:
  return null;

}
}

}

/// @nodoc


class _CalculatorState extends CalculatorState {
  const _CalculatorState({final  List<PlayingCard> playerHand = const [], final  List<PlayingCard> boardCards = const [], this.equityResult = null, this.isCalculating = false, this.selectionTarget = SelectionTarget.playerHand, this.errorMessage = null, this.opponentCount = 1, this.currentHandRank = null}): _playerHand = playerHand,_boardCards = boardCards,super._();
  

 final  List<PlayingCard> _playerHand;
@override@JsonKey() List<PlayingCard> get playerHand {
  if (_playerHand is EqualUnmodifiableListView) return _playerHand;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playerHand);
}

 final  List<PlayingCard> _boardCards;
@override@JsonKey() List<PlayingCard> get boardCards {
  if (_boardCards is EqualUnmodifiableListView) return _boardCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_boardCards);
}

@override@JsonKey() final  EquityResult? equityResult;
@override@JsonKey() final  bool isCalculating;
@override@JsonKey() final  SelectionTarget selectionTarget;
@override@JsonKey() final  String? errorMessage;
@override@JsonKey() final  int opponentCount;
@override@JsonKey() final  String? currentHandRank;

/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculatorStateCopyWith<_CalculatorState> get copyWith => __$CalculatorStateCopyWithImpl<_CalculatorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculatorState&&const DeepCollectionEquality().equals(other._playerHand, _playerHand)&&const DeepCollectionEquality().equals(other._boardCards, _boardCards)&&(identical(other.equityResult, equityResult) || other.equityResult == equityResult)&&(identical(other.isCalculating, isCalculating) || other.isCalculating == isCalculating)&&(identical(other.selectionTarget, selectionTarget) || other.selectionTarget == selectionTarget)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.opponentCount, opponentCount) || other.opponentCount == opponentCount)&&(identical(other.currentHandRank, currentHandRank) || other.currentHandRank == currentHandRank));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_playerHand),const DeepCollectionEquality().hash(_boardCards),equityResult,isCalculating,selectionTarget,errorMessage,opponentCount,currentHandRank);

@override
String toString() {
  return 'CalculatorState(playerHand: $playerHand, boardCards: $boardCards, equityResult: $equityResult, isCalculating: $isCalculating, selectionTarget: $selectionTarget, errorMessage: $errorMessage, opponentCount: $opponentCount, currentHandRank: $currentHandRank)';
}


}

/// @nodoc
abstract mixin class _$CalculatorStateCopyWith<$Res> implements $CalculatorStateCopyWith<$Res> {
  factory _$CalculatorStateCopyWith(_CalculatorState value, $Res Function(_CalculatorState) _then) = __$CalculatorStateCopyWithImpl;
@override @useResult
$Res call({
 List<PlayingCard> playerHand, List<PlayingCard> boardCards, EquityResult? equityResult, bool isCalculating, SelectionTarget selectionTarget, String? errorMessage, int opponentCount, String? currentHandRank
});




}
/// @nodoc
class __$CalculatorStateCopyWithImpl<$Res>
    implements _$CalculatorStateCopyWith<$Res> {
  __$CalculatorStateCopyWithImpl(this._self, this._then);

  final _CalculatorState _self;
  final $Res Function(_CalculatorState) _then;

/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerHand = null,Object? boardCards = null,Object? equityResult = freezed,Object? isCalculating = null,Object? selectionTarget = null,Object? errorMessage = freezed,Object? opponentCount = null,Object? currentHandRank = freezed,}) {
  return _then(_CalculatorState(
playerHand: null == playerHand ? _self._playerHand : playerHand // ignore: cast_nullable_to_non_nullable
as List<PlayingCard>,boardCards: null == boardCards ? _self._boardCards : boardCards // ignore: cast_nullable_to_non_nullable
as List<PlayingCard>,equityResult: freezed == equityResult ? _self.equityResult : equityResult // ignore: cast_nullable_to_non_nullable
as EquityResult?,isCalculating: null == isCalculating ? _self.isCalculating : isCalculating // ignore: cast_nullable_to_non_nullable
as bool,selectionTarget: null == selectionTarget ? _self.selectionTarget : selectionTarget // ignore: cast_nullable_to_non_nullable
as SelectionTarget,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,opponentCount: null == opponentCount ? _self.opponentCount : opponentCount // ignore: cast_nullable_to_non_nullable
as int,currentHandRank: freezed == currentHandRank ? _self.currentHandRank : currentHandRank // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
