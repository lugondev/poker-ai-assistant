// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatMessage {

 String get id; String get content; MessageSender get sender; DateTime get timestamp;/// Optional context snapshot at the time of message
 GameContextSnapshot? get context;/// Is this message still being streamed
 bool get isStreaming;/// Error message if failed
 String? get error;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.context, context) || other.context == context)&&(identical(other.isStreaming, isStreaming) || other.isStreaming == isStreaming)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,sender,timestamp,context,isStreaming,error);

@override
String toString() {
  return 'ChatMessage(id: $id, content: $content, sender: $sender, timestamp: $timestamp, context: $context, isStreaming: $isStreaming, error: $error)';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, String content, MessageSender sender, DateTime timestamp, GameContextSnapshot? context, bool isStreaming, String? error
});


$GameContextSnapshotCopyWith<$Res>? get context;

}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? sender = null,Object? timestamp = null,Object? context = freezed,Object? isStreaming = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSender,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as GameContextSnapshot?,isStreaming: null == isStreaming ? _self.isStreaming : isStreaming // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameContextSnapshotCopyWith<$Res>? get context {
    if (_self.context == null) {
    return null;
  }

  return $GameContextSnapshotCopyWith<$Res>(_self.context!, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String content,  MessageSender sender,  DateTime timestamp,  GameContextSnapshot? context,  bool isStreaming,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.content,_that.sender,_that.timestamp,_that.context,_that.isStreaming,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String content,  MessageSender sender,  DateTime timestamp,  GameContextSnapshot? context,  bool isStreaming,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.content,_that.sender,_that.timestamp,_that.context,_that.isStreaming,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String content,  MessageSender sender,  DateTime timestamp,  GameContextSnapshot? context,  bool isStreaming,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.content,_that.sender,_that.timestamp,_that.context,_that.isStreaming,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ChatMessage extends ChatMessage {
  const _ChatMessage({required this.id, required this.content, required this.sender, required this.timestamp, this.context = null, this.isStreaming = false, this.error = null}): super._();
  

@override final  String id;
@override final  String content;
@override final  MessageSender sender;
@override final  DateTime timestamp;
/// Optional context snapshot at the time of message
@override@JsonKey() final  GameContextSnapshot? context;
/// Is this message still being streamed
@override@JsonKey() final  bool isStreaming;
/// Error message if failed
@override@JsonKey() final  String? error;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.context, context) || other.context == context)&&(identical(other.isStreaming, isStreaming) || other.isStreaming == isStreaming)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,sender,timestamp,context,isStreaming,error);

@override
String toString() {
  return 'ChatMessage(id: $id, content: $content, sender: $sender, timestamp: $timestamp, context: $context, isStreaming: $isStreaming, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String content, MessageSender sender, DateTime timestamp, GameContextSnapshot? context, bool isStreaming, String? error
});


@override $GameContextSnapshotCopyWith<$Res>? get context;

}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? sender = null,Object? timestamp = null,Object? context = freezed,Object? isStreaming = null,Object? error = freezed,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSender,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as GameContextSnapshot?,isStreaming: null == isStreaming ? _self.isStreaming : isStreaming // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameContextSnapshotCopyWith<$Res>? get context {
    if (_self.context == null) {
    return null;
  }

  return $GameContextSnapshotCopyWith<$Res>(_self.context!, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}

/// @nodoc
mixin _$GameContextSnapshot {

/// Hero's hole cards as display strings (e.g., ['A♠', 'K♥'])
 List<String> get heroCards;/// Board cards as display strings
 List<String> get boardCards;/// Current board phase (preflop, flop, turn, river)
 String get boardPhase;/// Number of opponents
 int get opponentCount;/// Current pot size
 double get potSize;/// Amount to call
 double get amountToCall;/// Hero's calculated equity (if available)
 double? get heroEquity;/// Pot odds ratio string
 String get potOddsRatio;/// Required equity to call
 double get requiredEquity;/// Hero's current hand rank (if board has cards)
 String? get heroHandRank;
/// Create a copy of GameContextSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameContextSnapshotCopyWith<GameContextSnapshot> get copyWith => _$GameContextSnapshotCopyWithImpl<GameContextSnapshot>(this as GameContextSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameContextSnapshot&&const DeepCollectionEquality().equals(other.heroCards, heroCards)&&const DeepCollectionEquality().equals(other.boardCards, boardCards)&&(identical(other.boardPhase, boardPhase) || other.boardPhase == boardPhase)&&(identical(other.opponentCount, opponentCount) || other.opponentCount == opponentCount)&&(identical(other.potSize, potSize) || other.potSize == potSize)&&(identical(other.amountToCall, amountToCall) || other.amountToCall == amountToCall)&&(identical(other.heroEquity, heroEquity) || other.heroEquity == heroEquity)&&(identical(other.potOddsRatio, potOddsRatio) || other.potOddsRatio == potOddsRatio)&&(identical(other.requiredEquity, requiredEquity) || other.requiredEquity == requiredEquity)&&(identical(other.heroHandRank, heroHandRank) || other.heroHandRank == heroHandRank));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(heroCards),const DeepCollectionEquality().hash(boardCards),boardPhase,opponentCount,potSize,amountToCall,heroEquity,potOddsRatio,requiredEquity,heroHandRank);

@override
String toString() {
  return 'GameContextSnapshot(heroCards: $heroCards, boardCards: $boardCards, boardPhase: $boardPhase, opponentCount: $opponentCount, potSize: $potSize, amountToCall: $amountToCall, heroEquity: $heroEquity, potOddsRatio: $potOddsRatio, requiredEquity: $requiredEquity, heroHandRank: $heroHandRank)';
}


}

