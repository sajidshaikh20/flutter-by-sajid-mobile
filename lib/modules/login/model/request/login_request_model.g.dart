// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    _LoginRequestModel(
      emailOrUsername: json['emailOrUsername'] as String,
      password: json['password'] as String,
      fcmToken: json['fcmToken'] as String?,
      deviceType: json['deviceType'] as String?,
      deviceId: json['deviceId'] as String?,
      platform: json['platform'] as String?,
      appVersion: json['appVersion'] as String?,
    );

Map<String, dynamic> _$LoginRequestModelToJson(_LoginRequestModel instance) =>
    <String, dynamic>{
      'emailOrUsername': instance.emailOrUsername,
      'password': instance.password,
      'fcmToken': instance.fcmToken,
      'deviceType': instance.deviceType,
      'deviceId': instance.deviceId,
      'platform': instance.platform,
      'appVersion': instance.appVersion,
    };
