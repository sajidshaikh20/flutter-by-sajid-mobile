/// Model class for user profile information.
class UserProfileModel {
  /// The user's phone number.
  final String phoneNumber;

  /// The user's mobile number.
  final String mobileNumber;

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

  /// The customer's last name.
  final String? lastName;

  /// The customer's first name.
  final String? firstName;

  /// The number of items in the customer's cart.
  final int? cartCount;

  /// The customer's quote/cart identifier.
  final dynamic quoteId;

  /// The total value of all customer orders.
  final String totalOrderValue;

  /// The date of the customer's last order.
  final String lastOrderDate;

  /// The customer's store credit balance.
  final String storeCredit;

  /// The customer's reward points balance.
  final String rewardPoints;

  /// The customer's referral code.
  final String referralCode;

  /// The FCM token for push notifications.
  final String fcmToken;

  /// The customer's nationality in Arabic.
  final String arabicNationality;

  /// The customer's gender.
  final String gender;

  /// The customer's birthday.
  final String birthday;

  /// The customer's nationality.
  final String nationality;

  /// The total number of orders placed by the customer.
  final int totalOrder;

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

  /// Creates an instance of [UserProfileModel].
  UserProfileModel({
    required this.phoneNumber,
    required this.mobileNumber,
    required this.prefix,
    required this.customerName,
    required this.customerEmail,
    required this.customerId,
    required this.customerToken,
    this.lastName,
    this.firstName,
    this.cartCount,
    required this.quoteId,
    required this.totalOrderValue,
    required this.lastOrderDate,
    required this.storeCredit,
    required this.rewardPoints,
    required this.totalOrder,
    required this.referralCode,
    required this.fcmToken,
    required this.gender,
    required this.birthday,
    required this.nationality,
    required this.arabicNationality,
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
  });

  /// Creates an instance of [UserProfileModel] from a JSON map.
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      phoneNumber: json['phoneNumber'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      prefix: json['prefix'] ?? '',
      customerName: json['customerName'] ?? '',
      customerEmail: json['customerEmail'] ?? '',
      customerId: json['customerId'] ?? '',
      customerToken: json['customerToken'] ?? '',
      lastName: json['lastName'],
      firstName: json['firstName'],
      cartCount: json['cartCount'],
      quoteId: json['quoteId'] ?? '',
      totalOrderValue: json['totalOrderValue'] ?? '',
      lastOrderDate: json['lastOrderDate'] ?? '',
      storeCredit: json['storeCredit'] ?? '',
      rewardPoints: json['rewardPoints'] ?? '',
      totalOrder: json['totalOrder'] ?? 0,
      nationality: json['nationality'] ?? '',
      birthday: json['birthday'] ?? '',
      gender: json['gender'] ?? '',
      fcmToken: json['fcmToken'] ?? '',
      referralCode: json['referralCode'] ?? '',
      arabicNationality: json['arabicNationality'] ?? '',
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
    );
  }

   /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'mobileNumber': mobileNumber,
      'prefix': prefix,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerId': customerId,
      'customerToken': customerToken,
      'lastName': lastName,
      'firstName': firstName,
      'cartCount': cartCount,
      'quoteId': quoteId,
      'totalOrderValue': totalOrderValue,
      'lastOrderDate': lastOrderDate,
      'storeCredit': storeCredit,
      'rewardPoints': rewardPoints,
      'totalOrder': totalOrder,
      'referralCode': referralCode,
      'fcmToken': fcmToken,
      'gender': gender,
      'birthday': birthday,
      'nationality': nationality,
      'arabicNationality': arabicNationality,
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
    };
  }

  /// Creates a copy of this [UserProfileModel] with optional new values.
  UserProfileModel copyWith({
    String? phoneNumber,
    String? mobileNumber,
    dynamic prefix,
    String? customerName,
    String? customerEmail,
    String? customerId,
    String? customerToken,
    String? lastName,
    String? firstName,
    int? cartCount,
    dynamic quoteId,
    String? totalOrderValue,
    String? lastOrderDate,
    String? storeCredit,
    String? rewardPoints,
    String? nationality,
    String? gender,
    String? birthday,
    String? referralCode,
    String? fcmToken,
    String? arabicNationality,
    int? totalOrder,
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
  }) {
    return UserProfileModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      prefix: prefix ?? this.prefix,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerId: customerId ?? this.customerId,
      customerToken: customerToken ?? this.customerToken,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      cartCount: cartCount ?? this.cartCount,
      quoteId: quoteId ?? this.quoteId,
      totalOrderValue: totalOrderValue ?? this.totalOrderValue,
      lastOrderDate: lastOrderDate ?? this.lastOrderDate,
      storeCredit: storeCredit ?? this.storeCredit,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      totalOrder: totalOrder ?? this.totalOrder,
      referralCode: referralCode ?? this.referralCode,
      fcmToken: fcmToken ?? this.fcmToken,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      birthday: birthday ?? this.birthday,
      arabicNationality: arabicNationality ?? this.arabicNationality,
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
    );
  }
}
