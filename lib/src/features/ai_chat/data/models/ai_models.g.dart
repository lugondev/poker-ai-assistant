// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiConfig _$AiConfigFromJson(Map<String, dynamic> json) => _AiConfig(
  provider: $enumDecode(_$AiProviderEnumMap, json['provider']),
  apiKey: json['apiKey'] as String,
  model: json['model'] as String? ?? '',
  baseUrl: json['baseUrl'] as String? ?? 'https://api.openai.com/v1',
  timeoutMs: (json['timeoutMs'] as num?)?.toInt() ?? 30000,
  temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
  maxTokens: (json['maxTokens'] as num?)?.toInt() ?? 2000,
);

Map<String, dynamic> _$AiConfigToJson(_AiConfig instance) => <String, dynamic>{
  'provider': _$AiProviderEnumMap[instance.provider]!,
  'apiKey': instance.apiKey,
  'model': instance.model,
  'baseUrl': instance.baseUrl,
  'timeoutMs': instance.timeoutMs,
  'temperature': instance.temperature,
  'maxTokens': instance.maxTokens,
};

const _$AiProviderEnumMap = {
  AiProvider.openai: 'openai',
  AiProvider.anthropic: 'anthropic',
  AiProvider.mock: 'mock',
};

_AiMessage _$AiMessageFromJson(Map<String, dynamic> json) => _AiMessage(
  role: json['role'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$AiMessageToJson(_AiMessage instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};

_AiCompletionRequest _$AiCompletionRequestFromJson(Map<String, dynamic> json) =>
    _AiCompletionRequest(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => AiMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      model: json['model'] as String? ?? '',
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
      maxTokens: (json['maxTokens'] as num?)?.toInt() ?? 2000,
      stream: json['stream'] as bool? ?? true,
    );

Map<String, dynamic> _$AiCompletionRequestToJson(
  _AiCompletionRequest instance,
) => <String, dynamic>{
  'messages': instance.messages,
  'model': instance.model,
  'temperature': instance.temperature,
  'maxTokens': instance.maxTokens,
  'stream': instance.stream,
};

_AiCompletionChunk _$AiCompletionChunkFromJson(Map<String, dynamic> json) =>
    _AiCompletionChunk(
      content: json['content'] as String,
      isDone: json['isDone'] as bool? ?? false,
      error: json['error'] as String? ?? null,
      promptTokens: (json['promptTokens'] as num?)?.toInt() ?? null,
      completionTokens: (json['completionTokens'] as num?)?.toInt() ?? null,
    );

Map<String, dynamic> _$AiCompletionChunkToJson(_AiCompletionChunk instance) =>
    <String, dynamic>{
      'content': instance.content,
      'isDone': instance.isDone,
      'error': instance.error,
      'promptTokens': instance.promptTokens,
      'completionTokens': instance.completionTokens,
    };
