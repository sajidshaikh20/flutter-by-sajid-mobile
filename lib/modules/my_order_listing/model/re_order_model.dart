/// Represents the response model for a reorder operation.
class ReOrderModel {
  /// Creates an instance of [ReOrderModel].
  ReOrderModel({this.success, this.message, this.cartCount, this.quoteId});

  /// Creates an instance of [ReOrderModel] from a JSON object.
  ReOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    cartCount = json['cartCount'];
    quoteId = json['quoteId'];
  }

  /// Indicates whether the reorder operation was successful.
  bool? success;

  /// Message describing the result of the reorder operation.
  String? message;

  /// Number of items in the cart after reordering.
  int? cartCount;

  /// Unique identifier for the reorder quote.
  String? quoteId;

  /// Converts the [ReOrderModel] instance into a JSON object.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['cartCount'] = cartCount;
    data['quoteId'] = quoteId;
    return data;
  }
}
