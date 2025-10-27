/// Model class for my order request parameters.
class MyOrderRequestModel {
  /// The language identifier.
  int? languageId;

  /// The store identifier.
  int? storeId;

  /// The customer authentication token.
  String? customerToken;

  /// The type of order to filter by.
  String? orderType;

  /// The status of orders to filter by.
  String? orderStatus;

  /// The maximum number of orders to return.
  int? limit;

  /// The number of orders to skip for pagination.
  int? offset;

  /// Creates an instance of [MyOrderRequestModel].
  MyOrderRequestModel({
    this.languageId,
    this.storeId,
    this.customerToken,
    this.orderType,
    this.orderStatus,
    this.limit,
    this.offset,
  });

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['storeId'] = storeId;
    data['customerToken'] = customerToken;
    data['orderType'] = orderType;
    data['orderStatus'] = orderStatus;
    data['limit'] = limit;
    data['offset'] = offset;

    return data;
  }
}

