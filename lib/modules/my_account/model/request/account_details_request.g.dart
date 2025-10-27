// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetailsRequest _$AccountDetailsRequestFromJson(
        Map<String, dynamic> json) =>
    AccountDetailsRequest(
      customerToken: json['customerToken'] as String?,
      etag: json['eTag'] as String?,
      websiteId: json['websiteId'] as String?,
      storeId: json['storeId'] as String?,
    );

Map<String, dynamic> _$AccountDetailsRequestToJson(
        AccountDetailsRequest instance) =>
    <String, dynamic>{
      'customerToken': instance.customerToken,
      'eTag': instance.etag,
      'websiteId': instance.websiteId,
      'storeId': instance.storeId,
    };
