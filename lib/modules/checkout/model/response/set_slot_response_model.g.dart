// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_slot_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetSlotResponseModel _$SetSlotResponseModelFromJson(
        Map<String, dynamic> json) =>
    SetSlotResponseModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SetSlotResponseModelToJson(
        SetSlotResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
