// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequest<T> _$BaseRequestFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => BaseRequest<T>(
  head: json['Head'] == null
      ? null
      : HeadRequest.fromJson(json['Head'] as Map<String, dynamic>),
  body: _$nullableGenericFromJson(json['Body'], fromJsonT),
);

Map<String, dynamic> _$BaseRequestToJson<T>(
  BaseRequest<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'Head': instance.head,
  'Body': _$nullableGenericToJson(instance.body, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

HeadRequest _$HeadRequestFromJson(Map<String, dynamic> json) =>
    HeadRequest(
        code: json['Code'] as String?,
        key: json['Key'] as String?,
        requestCode: json['RequestCode'] as String?,
        token: json['Token'] as String?,
        appName: json['AppName'] as String?,
        deviceMake: json['device_make'] as String?,
        deviceModel: json['device_model'] as String?,
        deviceType: json['device_type'] as String?,
        appVersion: json['AppVer'] as String?,
      )
      ..osName = json['OSName'] as String?
      ..osVersion = json['os_version'] as String?;

Map<String, dynamic> _$HeadRequestToJson(HeadRequest instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Key': instance.key,
      'AppVer': instance.appVersion,
      'AppName': instance.appName,
      'OSName': instance.osName,
      'device_make': instance.deviceMake,
      'device_model': instance.deviceModel,
      'os_version': instance.osVersion,
      'device_type': instance.deviceType,
      'RequestCode': instance.requestCode,
      'Token': instance.token,
    };
