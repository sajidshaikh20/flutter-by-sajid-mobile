// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EditProfileRequestModelImpl _$$EditProfileRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EditProfileRequestModelImpl(
      languageId: (json['languageId'] as num?)?.toInt(),
      customerToken: json['customerToken'] as String?,
      platform: json['platform'] as String?,
      version: json['version'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      mobileNumberPrefix: json['mobileNumberPrefix'] as String?,
      nationality: json['nationality'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$$EditProfileRequestModelImplToJson(
        _$EditProfileRequestModelImpl instance) =>
    <String, dynamic>{
      'languageId': instance.languageId,
      'customerToken': instance.customerToken,
      'platform': instance.platform,
      'version': instance.version,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNumber': instance.mobileNumber,
      'mobileNumberPrefix': instance.mobileNumberPrefix,
      'nationality': instance.nationality,
      'dob': instance.dob,
      'gender': instance.gender,
      'deviceId': instance.deviceId,
    };
