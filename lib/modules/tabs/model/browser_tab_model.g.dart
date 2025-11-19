// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_tab_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrowserTabModelImpl _$$BrowserTabModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BrowserTabModelImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      title: json['title'] as String?,
      favicon: json['favicon'] as String?,
      isLoading: json['isLoading'] as bool? ?? false,
      canGoBack: json['canGoBack'] as bool? ?? false,
      canGoForward: json['canGoForward'] as bool? ?? false,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$BrowserTabModelImplToJson(
        _$BrowserTabModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'favicon': instance.favicon,
      'isLoading': instance.isLoading,
      'canGoBack': instance.canGoBack,
      'canGoForward': instance.canGoForward,
      'progress': instance.progress,
    };
