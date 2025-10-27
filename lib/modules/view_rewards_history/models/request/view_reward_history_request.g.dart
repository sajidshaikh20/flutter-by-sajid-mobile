// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_reward_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewRewardHistoryRequest _$ViewRewardHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    ViewRewardHistoryRequest(
      websiteId: json['websiteId'] as String?,
      storeId: json['storeId'] as String?,
      customerToken: json['customerToken'] as String?,
      pageNumber: json['pageNumber'] as String?,
    );

Map<String, dynamic> _$ViewRewardHistoryRequestToJson(
        ViewRewardHistoryRequest instance) =>
    <String, dynamic>{
      'websiteId': instance.websiteId,
      'storeId': instance.storeId,
      'customerToken': instance.customerToken,
      'pageNumber': instance.pageNumber,
    };
