// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeleteAccountRequestModelImpl _$$DeleteAccountRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DeleteAccountRequestModelImpl(
      languageId: (json['languageId'] as num?)?.toInt(),
      storeId: (json['storeId'] as num?)?.toInt(),
      platform: json['platform'] as String?,
      version: json['version'] as String?,
      customerToken: json['customerToken'] as String?,
    );

Map<String, dynamic> _$$DeleteAccountRequestModelImplToJson(
        _$DeleteAccountRequestModelImpl instance) =>
    <String, dynamic>{
      'languageId': instance.languageId,
      'storeId': instance.storeId,
      'platform': instance.platform,
      'version': instance.version,
      'customerToken': instance.customerToken,
    };
