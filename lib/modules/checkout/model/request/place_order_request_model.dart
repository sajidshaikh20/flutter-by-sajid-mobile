/// A model class representing the request data for placing an order.
class PlaceOrderRequestModel {

  /// Creates a new instance of [PlaceOrderRequestModel].
  ///
  /// [storeId] The store ID associated with the request.
  /// [quoteId] The quote ID related to the order.
  /// [method] The method for the order, typically a payment method.
  /// [customerToken] The unique token associated with the customer.
  /// [websiteId] The website ID for the platform.
  /// [os] The operating system of the user's device (e.g., Android or iOS).
  /// [paymentMethod] The payment method for the order.
  /// [purchasePoint] The platform from which the order is made
  /// (e.g., Android or iOS).
  /// [token] A token for the transaction (usually a security token).
  /// [billingData] The billing data for the order.
  PlaceOrderRequestModel({
    this.storeId,
    this.quoteId,
    this.method,
    this.customerToken,
    this.websiteId,
    this.os,
    this.paymentMethod,
    this.purchasePoint,
    this.token,
    this.billingData,
  });

  /// Creates an instance of [PlaceOrderRequestModel] from a JSON map.
  ///
  /// This is used to deserialize JSON data from an API response.
  PlaceOrderRequestModel.fromJson(Map<String, dynamic> json) {
    customerToken = json['customerToken'];
    storeId = json['storeId'];
    quoteId = json['quoteId'];
    websiteId = json['websiteId'];
    method = json['method'];
    paymentMethod = json['paymentMethod'];
    purchasePoint = json['purchasePoint'];
    os = json['os'];
    token = json['token'];
    billingData = json['billingData'];
  }

  // Fields representing the order details

  /// The ID of the store making the request.
  String? storeId;

  /// The ID of the quote associated with the order.
  String? quoteId;

  /// The ID of the website from which the order is being placed.
  String? websiteId;

  /// The method to be used for the payment (e.g., "credit card", "cash").
  String? method;

  /// The token associated with the customer making the request.
  String? customerToken;

  /// The selected payment method for the order.
  String? paymentMethod;

  /// The platform from which the order is being made (e.g., Android, iOS).
  String? purchasePoint;

  /// The operating system of the user's device.
  String? os;

  /// A token for securing the transaction.
  String? token;

  /// The billing data associated with the order.
  String? billingData;

  /// Converts the [PlaceOrderRequestModel] instance into a JSON map.
  ///
  /// This is used for serializing data when making API requests.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['customerToken'] = customerToken;
    data['storeId'] = storeId;
    data['quoteId'] = quoteId;
    data['websiteId'] = websiteId;
    data['method'] = method;
    data['paymentMethod'] = paymentMethod;
    data['purchasePoint'] = purchasePoint;
    data['os'] = os;
    data['token'] = token;
    data['billingData'] = billingData;
    return data;
  }
}


/// A model class representing the billing address request for placing an order.
class BillingAddressRequestModel {

  /// Creates a new instance of [BillingAddressRequestModel].
  ///
  /// [addressId] The ID of the billing address.
  /// [newAddress] The new billing address details in a key-value map.
  /// [sameAsShipping] A flag indicating whether the billing address is
  /// the same as the shipping address.
  BillingAddressRequestModel({
    this.addressId,
    this.newAddress,
    this.sameAsShipping,
  });

  /// Creates an instance of [BillingAddressRequestModel] from a JSON map.
  ///
  /// This is used to deserialize JSON data from an API response.
  BillingAddressRequestModel.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    newAddress = json['newAddress'];
    sameAsShipping = json['sameAsShipping'];
  }

  // Fields representing the billing address details

  /// The ID of the billing address.
  String? addressId;

  /// The new billing address as a map of key-value pairs.
  Map<String, dynamic>? newAddress;

  /// A flag indicating if the billing address is the same as the
  /// shipping address.
  String? sameAsShipping;

  /// Converts the [BillingAddressRequestModel] instance into a JSON map.
  ///
  /// This is used for serializing data when making API requests.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['addressId'] = addressId;
    data['newAddress'] = newAddress;
    data['sameAsShipping'] = sameAsShipping;
    return data;
  }
}
