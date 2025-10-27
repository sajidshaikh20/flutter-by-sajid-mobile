// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyWalletResponse _$MyWalletResponseFromJson(Map<String, dynamic> json) =>
    MyWalletResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      walletAmount: json['walletAmount'] as String?,
      totalCount: (json['totalCount'] as num?)?.toInt(),
      collection: (json['collection'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MyWalletResponseToJson(MyWalletResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'walletAmount': instance.walletAmount,
      'totalCount': instance.totalCount,
      'collection': instance.collection,
    };
