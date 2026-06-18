// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginUserResponse _$LoginUserResponseFromJson(Map<String, dynamic> json) =>
    _LoginUserResponse(
      user: json['user'] == null
          ? null
          : UserResponseData.fromJson(json['user'] as Map<String, dynamic>),
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      login: json['login'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      customerName: json['customerName'] as String?,
      customerEmail: json['customerEmail'] as String?,
      customerId: json['customerId'] as String?,
      customerToken: json['customerToken'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
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

Map<String, dynamic> _$LoginUserResponseToJson(_LoginUserResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'id': instance.id,
      'name': instance.name,
      'login': instance.login,
      'phoneNumber': instance.phoneNumber,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'customerId': instance.customerId,
      'customerToken': instance.customerToken,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
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

_UserResponseData _$UserResponseDataFromJson(Map<String, dynamic> json) =>
    _UserResponseData(
      publicId: json['publicId'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      countryCode: json['countryCode'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] == null
          ? null
          : UserRoleData.fromJson(json['role'] as Map<String, dynamic>),
      activeSubscription: json['activeSubscription'] == null
          ? null
          : UserSubscriptionData.fromJson(
              json['activeSubscription'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$UserResponseDataToJson(_UserResponseData instance) =>
    <String, dynamic>{
      'publicId': instance.publicId,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'countryCode': instance.countryCode,
      'phone': instance.phone,
      'role': instance.role,
      'activeSubscription': instance.activeSubscription,
    };

_UserRoleData _$UserRoleDataFromJson(Map<String, dynamic> json) =>
    _UserRoleData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserRoleDataToJson(_UserRoleData instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_UserSubscriptionData _$UserSubscriptionDataFromJson(
  Map<String, dynamic> json,
) => _UserSubscriptionData(
  subscriptionPublicId: json['subscriptionPublicId'] as String?,
  planName: json['planName'] as String?,
  planCode: json['planCode'] as String?,
  category: json['category'] as String?,
  billingCycle: json['billingCycle'] as String?,
  amount: json['amount'],
  currencyCode: json['currencyCode'] as String?,
  paymentStatus: json['paymentStatus'] as String?,
  subscriptionStatus: json['subscriptionStatus'] as String?,
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  isActive: json['isActive'] as bool?,
  durationDays: (json['durationDays'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserSubscriptionDataToJson(
  _UserSubscriptionData instance,
) => <String, dynamic>{
  'subscriptionPublicId': instance.subscriptionPublicId,
  'planName': instance.planName,
  'planCode': instance.planCode,
  'category': instance.category,
  'billingCycle': instance.billingCycle,
  'amount': instance.amount,
  'currencyCode': instance.currencyCode,
  'paymentStatus': instance.paymentStatus,
  'subscriptionStatus': instance.subscriptionStatus,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'isActive': instance.isActive,
  'durationDays': instance.durationDays,
};
