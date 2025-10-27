/// Model class for cancel order request parameters.
class CancelOrderRequestModel {
  /// The language identifier.
  int? languageId;

  /// The customer authentication token.
  String? customerToken;

  /// The platform from which the request is made.
  String? platform;

  /// The application version.
  String? version;

  /// The ID of the order to cancel.
  String? orderId;

  /// Creates an instance of [CancelOrderRequestModel].
  CancelOrderRequestModel({
    this.languageId,
    this.platform,
    this.version,
    this.customerToken,
    this.orderId,
  });

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['platform'] = platform;
    data['version'] = version;
    data['customerToken'] = customerToken;
    data['orderId'] = orderId;

    return data;
  }
}


