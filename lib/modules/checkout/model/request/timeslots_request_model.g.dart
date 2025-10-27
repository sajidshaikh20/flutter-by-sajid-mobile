// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslots_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeslotsRequestModelImpl _$$TimeslotsRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TimeslotsRequestModelImpl(
      storeId: (json['storeId'] as num?)?.toInt(),
      regionId: (json['regionId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TimeslotsRequestModelImplToJson(
        _$TimeslotsRequestModelImpl instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'regionId': instance.regionId,
    };
