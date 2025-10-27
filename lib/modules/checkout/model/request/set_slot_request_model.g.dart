// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_slot_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetSlotRequestModelImpl _$$SetSlotRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SetSlotRequestModelImpl(
      slotId: (json['slotId'] as num?)?.toInt(),
      quoteId: (json['quoteId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SetSlotRequestModelImplToJson(
        _$SetSlotRequestModelImpl instance) =>
    <String, dynamic>{
      'slotId': instance.slotId,
      'quoteId': instance.quoteId,
    };