/// @nodoc
abstract mixin class $GameContextSnapshotCopyWith<$Res>  {
  factory $GameContextSnapshotCopyWith(GameContextSnapshot value, $Res Function(GameContextSnapshot) _then) = _$GameContextSnapshotCopyWithImpl;
@useResult
$Res call({
 List<String> heroCards, List<String> boardCards, String boardPhase, int opponentCount, double potSize, double amountToCall, double? heroEquity, String potOddsRatio, double requiredEquity, String? heroHandRank
});




}
/// @nodoc
class _$GameContextSnapshotCopyWithImpl<$Res>
    implements $GameContextSnapshotCopyWith<$Res> {
  _$GameContextSnapshotCopyWithImpl(this._self, this._then);

  final GameContextSnapshot _self;
  final $Res Function(GameContextSnapshot) _then;

/// Create a copy of GameContextSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? heroCards = null,Object? boardCards = null,Object? boardPhase = null,Object? opponentCount = null,Object? potSize = null,Object? amountToCall = null,Object? heroEquity = freezed,Object? potOddsRatio = null,Object? requiredEquity = null,Object? heroHandRank = freezed,}) {
  return _then(_self.copyWith(
heroCards: null == heroCards ? _self.heroCards : heroCards // ignore: cast_nullable_to_non_nullable
as List<String>,boardCards: null == boardCards ? _self.boardCards : boardCards // ignore: cast_nullable_to_non_nullable
as List<String>,boardPhase: null == boardPhase ? _self.boardPhase : boardPhase // ignore: cast_nullable_to_non_nullable
as String,opponentCount: null == opponentCount ? _self.opponentCount : opponentCount // ignore: cast_nullable_to_non_nullable
as int,potSize: null == potSize ? _self.potSize : potSize // ignore: cast_nullable_to_non_nullable
as double,amountToCall: null == amountToCall ? _self.amountToCall : amountToCall // ignore: cast_nullable_to_non_nullable
as double,heroEquity: freezed == heroEquity ? _self.heroEquity : heroEquity // ignore: cast_nullable_to_non_nullable
as double?,potOddsRatio: null == potOddsRatio ? _self.potOddsRatio : potOddsRatio // ignore: cast_nullable_to_non_nullable
as String,requiredEquity: null == requiredEquity ? _self.requiredEquity : requiredEquity // ignore: cast_nullable_to_non_nullable
as double,heroHandRank: freezed == heroHandRank ? _self.heroHandRank : heroHandRank // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameContextSnapshot].
extension GameContextSnapshotPatterns on GameContextSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameContextSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameContextSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameContextSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _GameContextSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameContextSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _GameContextSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> heroCards,  List<String> boardCards,  String boardPhase,  int opponentCount,  double potSize,  double amountToCall,  double? heroEquity,  String potOddsRatio,  double requiredEquity,  String? heroHandRank)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameContextSnapshot() when $default != null:
return $default(_that.heroCards,_that.boardCards,_that.boardPhase,_that.opponentCount,_that.potSize,_that.amountToCall,_that.heroEquity,_that.potOddsRatio,_that.requiredEquity,_that.heroHandRank);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> heroCards,  List<String> boardCards,  String boardPhase,  int opponentCount,  double potSize,  double amountToCall,  double? heroEquity,  String potOddsRatio,  double requiredEquity,  String? heroHandRank)  $default,) {final _that = this;
switch (_that) {
case _GameContextSnapshot():
return $default(_that.heroCards,_that.boardCards,_that.boardPhase,_that.opponentCount,_that.potSize,_that.amountToCall,_that.heroEquity,_that.potOddsRatio,_that.requiredEquity,_that.heroHandRank);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> heroCards,  List<String> boardCards,  String boardPhase,  int opponentCount,  double potSize,  double amountToCall,  double? heroEquity,  String potOddsRatio,  double requiredEquity,  String? heroHandRank)?  $default,) {final _that = this;
switch (_that) {
case _GameContextSnapshot() when $default != null:
return $default(_that.heroCards,_that.boardCards,_that.boardPhase,_that.opponentCount,_that.potSize,_that.amountToCall,_that.heroEquity,_that.potOddsRatio,_that.requiredEquity,_that.heroHandRank);case _:
  return null;

}
}

}

