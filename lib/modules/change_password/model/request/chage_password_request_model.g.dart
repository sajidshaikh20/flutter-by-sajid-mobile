// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chage_password_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangePasswordRequestModelImpl _$$ChangePasswordRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangePasswordRequestModelImpl(
      customerToken: json['customerToken'] as String,
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$$ChangePasswordRequestModelImplToJson(
        _$ChangePasswordRequestModelImpl instance) =>
    <String, dynamic>{
      'customerToken': instance.customerToken,
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
    };
