// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SummaryModelImpl _$$SummaryModelImplFromJson(Map<String, dynamic> json) =>
    _$SummaryModelImpl(
      originalText: json['originalText'] as String,
      summary: json['summary'] as String,
      originalWordCount: (json['originalWordCount'] as num).toInt(),
      summaryWordCount: (json['summaryWordCount'] as num).toInt(),
      translation: json['translation'] as String?,
      translatedLanguage: json['translatedLanguage'] as String?,
      isCached: json['isCached'] as bool? ?? false,
    );

Map<String, dynamic> _$$SummaryModelImplToJson(_$SummaryModelImpl instance) =>
    <String, dynamic>{
      'originalText': instance.originalText,
      'summary': instance.summary,
      'originalWordCount': instance.originalWordCount,
      'summaryWordCount': instance.summaryWordCount,
      'translation': instance.translation,
      'translatedLanguage': instance.translatedLanguage,
      'isCached': instance.isCached,
    };
