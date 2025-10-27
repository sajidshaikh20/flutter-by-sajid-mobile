import '../../../../utils/exports.dart';

/// A model class representing the shipping method request for an order.
class ShippingMethodRequest {
  /// Creates a new instance of [ShippingMethodRequest].
  ///
  /// [websiteId] The ID of the website.
  /// [storeId] The ID of the store.
  /// [customerToken] The customer's authentication token.
  /// [quoteId] The ID of the quote.
  /// [currency] The currency for the transaction.
  /// [method] The shipping method.
  /// [forDisplay] A flag indicating whether the shipping method is for display.
  /// [shippingData] The shipping address and related information.
  ShippingMethodRequest({
    this.websiteId,
    this.storeId,
    this.customerToken,
    this.quoteId,
    this.currency,
    this.method,
    this.forDisplay,
    this.shippingData,
  });

  /// Creates a [ShippingMethodRequest] from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters of the
  /// constructor.
  ShippingMethodRequest.fromJson(Map<String, dynamic> json) {
    websiteId = json['websiteId'] as int?;
    storeId = json['storeId'] as int?;
    customerToken = json['customerToken'] as String?;
    quoteId = json['quoteId'] as int?;
    currency = json['currency'] as String?;
    method = json['method'] as String?;
    forDisplay = json['forDisplay'] as int?;
    shippingData = json['shippingData'] != null
        ? ShippingData.fromJson(json['shippingData'] as Map<String, dynamic>)
        : null;
  }

  /// The ID of the website.
  int? websiteId;

  /// The ID of the store.
  int? storeId;

  /// The customer's authentication token.
  String? customerToken;

  /// The ID of the quote.
  int? quoteId;

  /// The currency for the transaction.
  String? currency;

  /// The shipping method.
  String? method;

  /// A flag indicating whether the shipping method is for display.
  int? forDisplay;

  /// The shipping address and related information.
  ShippingData? shippingData;

  /// Converts the [ShippingMethodRequest] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs that represent the instance's fields.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['websiteId'] = websiteId;
    data['storeId'] = storeId;
    data['customerToken'] = customerToken;
    data['quoteId'] = quoteId;
    data['currency'] = currency;
    data['method'] = method;
    data['forDisplay'] = forDisplay;
    if (shippingData != null) {
      data['shippingData'] = jsonEncode(shippingData!.toJson());
    }
    return data;
  }
}
