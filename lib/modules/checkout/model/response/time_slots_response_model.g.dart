// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slots_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotsResponseModel _$TimeSlotsResponseModelFromJson(
        Map<String, dynamic> json) =>
    TimeSlotsResponseModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TimeSlotData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimeSlotsResponseModelToJson(
        TimeSlotsResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

TimeSlotData _$TimeSlotDataFromJson(Map<String, dynamic> json) => TimeSlotData(
      date: json['date'] as String?,
      day: json['day'] as String?,
      slots: (json['slots'] as List<dynamic>?)
          ?.map((e) => Slot.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$TimeSlotDataToJson(TimeSlotData instance) =>
    <String, dynamic>{
      'date': instance.date,
      'day': instance.day,
      'slots': instance.slots,
      'isSelected': instance.isSelected,
    };

Slot _$SlotFromJson(Map<String, dynamic> json) => Slot(
      id: json['id'] as String?,
      time: json['time'] as String?,
      availability: (json['availability'] as num?)?.toInt(),
      enable: json['enable'] as bool?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'availability': instance.availability,
      'enable': instance.enable,
      'isSelected': instance.isSelected,
    };
