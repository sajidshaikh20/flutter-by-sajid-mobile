// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LogoutRequestModelImpl _$$LogoutRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LogoutRequestModelImpl(
      languageId: (json['languageId'] as num?)?.toInt(),
      platform: json['platform'] as String?,
      version: json['version'] as String?,
      customerToken: json['customerToken'] as String?,
    );

Map<String, dynamic> _$$LogoutRequestModelImplToJson(
        _$LogoutRequestModelImpl instance) =>
    <String, dynamic>{
      'languageId': instance.languageId,
      'platform': instance.platform,
      'version': instance.version,
      'customerToken': instance.customerToken,
    };
