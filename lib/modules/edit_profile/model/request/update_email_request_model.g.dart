// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_email_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateEmailRequestModelImpl _$$UpdateEmailRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateEmailRequestModelImpl(
      customerToken: json['customerToken'] as String?,
      email: json['email'] as String?,
      otp: json['otp'] as String?,
      platform: json['platform'] as String?,
      version: json['version'] as String?,
      deviceId: json['deviceId'] as String?,
      websiteId: (json['websiteId'] as num?)?.toInt(),
      languageId: (json['languageId'] as num?)?.toInt(),
      storeId: (json['storeId'] as num?)?.toInt(),
      sentOtp: (json['sentOtp'] as num?)?.toInt(),
      verifyOtp: (json['verifyOtp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UpdateEmailRequestModelImplToJson(
        _$UpdateEmailRequestModelImpl instance) =>
    <String, dynamic>{
      'customerToken': instance.customerToken,
      'email': instance.email,
      'otp': instance.otp,
      'platform': instance.platform,
      'version': instance.version,
      'deviceId': instance.deviceId,
      'websiteId': instance.websiteId,
      'languageId': instance.languageId,
      'storeId': instance.storeId,
      'sentOtp': instance.sentOtp,
      'verifyOtp': instance.verifyOtp,
    };
