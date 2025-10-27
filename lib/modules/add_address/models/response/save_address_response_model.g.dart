// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_address_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveAddressResponseModel _$SaveAddressResponseModelFromJson(
        Map<String, dynamic> json) =>
    SaveAddressResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$SaveAddressResponseModelToJson(
        SaveAddressResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'id': instance.id,
    };
