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
  });

  /// Creates an instance of [UserProfileModel] from a JSON map.
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      phoneNumber: json['phoneNumber'],
      mobileNumber: json['mobileNumber'],
      prefix: json['prefix'],
      customerName: json['customerName'],
      customerEmail: json['customerEmail'],
      customerId: json['customerId'],
      customerToken: json['customerToken'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      cartCount: json['cartCount'],
      quoteId: json['quoteId'],
      totalOrderValue: json['totalOrderValue'],
      lastOrderDate: json['lastOrderDate'],
      storeCredit: json['storeCredit'],
      rewardPoints: json['rewardPoints'],
      totalOrder: json['totalOrder'],
      nationality: json['nationality'],
      birthday: json['birthday'],
      gender: json['gender'],
      fcmToken: json['fcmToken'],
      referralCode: json['referralCode'],
      arabicNationality: json['arabicNationality'],
      username: json['username'],
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
    );
  }
}
