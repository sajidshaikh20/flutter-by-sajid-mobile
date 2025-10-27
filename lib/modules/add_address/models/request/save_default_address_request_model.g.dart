// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_default_address_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveDefaultAddressRequestModel _$SaveDefaultAddressRequestModelFromJson(
        Map<String, dynamic> json) =>
    SaveDefaultAddressRequestModel(
      setIsDefaultBilling: json['setIsDefaultBilling'] as String?,
      storeId: json['storeId'] as String?,
      websiteId: json['websiteId'] as String?,
      customerToken: json['customerToken'] as String?,
      addressId: json['addressId'] as String?,
      setIsDefaultShipping: json['setIsDefaultShipping'] as String?,
    );

Map<String, dynamic> _$SaveDefaultAddressRequestModelToJson(
        SaveDefaultAddressRequestModel instance) =>
    <String, dynamic>{
      'setIsDefaultBilling': instance.setIsDefaultBilling,
      'storeId': instance.storeId,
      'websiteId': instance.websiteId,
      'customerToken': instance.customerToken,
      'addressId': instance.addressId,
      'setIsDefaultShipping': instance.setIsDefaultShipping,
    };
