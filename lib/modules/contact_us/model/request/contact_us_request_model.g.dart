// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactUsRequestModelImpl _$$ContactUsRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ContactUsRequestModelImpl(
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      comment: json['comment'] as String?,
      customerToken: json['customerToken'] as String?,
      platform: json['platform'] as String?,
      version: json['version'] as String?,
      languageId: (json['languageId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ContactUsRequestModelImplToJson(
        _$ContactUsRequestModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'comment': instance.comment,
      'customerToken': instance.customerToken,
      'platform': instance.platform,
      'version': instance.version,
      'languageId': instance.languageId,
    };