/// @nodoc


class _GameContextSnapshot extends GameContextSnapshot {
  const _GameContextSnapshot({final  List<String> heroCards = const [], final  List<String> boardCards = const [], this.boardPhase = 'preflop', this.opponentCount = 0, this.potSize = 0, this.amountToCall = 0, this.heroEquity = null, this.potOddsRatio = '-', this.requiredEquity = 0, this.heroHandRank = null}): _heroCards = heroCards,_boardCards = boardCards,super._();
  

/// Hero's hole cards as display strings (e.g., ['A♠', 'K♥'])
 final  List<String> _heroCards;
/// Hero's hole cards as display strings (e.g., ['A♠', 'K♥'])
@override@JsonKey() List<String> get heroCards {
  if (_heroCards is EqualUnmodifiableListView) return _heroCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_heroCards);
}

/// Board cards as display strings
 final  List<String> _boardCards;
/// Board cards as display strings
@override@JsonKey() List<String> get boardCards {
  if (_boardCards is EqualUnmodifiableListView) return _boardCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_boardCards);
}

/// Current board phase (preflop, flop, turn, river)
@override@JsonKey() final  String boardPhase;
/// Number of opponents
@override@JsonKey() final  int opponentCount;
/// Current pot size
@override@JsonKey() final  double potSize;
/// Amount to call
@override@JsonKey() final  double amountToCall;
/// Hero's calculated equity (if available)
@override@JsonKey() final  double? heroEquity;
/// Pot odds ratio string
@override@JsonKey() final  String potOddsRatio;
/// Required equity to call
@override@JsonKey() final  double requiredEquity;
/// Hero's current hand rank (if board has cards)
@override@JsonKey() final  String? heroHandRank;

/// Create a copy of GameContextSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameContextSnapshotCopyWith<_GameContextSnapshot> get copyWith => __$GameContextSnapshotCopyWithImpl<_GameContextSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameContextSnapshot&&const DeepCollectionEquality().equals(other._heroCards, _heroCards)&&const DeepCollectionEquality().equals(other._boardCards, _boardCards)&&(identical(other.boardPhase, boardPhase) || other.boardPhase == boardPhase)&&(identical(other.opponentCount, opponentCount) || other.opponentCount == opponentCount)&&(identical(other.potSize, potSize) || other.potSize == potSize)&&(identical(other.amountToCall, amountToCall) || other.amountToCall == amountToCall)&&(identical(other.heroEquity, heroEquity) || other.heroEquity == heroEquity)&&(identical(other.potOddsRatio, potOddsRatio) || other.potOddsRatio == potOddsRatio)&&(identical(other.requiredEquity, requiredEquity) || other.requiredEquity == requiredEquity)&&(identical(other.heroHandRank, heroHandRank) || other.heroHandRank == heroHandRank));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_heroCards),const DeepCollectionEquality().hash(_boardCards),boardPhase,opponentCount,potSize,amountToCall,heroEquity,potOddsRatio,requiredEquity,heroHandRank);

@override
String toString() {
  return 'GameContextSnapshot(heroCards: $heroCards, boardCards: $boardCards, boardPhase: $boardPhase, opponentCount: $opponentCount, potSize: $potSize, amountToCall: $amountToCall, heroEquity: $heroEquity, potOddsRatio: $potOddsRatio, requiredEquity: $requiredEquity, heroHandRank: $heroHandRank)';
}


}

