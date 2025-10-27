// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_wishlist_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CallWishlistRequestModelImpl _$$CallWishlistRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CallWishlistRequestModelImpl(
      customerToken: json['customerToken'] as String?,
      platform: json['platform'] as String?,
      version: json['version'] as String?,
      languageId: (json['languageId'] as num?)?.toInt(),
      storeId: (json['storeId'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      quoteId: (json['quoteId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CallWishlistRequestModelImplToJson(
        _$CallWishlistRequestModelImpl instance) =>
    <String, dynamic>{
      'customerToken': instance.customerToken,
      'platform': instance.platform,
      'version': instance.version,
      'languageId': instance.languageId,
      'storeId': instance.storeId,
      'limit': instance.limit,
      'offset': instance.offset,
      'quoteId': instance.quoteId,
    };
