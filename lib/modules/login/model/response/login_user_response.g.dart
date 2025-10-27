// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginUserResponseImpl _$$LoginUserResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginUserResponseImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      login: json['login'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      customerName: json['customerName'] as String?,
      customerEmail: json['customerEmail'] as String?,
      customerId: json['customerId'] as String?,
      customerToken: json['customerToken'] as String?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      quoteId: json['quoteId'],
      totalOrderValue: json['totalOrderValue'] as String?,
      lastOrderDate: json['lastOrderDate'] as String?,
      walletBalance: json['walletBalance'] as String?,
      loyaltyPoints: json['loyaltyPoints'] as String?,
      totalOrder: (json['totalOrder'] as num?)?.toInt(),
      referralCode: json['referralCode'] as String?,
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      nationality: json['nationality'] as String?,
      arabicNationality: json['arabicNationality'] as String?,
      prefix: json['prefix'],
    );

Map<String, dynamic> _$$LoginUserResponseImplToJson(
        _$LoginUserResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'login': instance.login,
      'phoneNumber': instance.phoneNumber,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'customerId': instance.customerId,
      'customerToken': instance.customerToken,
      'cartCount': instance.cartCount,
      'quoteId': instance.quoteId,
      'totalOrderValue': instance.totalOrderValue,
      'lastOrderDate': instance.lastOrderDate,
      'walletBalance': instance.walletBalance,
      'loyaltyPoints': instance.loyaltyPoints,
      'totalOrder': instance.totalOrder,
      'referralCode': instance.referralCode,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'nationality': instance.nationality,
      'arabicNationality': instance.arabicNationality,
      'prefix': instance.prefix,
    };
