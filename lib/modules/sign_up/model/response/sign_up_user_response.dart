/// Model class for signup user response data.
class SignupUserResponse {
  /// The user's phone number.
  final String? phoneNumber;

  /// The customer's full name.
  final String? customerName;

  /// The customer's email address.
  final String? customerEmail;

  /// The unique customer ID.
  final int? customerId;

  /// The customer's authentication token.
  final String? customerToken;

  /// The customer's date of birth.
  final String? customerDob;

  /// The number of items in the customer's cart.
  final int? cartCount;

  /// The customer's quote/cart ID.
  final dynamic quoteId;

  /// The total value of customer's orders.
  final String? totalOrderValue;

  /// The date of the customer's last order.
  final String? lastOrderDate;

  /// The customer's wallet balance.
  final String? walletBalance;

  /// The customer's nationality.
  final String? nationality;

  /// The customer's gender.
  final String? gender;

  /// The customer's referral code.
  final String? referralCode;

  /// The customer's loyalty points.
  final String? loyaltyPoints;

  /// The total number of orders placed by the customer.
  final dynamic totalOrder;

  /// The customer's phone number prefix.
  final int? prefix;

  /// Creates a new instance of [SignupUserResponse].
  SignupUserResponse({
    this.phoneNumber,
    this.customerName,
    this.customerEmail,
    this.customerId,
    this.customerToken,
    this.customerDob,
    this.cartCount,
    this.quoteId,
    this.totalOrderValue,
    this.lastOrderDate,
    this.walletBalance,
    this.loyaltyPoints,
    this.totalOrder,
    this.referralCode,
    this.nationality,
    this.gender,
    this.prefix,
  });

  /// Creates a copy of this [SignupUserResponse] with optional new values.
  SignupUserResponse copyWith({
    String? phoneNumber,
    String? customerName,
    String? customerEmail,
    int? customerId,
    String? customerToken,
    String? customerDob,
    int? cartCount,
    int? quoteId,
    String? totalOrderValue,
    String? lastOrderDate,
    String? walletBalance,
    String? referralCode,
    String? nationality,
    String? gender,
    String? loyaltyPoints,
    dynamic totalOrder,
    int? prefix,
  }) =>
      SignupUserResponse(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        customerName: customerName ?? this.customerName,
        customerEmail: customerEmail ?? this.customerEmail,
        customerId: customerId ?? this.customerId,
        customerToken: customerToken ?? this.customerToken,
        customerDob: customerDob ?? this.customerDob,
        cartCount: cartCount ?? this.cartCount,
        quoteId: quoteId ?? this.quoteId,
        totalOrderValue: totalOrderValue ?? this.totalOrderValue,
        lastOrderDate: lastOrderDate ?? this.lastOrderDate,
        walletBalance: walletBalance ?? this.walletBalance,
        loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
        totalOrder: totalOrder ?? this.totalOrder,
        nationality: nationality ?? this.nationality,
        referralCode: referralCode ?? this.referralCode,
        gender: gender ?? this.gender,
        prefix: prefix ?? this.prefix,
      );

  /// Creates a [SignupUserResponse] instance from a JSON map.
  factory SignupUserResponse.fromJson(Map<String, dynamic> json) {
    return SignupUserResponse(
      phoneNumber: json['phoneNumber'] as String?,
      customerName: json['customerName'] as String?,
      customerEmail: json['customerEmail'] as String?,
      customerId: json['customerId'] as int?,
      customerToken: json['customerToken'] as String?,
      customerDob: json['customerDob'] as String?,
      cartCount: json['cartCount'] as int?,
      quoteId: json['quoteId'] as dynamic,
      totalOrderValue: json['totalOrderValue'] as String?,
      lastOrderDate: json['lastOrderDate'] as String?,
      walletBalance: json['walletBalance'] as String?,
      referralCode: json['referralCode'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      loyaltyPoints: json['loyaltyPoints'] as String?,
      totalOrder: json['totalOrder'] as dynamic,
      prefix: json['prefix'] as int?,
    );
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerId': customerId,
      'customerToken': customerToken,
      'customerDob': customerDob,
      'cartCount': cartCount,
      'quoteId': quoteId,
      'totalOrderValue': totalOrderValue,
      'lastOrderDate': lastOrderDate,
      'walletBalance': walletBalance,
      'loyaltyPoints': loyaltyPoints,
      'totalOrder': totalOrder,
      'nationality': nationality,
      'gender': gender,
      'referralCode': referralCode,
      'prefix': prefix,
    };
  }
}
