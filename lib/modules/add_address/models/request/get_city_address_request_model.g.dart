// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_city_address_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCityAddressRequestModel _$GetCityAddressRequestModelFromJson(
        Map<String, dynamic> json) =>
    GetCityAddressRequestModel(
      websiteId: json['websiteId'] as String?,
      storeId: json['storeId'] as String?,
      customerToken: json['customerToken'] as String?,
      fieldId: json['fieldId'] as String?,
      regionId: json['regionId'] as String?,
    );

Map<String, dynamic> _$GetCityAddressRequestModelToJson(
        GetCityAddressRequestModel instance) =>
    <String, dynamic>{
      'websiteId': instance.websiteId,
      'storeId': instance.storeId,
      'customerToken': instance.customerToken,
      'fieldId': instance.fieldId,
      'regionId': instance.regionId,
    };
