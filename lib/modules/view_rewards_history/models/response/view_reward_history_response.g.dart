// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_reward_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewRewardHistoryResponse _$ViewRewardHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    ViewRewardHistoryResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      totalCount: (json['totalCount'] as num?)?.toInt(),
      customerPoints: (json['customerPoints'] as num?)?.toInt(),
      eTag: json['eTag'] as String?,
    );

Map<String, dynamic> _$ViewRewardHistoryResponseToJson(
        ViewRewardHistoryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'totalCount': instance.totalCount,
      'customerPoints': instance.customerPoints,
      'eTag': instance.eTag,
    };
