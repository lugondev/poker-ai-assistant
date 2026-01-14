// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiConfig {

 AiProvider get provider; String get apiKey; String get model; String get baseUrl; int get timeoutMs; double get temperature; int get maxTokens;
/// Create a copy of AiConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiConfigCopyWith<AiConfig> get copyWith => _$AiConfigCopyWithImpl<AiConfig>(this as AiConfig, _$identity);

  /// Serializes this AiConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiConfig&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.model, model) || other.model == model)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.maxTokens, maxTokens) || other.maxTokens == maxTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,apiKey,model,baseUrl,timeoutMs,temperature,maxTokens);

@override
String toString() {
  return 'AiConfig(provider: $provider, apiKey: $apiKey, model: $model, baseUrl: $baseUrl, timeoutMs: $timeoutMs, temperature: $temperature, maxTokens: $maxTokens)';
}


}

/// @nodoc
abstract mixin class $AiConfigCopyWith<$Res>  {
  factory $AiConfigCopyWith(AiConfig value, $Res Function(AiConfig) _then) = _$AiConfigCopyWithImpl;
@useResult
$Res call({
 AiProvider provider, String apiKey, String model, String baseUrl, int timeoutMs, double temperature, int maxTokens
});




}
/// @nodoc
class _$AiConfigCopyWithImpl<$Res>
    implements $AiConfigCopyWith<$Res> {
  _$AiConfigCopyWithImpl(this._self, this._then);

  final AiConfig _self;
  final $Res Function(AiConfig) _then;

/// Create a copy of AiConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? apiKey = null,Object? model = null,Object? baseUrl = null,Object? timeoutMs = null,Object? temperature = null,Object? maxTokens = null,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as AiProvider,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,maxTokens: null == maxTokens ? _self.maxTokens : maxTokens // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AiConfig].
extension AiConfigPatterns on AiConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiConfig value)  $default,){
final _that = this;
switch (_that) {
case _AiConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AiConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiProvider provider,  String apiKey,  String model,  String baseUrl,  int timeoutMs,  double temperature,  int maxTokens)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiConfig() when $default != null:
return $default(_that.provider,_that.apiKey,_that.model,_that.baseUrl,_that.timeoutMs,_that.temperature,_that.maxTokens);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiProvider provider,  String apiKey,  String model,  String baseUrl,  int timeoutMs,  double temperature,  int maxTokens)  $default,) {final _that = this;
switch (_that) {
case _AiConfig():
return $default(_that.provider,_that.apiKey,_that.model,_that.baseUrl,_that.timeoutMs,_that.temperature,_that.maxTokens);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiProvider provider,  String apiKey,  String model,  String baseUrl,  int timeoutMs,  double temperature,  int maxTokens)?  $default,) {final _that = this;
switch (_that) {
case _AiConfig() when $default != null:
return $default(_that.provider,_that.apiKey,_that.model,_that.baseUrl,_that.timeoutMs,_that.temperature,_that.maxTokens);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiConfig implements AiConfig {
  const _AiConfig({required this.provider, required this.apiKey, this.model = '', this.baseUrl = 'https://api.openai.com/v1', this.timeoutMs = 30000, this.temperature = 0.7, this.maxTokens = 2000});
  factory _AiConfig.fromJson(Map<String, dynamic> json) => _$AiConfigFromJson(json);

@override final  AiProvider provider;
@override final  String apiKey;
@override@JsonKey() final  String model;
@override@JsonKey() final  String baseUrl;
@override@JsonKey() final  int timeoutMs;
@override@JsonKey() final  double temperature;
@override@JsonKey() final  int maxTokens;

/// Create a copy of AiConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiConfigCopyWith<_AiConfig> get copyWith => __$AiConfigCopyWithImpl<_AiConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiConfig&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.model, model) || other.model == model)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.maxTokens, maxTokens) || other.maxTokens == maxTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,apiKey,model,baseUrl,timeoutMs,temperature,maxTokens);

@override
String toString() {
  return 'AiConfig(provider: $provider, apiKey: $apiKey, model: $model, baseUrl: $baseUrl, timeoutMs: $timeoutMs, temperature: $temperature, maxTokens: $maxTokens)';
}


}

/// @nodoc
abstract mixin class _$AiConfigCopyWith<$Res> implements $AiConfigCopyWith<$Res> {
  factory _$AiConfigCopyWith(_AiConfig value, $Res Function(_AiConfig) _then) = __$AiConfigCopyWithImpl;
@override @useResult
$Res call({
 AiProvider provider, String apiKey, String model, String baseUrl, int timeoutMs, double temperature, int maxTokens
});




}
/// @nodoc
class __$AiConfigCopyWithImpl<$Res>
    implements _$AiConfigCopyWith<$Res> {
  __$AiConfigCopyWithImpl(this._self, this._then);

  final _AiConfig _self;
  final $Res Function(_AiConfig) _then;

/// Create a copy of AiConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? apiKey = null,Object? model = null,Object? baseUrl = null,Object? timeoutMs = null,Object? temperature = null,Object? maxTokens = null,}) {
  return _then(_AiConfig(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as AiProvider,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,maxTokens: null == maxTokens ? _self.maxTokens : maxTokens // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AiMessage {

 String get role;// 'system', 'user', 'assistant'
 String get content;
/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiMessageCopyWith<AiMessage> get copyWith => _$AiMessageCopyWithImpl<AiMessage>(this as AiMessage, _$identity);

  /// Serializes this AiMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'AiMessage(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class $AiMessageCopyWith<$Res>  {
  factory $AiMessageCopyWith(AiMessage value, $Res Function(AiMessage) _then) = _$AiMessageCopyWithImpl;
@useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class _$AiMessageCopyWithImpl<$Res>
    implements $AiMessageCopyWith<$Res> {
  _$AiMessageCopyWithImpl(this._self, this._then);

  final AiMessage _self;
  final $Res Function(AiMessage) _then;

/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? content = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiMessage].
extension AiMessagePatterns on AiMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiMessage value)  $default,){
final _that = this;
switch (_that) {
case _AiMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiMessage value)?  $default,){
final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String role,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
return $default(_that.role,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String role,  String content)  $default,) {final _that = this;
switch (_that) {
case _AiMessage():
return $default(_that.role,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String role,  String content)?  $default,) {final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
return $default(_that.role,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiMessage implements AiMessage {
  const _AiMessage({required this.role, required this.content});
  factory _AiMessage.fromJson(Map<String, dynamic> json) => _$AiMessageFromJson(json);

@override final  String role;
// 'system', 'user', 'assistant'
@override final  String content;

/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiMessageCopyWith<_AiMessage> get copyWith => __$AiMessageCopyWithImpl<_AiMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'AiMessage(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class _$AiMessageCopyWith<$Res> implements $AiMessageCopyWith<$Res> {
  factory _$AiMessageCopyWith(_AiMessage value, $Res Function(_AiMessage) _then) = __$AiMessageCopyWithImpl;
@override @useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class __$AiMessageCopyWithImpl<$Res>
    implements _$AiMessageCopyWith<$Res> {
  __$AiMessageCopyWithImpl(this._self, this._then);

  final _AiMessage _self;
  final $Res Function(_AiMessage) _then;

/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? content = null,}) {
  return _then(_AiMessage(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AiCompletionRequest {

 List<AiMessage> get messages; String get model; double get temperature; int get maxTokens; bool get stream;
/// Create a copy of AiCompletionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiCompletionRequestCopyWith<AiCompletionRequest> get copyWith => _$AiCompletionRequestCopyWithImpl<AiCompletionRequest>(this as AiCompletionRequest, _$identity);

  /// Serializes this AiCompletionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiCompletionRequest&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.model, model) || other.model == model)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.maxTokens, maxTokens) || other.maxTokens == maxTokens)&&(identical(other.stream, stream) || other.stream == stream));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),model,temperature,maxTokens,stream);

@override
String toString() {
  return 'AiCompletionRequest(messages: $messages, model: $model, temperature: $temperature, maxTokens: $maxTokens, stream: $stream)';
}


}

/// @nodoc
abstract mixin class $AiCompletionRequestCopyWith<$Res>  {
  factory $AiCompletionRequestCopyWith(AiCompletionRequest value, $Res Function(AiCompletionRequest) _then) = _$AiCompletionRequestCopyWithImpl;
@useResult
$Res call({
 List<AiMessage> messages, String model, double temperature, int maxTokens, bool stream
});




}
/// @nodoc
class _$AiCompletionRequestCopyWithImpl<$Res>
    implements $AiCompletionRequestCopyWith<$Res> {
  _$AiCompletionRequestCopyWithImpl(this._self, this._then);

  final AiCompletionRequest _self;
  final $Res Function(AiCompletionRequest) _then;

/// Create a copy of AiCompletionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? model = null,Object? temperature = null,Object? maxTokens = null,Object? stream = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<AiMessage>,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,maxTokens: null == maxTokens ? _self.maxTokens : maxTokens // ignore: cast_nullable_to_non_nullable
as int,stream: null == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AiCompletionRequest].
extension AiCompletionRequestPatterns on AiCompletionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiCompletionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiCompletionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiCompletionRequest value)  $default,){
final _that = this;
switch (_that) {
case _AiCompletionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiCompletionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AiCompletionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AiMessage> messages,  String model,  double temperature,  int maxTokens,  bool stream)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiCompletionRequest() when $default != null:
return $default(_that.messages,_that.model,_that.temperature,_that.maxTokens,_that.stream);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AiMessage> messages,  String model,  double temperature,  int maxTokens,  bool stream)  $default,) {final _that = this;
switch (_that) {
case _AiCompletionRequest():
return $default(_that.messages,_that.model,_that.temperature,_that.maxTokens,_that.stream);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AiMessage> messages,  String model,  double temperature,  int maxTokens,  bool stream)?  $default,) {final _that = this;
switch (_that) {
case _AiCompletionRequest() when $default != null:
return $default(_that.messages,_that.model,_that.temperature,_that.maxTokens,_that.stream);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiCompletionRequest implements AiCompletionRequest {
  const _AiCompletionRequest({required final  List<AiMessage> messages, this.model = '', this.temperature = 0.7, this.maxTokens = 2000, this.stream = true}): _messages = messages;
  factory _AiCompletionRequest.fromJson(Map<String, dynamic> json) => _$AiCompletionRequestFromJson(json);

 final  List<AiMessage> _messages;
@override List<AiMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  String model;
@override@JsonKey() final  double temperature;
@override@JsonKey() final  int maxTokens;
@override@JsonKey() final  bool stream;

/// Create a copy of AiCompletionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiCompletionRequestCopyWith<_AiCompletionRequest> get copyWith => __$AiCompletionRequestCopyWithImpl<_AiCompletionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiCompletionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiCompletionRequest&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.model, model) || other.model == model)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.maxTokens, maxTokens) || other.maxTokens == maxTokens)&&(identical(other.stream, stream) || other.stream == stream));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),model,temperature,maxTokens,stream);

@override
String toString() {
  return 'AiCompletionRequest(messages: $messages, model: $model, temperature: $temperature, maxTokens: $maxTokens, stream: $stream)';
}


}

/// @nodoc
abstract mixin class _$AiCompletionRequestCopyWith<$Res> implements $AiCompletionRequestCopyWith<$Res> {
  factory _$AiCompletionRequestCopyWith(_AiCompletionRequest value, $Res Function(_AiCompletionRequest) _then) = __$AiCompletionRequestCopyWithImpl;
@override @useResult
$Res call({
 List<AiMessage> messages, String model, double temperature, int maxTokens, bool stream
});




}
/// @nodoc
class __$AiCompletionRequestCopyWithImpl<$Res>
    implements _$AiCompletionRequestCopyWith<$Res> {
  __$AiCompletionRequestCopyWithImpl(this._self, this._then);

  final _AiCompletionRequest _self;
  final $Res Function(_AiCompletionRequest) _then;

/// Create a copy of AiCompletionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? model = null,Object? temperature = null,Object? maxTokens = null,Object? stream = null,}) {
  return _then(_AiCompletionRequest(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<AiMessage>,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,maxTokens: null == maxTokens ? _self.maxTokens : maxTokens // ignore: cast_nullable_to_non_nullable
as int,stream: null == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AiCompletionChunk {

 String get content; bool get isDone; String? get error; int? get promptTokens; int? get completionTokens;
/// Create a copy of AiCompletionChunk
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiCompletionChunkCopyWith<AiCompletionChunk> get copyWith => _$AiCompletionChunkCopyWithImpl<AiCompletionChunk>(this as AiCompletionChunk, _$identity);

  /// Serializes this AiCompletionChunk to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiCompletionChunk&&(identical(other.content, content) || other.content == content)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.error, error) || other.error == error)&&(identical(other.promptTokens, promptTokens) || other.promptTokens == promptTokens)&&(identical(other.completionTokens, completionTokens) || other.completionTokens == completionTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,isDone,error,promptTokens,completionTokens);

@override
String toString() {
  return 'AiCompletionChunk(content: $content, isDone: $isDone, error: $error, promptTokens: $promptTokens, completionTokens: $completionTokens)';
}


}

/// @nodoc
abstract mixin class $AiCompletionChunkCopyWith<$Res>  {
  factory $AiCompletionChunkCopyWith(AiCompletionChunk value, $Res Function(AiCompletionChunk) _then) = _$AiCompletionChunkCopyWithImpl;
@useResult
$Res call({
 String content, bool isDone, String? error, int? promptTokens, int? completionTokens
});




}
/// @nodoc
class _$AiCompletionChunkCopyWithImpl<$Res>
    implements $AiCompletionChunkCopyWith<$Res> {
  _$AiCompletionChunkCopyWithImpl(this._self, this._then);

  final AiCompletionChunk _self;
  final $Res Function(AiCompletionChunk) _then;

/// Create a copy of AiCompletionChunk
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? isDone = null,Object? error = freezed,Object? promptTokens = freezed,Object? completionTokens = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,promptTokens: freezed == promptTokens ? _self.promptTokens : promptTokens // ignore: cast_nullable_to_non_nullable
as int?,completionTokens: freezed == completionTokens ? _self.completionTokens : completionTokens // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiCompletionChunk].
extension AiCompletionChunkPatterns on AiCompletionChunk {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiCompletionChunk value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiCompletionChunk() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiCompletionChunk value)  $default,){
final _that = this;
switch (_that) {
case _AiCompletionChunk():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiCompletionChunk value)?  $default,){
final _that = this;
switch (_that) {
case _AiCompletionChunk() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content,  bool isDone,  String? error,  int? promptTokens,  int? completionTokens)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiCompletionChunk() when $default != null:
return $default(_that.content,_that.isDone,_that.error,_that.promptTokens,_that.completionTokens);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content,  bool isDone,  String? error,  int? promptTokens,  int? completionTokens)  $default,) {final _that = this;
switch (_that) {
case _AiCompletionChunk():
return $default(_that.content,_that.isDone,_that.error,_that.promptTokens,_that.completionTokens);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content,  bool isDone,  String? error,  int? promptTokens,  int? completionTokens)?  $default,) {final _that = this;
switch (_that) {
case _AiCompletionChunk() when $default != null:
return $default(_that.content,_that.isDone,_that.error,_that.promptTokens,_that.completionTokens);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiCompletionChunk implements AiCompletionChunk {
  const _AiCompletionChunk({required this.content, this.isDone = false, this.error = null, this.promptTokens = null, this.completionTokens = null});
  factory _AiCompletionChunk.fromJson(Map<String, dynamic> json) => _$AiCompletionChunkFromJson(json);

@override final  String content;
@override@JsonKey() final  bool isDone;
@override@JsonKey() final  String? error;
@override@JsonKey() final  int? promptTokens;
@override@JsonKey() final  int? completionTokens;

/// Create a copy of AiCompletionChunk
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiCompletionChunkCopyWith<_AiCompletionChunk> get copyWith => __$AiCompletionChunkCopyWithImpl<_AiCompletionChunk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiCompletionChunkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiCompletionChunk&&(identical(other.content, content) || other.content == content)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.error, error) || other.error == error)&&(identical(other.promptTokens, promptTokens) || other.promptTokens == promptTokens)&&(identical(other.completionTokens, completionTokens) || other.completionTokens == completionTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,isDone,error,promptTokens,completionTokens);

@override
String toString() {
  return 'AiCompletionChunk(content: $content, isDone: $isDone, error: $error, promptTokens: $promptTokens, completionTokens: $completionTokens)';
}


}

/// @nodoc
abstract mixin class _$AiCompletionChunkCopyWith<$Res> implements $AiCompletionChunkCopyWith<$Res> {
  factory _$AiCompletionChunkCopyWith(_AiCompletionChunk value, $Res Function(_AiCompletionChunk) _then) = __$AiCompletionChunkCopyWithImpl;
@override @useResult
$Res call({
 String content, bool isDone, String? error, int? promptTokens, int? completionTokens
});




}
/// @nodoc
class __$AiCompletionChunkCopyWithImpl<$Res>
    implements _$AiCompletionChunkCopyWith<$Res> {
  __$AiCompletionChunkCopyWithImpl(this._self, this._then);

  final _AiCompletionChunk _self;
  final $Res Function(_AiCompletionChunk) _then;

/// Create a copy of AiCompletionChunk
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? isDone = null,Object? error = freezed,Object? promptTokens = freezed,Object? completionTokens = freezed,}) {
  return _then(_AiCompletionChunk(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,promptTokens: freezed == promptTokens ? _self.promptTokens : promptTokens // ignore: cast_nullable_to_non_nullable
as int?,completionTokens: freezed == completionTokens ? _self.completionTokens : completionTokens // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
