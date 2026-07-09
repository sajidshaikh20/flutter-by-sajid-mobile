/// Model class for user profile information.
class UserProfileModel {
  /// The user's phone number.
  final String phoneNumber;

  /// The phone number prefix.
  final dynamic prefix;

  /// The customer's full name.
  final String customerName;

  /// The customer's email address.
  final String customerEmail;

  /// The unique customer identifier.
  final String? customerId;

  /// The customer authentication token.
  final String customerToken;

  /// The access token for API requests.
  final String? accessToken;

  /// The refresh token to renew session.
  final String? refreshToken;

  /// The customer's username.
  final String? username;

  /// The user's role ID.
  final int? roleId;

  /// The user's role name.
  final String? roleName;

  /// Subscription public ID.
  final String? subscriptionPublicId;

  /// Subscription plan name.
  final String? planName;

  /// Subscription plan code.
  final String? planCode;

  /// Subscription category.
  final String? category;

  /// Subscription billing cycle.
  final String? billingCycle;

  /// Subscription amount.
  final double? amount;

  /// Subscription currency code.
  final String? currencyCode;

  /// Subscription payment status.
  final String? paymentStatus;

  /// Subscription status.
  final String? subscriptionStatus;

  /// Subscription start date.
  final String? startDate;

  /// Subscription end date.
  final String? endDate;

  /// Whether the subscription is active.
  final bool? isActive;

  /// Duration of subscription in days.
  final int? durationDays;

  /// The profile picture URL from the live server.
  final String? profilePictureUrl;

  /// The default/custom trading balance.
  final double? amountBalance;

  /// The default/custom trading risk percentage.
  final double? riskPercentage;

  /// Whether it's the user's first time logging in.
  final bool? firstTimeLogin;

  /// Creates an instance of [UserProfileModel].
  UserProfileModel({
    required this.phoneNumber,
    required this.prefix,
    required this.customerName,
    required this.customerEmail,
    required this.customerId,
    required this.customerToken,
    this.accessToken,
    this.refreshToken,
    this.username,
    this.roleId,
    this.roleName,
    this.subscriptionPublicId,
    this.planName,
    this.planCode,
    this.category,
    this.billingCycle,
    this.amount,
    this.currencyCode,
    this.paymentStatus,
    this.subscriptionStatus,
    this.startDate,
    this.endDate,
    this.isActive,
    this.durationDays,
    this.profilePictureUrl,
    this.amountBalance,
    this.riskPercentage,
    this.firstTimeLogin,
  });

  /// Creates an instance of [UserProfileModel] from a JSON map.
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      phoneNumber: json['phoneNumber'] ?? '',
      prefix: json['prefix'] ?? '',
      customerName: json['customerName'] ?? '',
      customerEmail: json['customerEmail'] ?? '',
      customerId: json['customerId'] ?? '',
      customerToken: json['customerToken'] ?? '',
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      username: json['username'],
      roleId: json['roleId'],
      roleName: json['roleName'],
      subscriptionPublicId: json['subscriptionPublicId'],
      planName: json['planName'],
      planCode: json['planCode'],
      category: json['category'],
      billingCycle: json['billingCycle'],
      amount: json['amount'] != null ? double.tryParse(json['amount'].toString()) : null,
      currencyCode: json['currencyCode'],
      paymentStatus: json['paymentStatus'],
      subscriptionStatus: json['subscriptionStatus'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      isActive: json['isActive'],
      durationDays: json['durationDays'],
      profilePictureUrl: json['profilePictureUrl'],
      amountBalance: json['amountBalance'] != null ? double.tryParse(json['amountBalance'].toString()) : null,
      riskPercentage: json['riskPercentage'] != null ? double.tryParse(json['riskPercentage'].toString()) : null,
      firstTimeLogin: json['firstTimeLogin'] as bool?,
    );
  }

   /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'prefix': prefix,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerId': customerId,
      'customerToken': customerToken,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'username': username,
      'roleId': roleId,
      'roleName': roleName,
      'subscriptionPublicId': subscriptionPublicId,
      'planName': planName,
      'planCode': planCode,
      'category': category,
      'billingCycle': billingCycle,
      'amount': amount,
      'currencyCode': currencyCode,
      'paymentStatus': paymentStatus,
      'subscriptionStatus': subscriptionStatus,
      'startDate': startDate,
      'endDate': endDate,
      'isActive': isActive,
      'durationDays': durationDays,
      'profilePictureUrl': profilePictureUrl,
      'amountBalance': amountBalance,
      'riskPercentage': riskPercentage,
      'firstTimeLogin': firstTimeLogin,
    };
  }

  /// Creates a copy of this [UserProfileModel] with optional new values.
  UserProfileModel copyWith({
    String? phoneNumber,
    dynamic prefix,
    String? customerName,
    String? customerEmail,
    String? customerId,
    String? customerToken,
    String? accessToken,
    String? refreshToken,
    String? username,
    int? roleId,
    String? roleName,
    String? subscriptionPublicId,
    String? planName,
    String? planCode,
    String? category,
    String? billingCycle,
    double? amount,
    String? currencyCode,
    String? paymentStatus,
    String? subscriptionStatus,
    String? startDate,
    String? endDate,
    bool? isActive,
    int? durationDays,
    String? profilePictureUrl,
    double? amountBalance,
    double? riskPercentage,
    bool? firstTimeLogin,
  }) {
    return UserProfileModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      prefix: prefix ?? this.prefix,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerId: customerId ?? this.customerId,
      customerToken: customerToken ?? this.customerToken,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      username: username ?? this.username,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      subscriptionPublicId: subscriptionPublicId ?? this.subscriptionPublicId,
      planName: planName ?? this.planName,
      planCode: planCode ?? this.planCode,
      category: category ?? this.category,
      billingCycle: billingCycle ?? this.billingCycle,
      amount: amount ?? this.amount,
      currencyCode: currencyCode ?? this.currencyCode,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      durationDays: durationDays ?? this.durationDays,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      amountBalance: amountBalance ?? this.amountBalance,
      riskPercentage: riskPercentage ?? this.riskPercentage,
      firstTimeLogin: firstTimeLogin ?? this.firstTimeLogin,
    );
  }
}
