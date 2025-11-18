/// A model representing the account information of a logged-in customer.
class MyAccountInfoModel {
  /// Indicates whether the API call was successful.
  bool? success;

  /// Message returned from the API (e.g., error or success message).
  String? message;

  /// Unique identifier for the customer.
  String? customerId;

  /// Customer's registered email address.
  String? email;

  /// Customer's last name.
  String? lastName;

  /// Customer's first name.
  String? firstName;

  /// The total wallet balance of the customer.
  int? walletAmount;

  /// The total number of orders placed by the customer.
  int? orderTotal;

  /// The total number of returned orders.
  int? returnTotal;

  /// URL of the customer’s profile image.
  String? profileImage;

  /// Total number of items in the customer's cart.
  int? cartCount;

  /// Unique quote ID associated with the customer’s cart.
  String? quoteId;

  /// Customer’s mobile number.
  String? mobilenumber;

  /// Prefix of the customer's mobile number (e.g., country code).
  dynamic mobileNumberPrefix;

  /// Indicates whether prefix options are available.
  bool? prefixHasOptions;

  /// List of available prefix options.
  List<String>? prefixOptions;

  /// Indicates whether suffix options are available.
  bool? suffixHasOptions;

  /// List of available suffix options.
  List<String>? suffixOptions;

  /// Determines whether the fax field should be visible.
  bool? isFaxVisible;

  /// Determines whether the telephone field should be visible.
  bool? isTelephoneVisible;

  /// Determines whether the telephone field is required.
  bool? isTelephoneRequired;

  /// Format used for displaying dates.
  String? dateFormat;

  /// Entity tag used for cache validation.
  String? eTag;

  /// Creates an instance of [MyAccountInfoModel].
  MyAccountInfoModel({
    this.success,
    this.message,
    this.customerId,
    this.email,
    this.lastName,
    this.firstName,
    this.walletAmount,
    this.orderTotal,
    this.returnTotal,
    this.profileImage,
    this.cartCount,
    this.quoteId,
    this.mobilenumber,
    this.mobileNumberPrefix,
    this.prefixHasOptions,
    this.prefixOptions,
    this.suffixHasOptions,
    this.suffixOptions,
    this.isFaxVisible,
    this.isTelephoneVisible,
    this.isTelephoneRequired,
    this.dateFormat,
    this.eTag,
  });

  /// Creates a [MyAccountInfoModel] instance from a JSON object.
  MyAccountInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    customerId = json['customerId'];
    email = json['email'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    walletAmount = json['walletAmount'];
    orderTotal = json['orderTotal'];
    returnTotal = json['returnTotal'];
    profileImage = json['profileImage'];
    cartCount = json['cartCount'];
    quoteId = json['quoteId'].toString();
    mobilenumber = json['mobilenumber'];
    mobileNumberPrefix = json['mobileNumberPrefix'];
    prefixHasOptions = json['prefixHasOptions'];
    prefixOptions = (json['prefixOptions'] as List<dynamic>?)?.cast<String>();
    suffixHasOptions = json['suffixHasOptions'];
    suffixOptions = (json['suffixOptions'] as List<dynamic>?)?.cast<String>();
    isFaxVisible = json['isFaxVisible'];
    isTelephoneVisible = json['isTelephoneVisible'];
    isTelephoneRequired = json['isTelephoneRequired'];
    dateFormat = json['dateFormat'];
    eTag = json['eTag'];
  }

  /// Converts the current [MyAccountInfoModel] instance into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['customerId'] = customerId;
    data['email'] = email;
    data['lastName'] = lastName;
    data['firstName'] = firstName;
    data['walletAmount'] = walletAmount;
    data['orderTotal'] = orderTotal;
    data['returnTotal'] = returnTotal;
    data['profileImage'] = profileImage;
    data['cartCount'] = cartCount;
    data['quoteId'] = quoteId;
    data['mobilenumber'] = mobilenumber;
    data['mobileNumberPrefix'] = mobileNumberPrefix;
    data['prefixHasOptions'] = prefixHasOptions;
    data['prefixOptions'] = prefixOptions;
    data['suffixHasOptions'] = suffixHasOptions;
    data['suffixOptions'] = suffixOptions;
    data['isFaxVisible'] = isFaxVisible;
    data['isTelephoneVisible'] = isTelephoneVisible;
    data['isTelephoneRequired'] = isTelephoneRequired;
    data['dateFormat'] = dateFormat;
    data['eTag'] = eTag;
    return data;
  }
}
