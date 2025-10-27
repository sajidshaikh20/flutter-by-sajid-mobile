// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_setting_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingRequestModelImpl
    _$$NotificationSettingRequestModelImplFromJson(Map<String, dynamic> json) =>
        _$NotificationSettingRequestModelImpl(
          languageId: (json['languageId'] as num?)?.toInt(),
          platform: json['platform'] as String?,
          version: json['version'] as String?,
          customerToken: json['customerToken'] as String?,
          orderStatus: json['orderStatus'] as bool?,
          loyalityPoints: json['loyalityPoints'] as bool?,
          promotionOffers: json['promotionOffers'] as bool?,
        );

Map<String, dynamic> _$$NotificationSettingRequestModelImplToJson(
        _$NotificationSettingRequestModelImpl instance) =>
    <String, dynamic>{
      'languageId': instance.languageId,
      'platform': instance.platform,
      'version': instance.version,
      'customerToken': instance.customerToken,
      'orderStatus': instance.orderStatus,
      'loyalityPoints': instance.loyalityPoints,
      'promotionOffers': instance.promotionOffers,
    };
