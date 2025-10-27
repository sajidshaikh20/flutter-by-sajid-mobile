// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_wallet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyWalletRequest _$MyWalletRequestFromJson(Map<String, dynamic> json) =>
    MyWalletRequest(
      websiteId: json['websiteId'] as String?,
      storeId: json['storeId'] as String?,
      customerToken: json['customerToken'] as String?,
      pageNumber: json['pageNumber'] as String?,
    );

Map<String, dynamic> _$MyWalletRequestToJson(MyWalletRequest instance) =>
    <String, dynamic>{
      'websiteId': instance.websiteId,
      'storeId': instance.storeId,
      'customerToken': instance.customerToken,
      'pageNumber': instance.pageNumber,
    };
