// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EditProfileModelImpl _$$EditProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EditProfileModelImpl(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      otpSent: json['otpSent'] as bool? ?? false,
      profileImage: json['profileImage'] as String?,
      customerName: json['customerName'] as String?,
    );

Map<String, dynamic> _$$EditProfileModelImplToJson(
        _$EditProfileModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otpSent': instance.otpSent,
      'profileImage': instance.profileImage,
      'customerName': instance.customerName,
    };
