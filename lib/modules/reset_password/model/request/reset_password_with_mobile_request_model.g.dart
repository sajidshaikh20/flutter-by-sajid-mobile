// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_with_mobile_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResetPasswordWithMobileRequestModelImpl
    _$$ResetPasswordWithMobileRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$ResetPasswordWithMobileRequestModelImpl(
          platform: json['platform'] as String?,
          version: json['version'] as String?,
          websiteId: json['websiteId'] as String?,
          mobileNumber: json['mobileNumber'] as String?,
          mobileNumberPrefix: json['mobileNumberPrefix'] as String?,
          sentOtp: json['sentOtp'] as String?,
          verifyOtp: json['verifyOtp'] as String?,
          updatePassword: json['updatePassword'] as String?,
          newPassword: json['newPassword'] as String?,
          confirmPassword: json['confirmPassword'] as String?,
          languageId: json['languageId'] as String?,
        );

Map<String, dynamic> _$$ResetPasswordWithMobileRequestModelImplToJson(
        _$ResetPasswordWithMobileRequestModelImpl instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'version': instance.version,
      'websiteId': instance.websiteId,
      'mobileNumber': instance.mobileNumber,
      'mobileNumberPrefix': instance.mobileNumberPrefix,
      'sentOtp': instance.sentOtp,
      'verifyOtp': instance.verifyOtp,
      'updatePassword': instance.updatePassword,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
      'languageId': instance.languageId,
    };
