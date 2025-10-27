// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_city_address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCityAddressResponse _$GetCityAddressResponseFromJson(
        Map<String, dynamic> json) =>
    GetCityAddressResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      cityArea: (json['cityArea'] as List<dynamic>?)
          ?.map((e) => CityArea.fromJson(e as Map<String, dynamic>))
          .toList(),
      eTag: json['eTag'] as String?,
    );

Map<String, dynamic> _$GetCityAddressResponseToJson(
        GetCityAddressResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'cityArea': instance.cityArea,
      'eTag': instance.eTag,
    };

CityArea _$CityAreaFromJson(Map<String, dynamic> json) => CityArea(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CityAreaToJson(CityArea instance) => <String, dynamic>{
      'name': instance.name,
    };
