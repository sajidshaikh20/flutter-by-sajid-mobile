/// Model class for my order detail request parameters.
class MyOrderDetailRequestModel {
  /// The language identifier.
  int? languageId;

  /// The store identifier.
  int? storeId;

  /// The customer authentication token.
  String? customerToken;

  /// The order identifier.
  int? orderId;

  /// Creates an instance of [MyOrderDetailRequestModel].
  MyOrderDetailRequestModel({
    this.languageId,
    this.storeId,
    this.customerToken,
    this.orderId,
  });

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['storeId'] = storeId;
    data['customerToken'] = customerToken;
    data['orderId'] = orderId;

    return data;
  }
}


