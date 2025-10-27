// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationRequestModelImpl _$$NotificationRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationRequestModelImpl(
      languageId: (json['languageId'] as num?)?.toInt(),
      customerToken: json['customerToken'] as String?,
      platform: json['platform'] as String?,
      version: json['version'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$$NotificationRequestModelImplToJson(
        _$NotificationRequestModelImpl instance) =>
    <String, dynamic>{
      'languageId': instance.languageId,
      'customerToken': instance.customerToken,
      'platform': instance.platform,
      'version': instance.version,
      'deviceId': instance.deviceId,
    };
