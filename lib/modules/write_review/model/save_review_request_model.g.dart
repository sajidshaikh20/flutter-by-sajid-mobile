// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_review_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaveReviewRequestModelImpl _$$SaveReviewRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SaveReviewRequestModelImpl(
      websiteId: json['websiteId'] as String?,
      storeId: json['storeId'] as String?,
      quoteId: json['quoteId'] as String?,
      customerToken: json['customerToken'] as String?,
      title: json['title'] as String?,
      details: json['details'] as String?,
      productID: json['productID'] as String?,
      nickname: json['nickname'] as String?,
      ratings: json['ratings'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SaveReviewRequestModelImplToJson(
        _$SaveReviewRequestModelImpl instance) =>
    <String, dynamic>{
      'websiteId': instance.websiteId,
      'storeId': instance.storeId,
      'quoteId': instance.quoteId,
      'customerToken': instance.customerToken,
      'title': instance.title,
      'details': instance.details,
      'productID': instance.productID,
      'nickname': instance.nickname,
      'ratings': instance.ratings,
    };
