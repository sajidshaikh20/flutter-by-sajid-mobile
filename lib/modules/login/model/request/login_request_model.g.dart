// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestModelImpl _$$LoginRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginRequestModelImpl(
      languageId: (json['languageId'] as num?)?.toInt(),
      platform: json['platform'] as String?,
      version: json['version'] as String?,
      emailMobile: json['emailMobile'] as String?,
      password: json['password'] as String?,
      isSocialLogin: json['isSocialLogin'] as bool?,
      socialLoginType: json['socialLoginType'] as String?,
      appleToken: json['appleToken'] as String?,
      deviceId: json['deviceId'] as String?,
      deviceToken: json['deviceToken'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$LoginRequestModelImplToJson(
        _$LoginRequestModelImpl instance) =>
    <String, dynamic>{
      'languageId': instance.languageId,
      'platform': instance.platform,
      'version': instance.version,
      'emailMobile': instance.emailMobile,
      'password': instance.password,
      'isSocialLogin': instance.isSocialLogin,
      'socialLoginType': instance.socialLoginType,
      'appleToken': instance.appleToken,
      'deviceId': instance.deviceId,
      'deviceToken': instance.deviceToken,
      'token': instance.token,
    };