/// @nodoc
abstract mixin class _$GameContextSnapshotCopyWith<$Res> implements $GameContextSnapshotCopyWith<$Res> {
  factory _$GameContextSnapshotCopyWith(_GameContextSnapshot value, $Res Function(_GameContextSnapshot) _then) = __$GameContextSnapshotCopyWithImpl;
@override @useResult
$Res call({
 List<String> heroCards, List<String> boardCards, String boardPhase, int opponentCount, double potSize, double amountToCall, double? heroEquity, String potOddsRatio, double requiredEquity, String? heroHandRank
});




}
/// @nodoc
class __$GameContextSnapshotCopyWithImpl<$Res>
    implements _$GameContextSnapshotCopyWith<$Res> {
  __$GameContextSnapshotCopyWithImpl(this._self, this._then);

  final _GameContextSnapshot _self;
  final $Res Function(_GameContextSnapshot) _then;

/// Create a copy of GameContextSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? heroCards = null,Object? boardCards = null,Object? boardPhase = null,Object? opponentCount = null,Object? potSize = null,Object? amountToCall = null,Object? heroEquity = freezed,Object? potOddsRatio = null,Object? requiredEquity = null,Object? heroHandRank = freezed,}) {
  return _then(_GameContextSnapshot(
heroCards: null == heroCards ? _self._heroCards : heroCards // ignore: cast_nullable_to_non_nullable
as List<String>,boardCards: null == boardCards ? _self._boardCards : boardCards // ignore: cast_nullable_to_non_nullable
as List<String>,boardPhase: null == boardPhase ? _self.boardPhase : boardPhase // ignore: cast_nullable_to_non_nullable
as String,opponentCount: null == opponentCount ? _self.opponentCount : opponentCount // ignore: cast_nullable_to_non_nullable
as int,potSize: null == potSize ? _self.potSize : potSize // ignore: cast_nullable_to_non_nullable
as double,amountToCall: null == amountToCall ? _self.amountToCall : amountToCall // ignore: cast_nullable_to_non_nullable
as double,heroEquity: freezed == heroEquity ? _self.heroEquity : heroEquity // ignore: cast_nullable_to_non_nullable
as double?,potOddsRatio: null == potOddsRatio ? _self.potOddsRatio : potOddsRatio // ignore: cast_nullable_to_non_nullable
as String,requiredEquity: null == requiredEquity ? _self.requiredEquity : requiredEquity // ignore: cast_nullable_to_non_nullable
as double,heroHandRank: freezed == heroHandRank ? _self.heroHandRank : heroHandRank // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$QuickAction {

 String get label; String get prompt; String? get icon;
/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuickActionCopyWith<QuickAction> get copyWith => _$QuickActionCopyWithImpl<QuickAction>(this as QuickAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuickAction&&(identical(other.label, label) || other.label == label)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,label,prompt,icon);

@override
String toString() {
  return 'QuickAction(label: $label, prompt: $prompt, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $QuickActionCopyWith<$Res>  {
  factory $QuickActionCopyWith(QuickAction value, $Res Function(QuickAction) _then) = _$QuickActionCopyWithImpl;
@useResult
$Res call({
 String label, String prompt, String? icon
});




}
/// @nodoc
class _$QuickActionCopyWithImpl<$Res>
    implements $QuickActionCopyWith<$Res> {
  _$QuickActionCopyWithImpl(this._self, this._then);

  final QuickAction _self;
  final $Res Function(QuickAction) _then;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? prompt = null,Object? icon = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuickAction].
extension QuickActionPatterns on QuickAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuickAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuickAction value)  $default,){
final _that = this;
switch (_that) {
case _QuickAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuickAction value)?  $default,){
final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String prompt,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
return $default(_that.label,_that.prompt,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String prompt,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _QuickAction():
return $default(_that.label,_that.prompt,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String prompt,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
return $default(_that.label,_that.prompt,_that.icon);case _:
  return null;

}
}

}

/// @nodoc


class _QuickAction implements QuickAction {
  const _QuickAction({required this.label, required this.prompt, this.icon = null});
  

@override final  String label;
@override final  String prompt;
@override@JsonKey() final  String? icon;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuickActionCopyWith<_QuickAction> get copyWith => __$QuickActionCopyWithImpl<_QuickAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuickAction&&(identical(other.label, label) || other.label == label)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,label,prompt,icon);

@override
String toString() {
  return 'QuickAction(label: $label, prompt: $prompt, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$QuickActionCopyWith<$Res> implements $QuickActionCopyWith<$Res> {
  factory _$QuickActionCopyWith(_QuickAction value, $Res Function(_QuickAction) _then) = __$QuickActionCopyWithImpl;
@override @useResult
$Res call({
 String label, String prompt, String? icon
});




}
/// @nodoc
class __$QuickActionCopyWithImpl<$Res>
    implements _$QuickActionCopyWith<$Res> {
  __$QuickActionCopyWithImpl(this._self, this._then);

  final _QuickAction _self;
  final $Res Function(_QuickAction) _then;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? prompt = null,Object? icon = freezed,}) {
  return _then(_QuickAction(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
