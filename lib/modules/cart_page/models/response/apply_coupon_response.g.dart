// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_coupon_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplyCouponResponseImpl _$$ApplyCouponResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplyCouponResponseImpl(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$$ApplyCouponResponseImplToJson(
        _$ApplyCouponResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
