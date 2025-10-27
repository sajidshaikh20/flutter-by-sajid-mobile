// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_address_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAddressFormData _$GetAddressFormDataFromJson(Map<String, dynamic> json) =>
    GetAddressFormData(
      eTag: json['eTag'] as String?,
      websiteId: json['websiteId'] as String?,
      storeId: json['storeId'] as String?,
      customerToken: json['customerToken'] as String?,
      addressId: json['addressId'] as String?,
    );

Map<String, dynamic> _$GetAddressFormDataToJson(GetAddressFormData instance) =>
    <String, dynamic>{
      'eTag': instance.eTag,
      'websiteId': instance.websiteId,
      'storeId': instance.storeId,
      'customerToken': instance.customerToken,
      'addressId': instance.addressId,
    };
