// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignupRequestModelImpl _$$SignupRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SignupRequestModelImpl(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      mobileNumberPrefix: json['mobileNumberPrefix'] as String,
      mobileNumber: json['mobileNumber'] as String,
      Nationality: json['Nationality'] as String,
      dob: json['dob'] as String,
      gender: json['gender'] as String,
      referralCode: json['referralCode'] as String,
      otp: json['otp'] as String,
      password: json['password'] as String,
      languageId: (json['languageId'] as num).toInt(),
      platform: json['platform'] as String,
      version: json['version'] as String,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$$SignupRequestModelImplToJson(
        _$SignupRequestModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNumberPrefix': instance.mobileNumberPrefix,
      'mobileNumber': instance.mobileNumber,
      'Nationality': instance.Nationality,
      'dob': instance.dob,
      'gender': instance.gender,
      'referralCode': instance.referralCode,
      'otp': instance.otp,
      'password': instance.password,
      'languageId': instance.languageId,
      'platform': instance.platform,
      'version': instance.version,
      'deviceId': instance.deviceId,
    };
