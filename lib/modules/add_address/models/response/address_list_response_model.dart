/// Model class representing a response containing address details.
class AddressListResponseModel {
  /// Constructor for
  /// [AddressListResponseModel] that initializes all attributes.
  AddressListResponseModel({
    this.success,
    this.message,
    this.billingAddress,
    this.shippingAddress,
    this.additionalAddress,
    this.cartCount,
    this.addressCount,
  });

  /// Creates an [AddressListResponseModel] instance from a [json] map.
  AddressListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    billingAddress = json['billingAddress'] != null
        ? BillingAddress.fromJson(json['billingAddress'])
        : null;
    shippingAddress = json['shippingAddress'] != null
        ? BillingAddress.fromJson(json['shippingAddress'])
        : null;
    if (json['additionalAddress'] != null) {
      additionalAddress = (json['additionalAddress'] as List<dynamic>)
          .map((dynamic v) => BillingAddress.fromJson(v))
          .toList();
    }

    cartCount = json['cartCount'];
    addressCount = json['addressCount'];
  }

  /// Flag indicating whether the request was successful.
  bool? success;

  /// A message associated with the response.
  String? message;

  /// Billing address details.
  BillingAddress? billingAddress;

  /// Shipping address details.
  BillingAddress? shippingAddress;

  /// List of additional addresses.
  List<BillingAddress>? additionalAddress;

  /// Count of items in the cart.
  int? cartCount;

  /// Count of addresses in the response.
  int? addressCount;

  /// Converts the [AddressListResponseModel] instance to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (billingAddress != null) {
      data['billingAddress'] = billingAddress!.toJson();
    }
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    if (additionalAddress != null) {
      data['additionalAddress'] =
          additionalAddress!.map((BillingAddress v) => v.toJson()).toList();
    }
    data['cartCount'] = cartCount;
    data['addressCount'] = addressCount;
    return data;
  }
}

/// A class representing a billing address.
class BillingAddress {
  /// Creates a [BillingAddress] with the provided details.
  BillingAddress({
    this.firstname,
    this.lastname,
    this.email,
    this.telephone,
    this.id,
    this.regionId,
    this.addressTitle,
    this.company,
    this.street,
    this.city,
    this.region,
    this.countryId,
    this.postcode,
    this.latLong,
    this.isSelected,
    this.isBilling,
    this.isShipping,
    this.mobileNumberPrefix,
  });

  /// Creates a [BillingAddress] from a JSON map.
  BillingAddress.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    telephone = json['telephone'];
    id = json['id'];
    regionId = json['regionId'];
    addressTitle = json['addressTitle'];
    company = json['company'];
    street = (json['street'] as List<dynamic>?)
        ?.map((dynamic e) => e as String)
        .toList();
    city = json['city'];
    region = json['region'];
    countryId = json['countryId'];
    postcode = json['postcode'];
    latLong = json['latLong'];
    isBilling = json['isBilling'];
    isShipping = json['isShipping'];
    mobileNumberPrefix = json['mobileNumberPrefix'];
  }

  /// The first name of the person associated with the billing address.
  String? firstname;

  /// The last name of the person associated with the billing address.
  String? lastname;

  /// The email address associated with the billing address.
  String? email;

  /// The telephone number associated with the billing address.
  String? telephone;

  /// The unique ID of the billing address.
  String? id;

  /// The region ID of the billing address.
  int? regionId;

  /// A title for the address (e.g., "Home" or "Office").
  String? addressTitle;

  /// The company associated with the billing address.
  String? company;

  /// A list of street addresses for the billing address.
  List<String>? street;

  /// The city for the billing address.
  String? city;

  /// The region for the billing address.
  String? region;

  /// The country ID for the billing address.
  String? countryId;

  /// The postal code for the billing address.
  String? postcode;

  /// The latitude and longitude of the billing address (optional).
  String? latLong;

  /// Indicates whether this address is used for billing (1 if true).
  int? isBilling;

  /// Indicates whether this address is used for shipping (1 if true).
  int? isShipping;

  /// Whether this address is selected (optional).
  bool? isSelected;

  /// The mobile number prefix for the billing address.
  String? mobileNumberPrefix;

  /// Converts the [BillingAddress] instance to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['telephone'] = telephone;
    data['id'] = id;
    data['regionId'] = regionId;
    data['addressTitle'] = addressTitle;
    data['company'] = company;
    data['street'] = street;
    data['city'] = city;
    data['region'] = region;
    data['countryId'] = countryId;
    data['postcode'] = postcode;
    data['latLong'] = latLong;
    data['isBilling'] = isBilling;
    data['isShipping'] = isShipping;
    data['mobileNumberPrefix'] = mobileNumberPrefix;
    return data;
  }
}
