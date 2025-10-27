// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeleteWishlistModelImpl _$$DeleteWishlistModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DeleteWishlistModelImpl(
      websiteId: json['websiteId'] as String,
      customerToken: json['customerToken'] as String,
      itemId: json['itemId'] as String,
    );

Map<String, dynamic> _$$DeleteWishlistModelImplToJson(
        _$DeleteWishlistModelImpl instance) =>
    <String, dynamic>{
      'websiteId': instance.websiteId,
      'customerToken': instance.customerToken,
      'itemId': instance.itemId,
    };
