// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_points_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoyaltyPointsRequestModelImpl _$$LoyaltyPointsRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LoyaltyPointsRequestModelImpl(
      customerToken: json['customerToken'] as String,
      platform: json['platform'] as String,
      version: json['version'] as String,
      languageId: (json['languageId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LoyaltyPointsRequestModelImplToJson(
        _$LoyaltyPointsRequestModelImpl instance) =>
    <String, dynamic>{
      'customerToken': instance.customerToken,
      'platform': instance.platform,
      'version': instance.version,
      'languageId': instance.languageId,
    };
