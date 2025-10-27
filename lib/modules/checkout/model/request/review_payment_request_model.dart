/// A model class representing a request for reviewing payment details.
class ReviewPaymentRequestModel {
  /// Creates a new instance of [ReviewPaymentRequestModel].
  ///
  /// [storeId] The ID of the store where the payment is being reviewed.
  /// [quoteId] The ID of the quote associated with the payment.
  /// [websiteId] The ID of the website where the payment is being reviewed.
  /// [currency] The currency used for the payment.
  /// [method] The payment method (e.g., 'credit card', 'paypal').
  /// [shippingMethod] The selected shipping method for the order.
  /// [width] The width (size) of the payment request (used for calculation).
  ReviewPaymentRequestModel({
    this.quoteId,
    this.storeId,
    this.method,
    this.websiteId,
    this.currency,
    this.shippingMethod,
    this.width,
  });

  /// Creates a [ReviewPaymentRequestModel] from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters of
  /// the constructor.
  ReviewPaymentRequestModel.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    quoteId = json['quoteId'];
    websiteId = json['websiteId'];
    currency = json['currency'];
    method = json['method'];
    width = json['width'];
    shippingMethod = json['shippingMethod'];
  }

  /// The ID of the store where the payment is being reviewed.
  String? storeId;

  /// The ID of the quote associated with the payment.
  String? quoteId;

  /// The ID of the website where the payment is being reviewed.
  String? websiteId;

  /// The currency used for the payment.
  String? currency;

  /// The payment method used for the transaction.
  String? method;

  /// The shipping method selected for the order.
  String? shippingMethod;

  /// The width (size) of the payment request (used for calculation).
  int? width;

  /// Converts the [ReviewPaymentRequestModel] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs that represent the instance's fields.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['storeId'] = storeId;
    data['quoteId'] = quoteId;
    data['websiteId'] = websiteId;
    data['currency'] = currency;
    data['method'] = method;
    data['width'] = width;
    data['shippingMethod'] = shippingMethod;
    return data;
  }
}
