// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EditProfileResponseImpl _$$EditProfileResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$EditProfileResponseImpl(
      phoneNumber: json['phoneNumber'] as String?,
      customerName: json['customerName'] as String?,
      customerEmail: json['customerEmail'] as String?,
      customerId: json['customerId'] as String?,
      customerToken: json['customerToken'] as String?,
      referralCode: json['referralCode'] as String?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      quoteId: json['quoteId'],
      totalOrderValue: json['totalOrderValue'] as String?,
      lastOrderDate: json['lastOrderDate'] as String?,
      walletBalance: json['walletBalance'] as String?,
      loyaltyPoints: json['loyaltyPoints'] as String?,
      totalOrder: (json['totalOrder'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      nationality: json['nationality'] as String?,
      fcmToken: json['fcmToken'] as String?,
      arabicNationality: json['arabicNationality'] as String?,
      prefix: (json['prefix'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EditProfileResponseImplToJson(
        _$EditProfileResponseImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'customerId': instance.customerId,
      'customerToken': instance.customerToken,
      'referralCode': instance.referralCode,
      'cartCount': instance.cartCount,
      'quoteId': instance.quoteId,
      'totalOrderValue': instance.totalOrderValue,
      'lastOrderDate': instance.lastOrderDate,
      'walletBalance': instance.walletBalance,
      'loyaltyPoints': instance.loyaltyPoints,
      'totalOrder': instance.totalOrder,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'nationality': instance.nationality,
      'fcmToken': instance.fcmToken,
      'arabicNationality': instance.arabicNationality,
      'prefix': instance.prefix,
    };
