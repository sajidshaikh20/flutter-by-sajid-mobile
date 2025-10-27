// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimpleResponseImpl _$$SimpleResponseImplFromJson(Map<String, dynamic> json) =>
    _$SimpleResponseImpl(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$$SimpleResponseImplToJson(
        _$SimpleResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
