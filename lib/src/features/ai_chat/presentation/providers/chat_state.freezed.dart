// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatState {

/// List of chat messages
 List<ChatMessage> get messages;/// Is the chat panel open
 bool get isOpen;/// Is AI currently generating a response
 bool get isTyping;/// Content being streamed (partial response)
 String get streamingContent;/// Error message if something failed
 String? get errorMessage;/// Quick action suggestions based on context
 List<QuickAction> get quickActions;/// Current game context snapshot
 GameContextSnapshot? get currentContext;/// Number of unread messages
 int get unreadCount;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.isTyping, isTyping) || other.isTyping == isTyping)&&(identical(other.streamingContent, streamingContent) || other.streamingContent == streamingContent)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.quickActions, quickActions)&&(identical(other.currentContext, currentContext) || other.currentContext == currentContext)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),isOpen,isTyping,streamingContent,errorMessage,const DeepCollectionEquality().hash(quickActions),currentContext,unreadCount);

@override
String toString() {
  return 'ChatState(messages: $messages, isOpen: $isOpen, isTyping: $isTyping, streamingContent: $streamingContent, errorMessage: $errorMessage, quickActions: $quickActions, currentContext: $currentContext, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 List<ChatMessage> messages, bool isOpen, bool isTyping, String streamingContent, String? errorMessage, List<QuickAction> quickActions, GameContextSnapshot? currentContext, int unreadCount
});


$GameContextSnapshotCopyWith<$Res>? get currentContext;

}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? isOpen = null,Object? isTyping = null,Object? streamingContent = null,Object? errorMessage = freezed,Object? quickActions = null,Object? currentContext = freezed,Object? unreadCount = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,isTyping: null == isTyping ? _self.isTyping : isTyping // ignore: cast_nullable_to_non_nullable
as bool,streamingContent: null == streamingContent ? _self.streamingContent : streamingContent // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,quickActions: null == quickActions ? _self.quickActions : quickActions // ignore: cast_nullable_to_non_nullable
as List<QuickAction>,currentContext: freezed == currentContext ? _self.currentContext : currentContext // ignore: cast_nullable_to_non_nullable
as GameContextSnapshot?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameContextSnapshotCopyWith<$Res>? get currentContext {
    if (_self.currentContext == null) {
    return null;
  }

  return $GameContextSnapshotCopyWith<$Res>(_self.currentContext!, (value) {
    return _then(_self.copyWith(currentContext: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatState value)  $default,){
final _that = this;
switch (_that) {
case _ChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatMessage> messages,  bool isOpen,  bool isTyping,  String streamingContent,  String? errorMessage,  List<QuickAction> quickActions,  GameContextSnapshot? currentContext,  int unreadCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.messages,_that.isOpen,_that.isTyping,_that.streamingContent,_that.errorMessage,_that.quickActions,_that.currentContext,_that.unreadCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatMessage> messages,  bool isOpen,  bool isTyping,  String streamingContent,  String? errorMessage,  List<QuickAction> quickActions,  GameContextSnapshot? currentContext,  int unreadCount)  $default,) {final _that = this;
switch (_that) {
case _ChatState():
return $default(_that.messages,_that.isOpen,_that.isTyping,_that.streamingContent,_that.errorMessage,_that.quickActions,_that.currentContext,_that.unreadCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatMessage> messages,  bool isOpen,  bool isTyping,  String streamingContent,  String? errorMessage,  List<QuickAction> quickActions,  GameContextSnapshot? currentContext,  int unreadCount)?  $default,) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.messages,_that.isOpen,_that.isTyping,_that.streamingContent,_that.errorMessage,_that.quickActions,_that.currentContext,_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc


class _ChatState extends ChatState {
  const _ChatState({final  List<ChatMessage> messages = const [], this.isOpen = false, this.isTyping = false, this.streamingContent = '', this.errorMessage = null, final  List<QuickAction> quickActions = const [], this.currentContext = null, this.unreadCount = 0}): _messages = messages,_quickActions = quickActions,super._();
  

/// List of chat messages
 final  List<ChatMessage> _messages;
/// List of chat messages
@override@JsonKey() List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

/// Is the chat panel open
@override@JsonKey() final  bool isOpen;
/// Is AI currently generating a response
@override@JsonKey() final  bool isTyping;
/// Content being streamed (partial response)
@override@JsonKey() final  String streamingContent;
/// Error message if something failed
@override@JsonKey() final  String? errorMessage;
/// Quick action suggestions based on context
 final  List<QuickAction> _quickActions;
/// Quick action suggestions based on context
@override@JsonKey() List<QuickAction> get quickActions {
  if (_quickActions is EqualUnmodifiableListView) return _quickActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quickActions);
}

/// Current game context snapshot
@override@JsonKey() final  GameContextSnapshot? currentContext;
/// Number of unread messages
@override@JsonKey() final  int unreadCount;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatStateCopyWith<_ChatState> get copyWith => __$ChatStateCopyWithImpl<_ChatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatState&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.isTyping, isTyping) || other.isTyping == isTyping)&&(identical(other.streamingContent, streamingContent) || other.streamingContent == streamingContent)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._quickActions, _quickActions)&&(identical(other.currentContext, currentContext) || other.currentContext == currentContext)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),isOpen,isTyping,streamingContent,errorMessage,const DeepCollectionEquality().hash(_quickActions),currentContext,unreadCount);

@override
String toString() {
  return 'ChatState(messages: $messages, isOpen: $isOpen, isTyping: $isTyping, streamingContent: $streamingContent, errorMessage: $errorMessage, quickActions: $quickActions, currentContext: $currentContext, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$ChatStateCopyWith(_ChatState value, $Res Function(_ChatState) _then) = __$ChatStateCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessage> messages, bool isOpen, bool isTyping, String streamingContent, String? errorMessage, List<QuickAction> quickActions, GameContextSnapshot? currentContext, int unreadCount
});


@override $GameContextSnapshotCopyWith<$Res>? get currentContext;

}
/// @nodoc
class __$ChatStateCopyWithImpl<$Res>
    implements _$ChatStateCopyWith<$Res> {
  __$ChatStateCopyWithImpl(this._self, this._then);

  final _ChatState _self;
  final $Res Function(_ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? isOpen = null,Object? isTyping = null,Object? streamingContent = null,Object? errorMessage = freezed,Object? quickActions = null,Object? currentContext = freezed,Object? unreadCount = null,}) {
  return _then(_ChatState(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,isTyping: null == isTyping ? _self.isTyping : isTyping // ignore: cast_nullable_to_non_nullable
as bool,streamingContent: null == streamingContent ? _self.streamingContent : streamingContent // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,quickActions: null == quickActions ? _self._quickActions : quickActions // ignore: cast_nullable_to_non_nullable
as List<QuickAction>,currentContext: freezed == currentContext ? _self.currentContext : currentContext // ignore: cast_nullable_to_non_nullable
as GameContextSnapshot?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameContextSnapshotCopyWith<$Res>? get currentContext {
    if (_self.currentContext == null) {
    return null;
  }

  return $GameContextSnapshotCopyWith<$Res>(_self.currentContext!, (value) {
    return _then(_self.copyWith(currentContext: value));
  });
}
}

// dart format on
