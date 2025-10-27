// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_list_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetCartListDetailsRequestImpl _$$GetCartListDetailsRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$GetCartListDetailsRequestImpl(
      customerToken: json['customerToken'] as String?,
      storeId: json['storeId'] as String?,
      quoteId: json['quoteId'] as String?,
      websiteId: json['websiteId'] as String?,
      currency: json['currency'] as String?,
      method: json['method'] as String?,
      eTag: json['eTag'] as String?,
      width: json['width'] as String?,
    );

Map<String, dynamic> _$$GetCartListDetailsRequestImplToJson(
        _$GetCartListDetailsRequestImpl instance) =>
    <String, dynamic>{
      'customerToken': instance.customerToken,
      'storeId': instance.storeId,
      'quoteId': instance.quoteId,
      'websiteId': instance.websiteId,
      'currency': instance.currency,
      'method': instance.method,
      'eTag': instance.eTag,
      'width': instance.width,
    };
