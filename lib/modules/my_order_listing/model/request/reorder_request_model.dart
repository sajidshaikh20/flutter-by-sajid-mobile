/// Model class for reorder request parameters.
class ReorderRequestModel {
  /// The language identifier.
  int? languageId;

  /// The store identifier.
  int? storeId;

  /// The customer authentication token.
  String? customerToken;

  /// The platform from which the request is made.
  String? platform;

  /// The application version.
  String? version;

  /// The ID of the order to reorder.
  String? orderId;

  /// Creates an instance of [ReorderRequestModel].
  ReorderRequestModel({
    this.languageId,
    this.storeId,
    this.customerToken,
    this.version,
    this.platform,
    this.orderId,
  });

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['storeId'] = storeId;
    data['customerToken'] = customerToken;
    data['version'] = version;
    data['platform'] = platform;
    data['orderId'] = orderId;

    return data;
  }
}

