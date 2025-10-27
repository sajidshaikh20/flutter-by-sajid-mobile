/// Model class for update cart response data.
class UpdateCartModel {

  /// Creates an instance of [UpdateCartModel].
  UpdateCartModel({
    this.success,
    this.message,
    this.quoteId,
    this.cartCount,
    this.itemId,
  });

  /// Creates an [UpdateCartModel] instance from a JSON map.
  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    quoteId = json['quoteId'];
    itemId = json['itemId'];

    cartCount = json['cartCount'];
  }
  /// Indicates whether the update cart operation was successful.
  bool? success;

  /// Response message from the server.
  String? message;

  /// The quote/cart identifier.
  String? quoteId;

  /// The unique item identifier in the cart.
  String? itemId;

  /// The updated cart count after the operation.
  int? cartCount;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['quoteId'] = quoteId;
    data['cartCount'] = cartCount;
    data['itemId'] = itemId;

    return data;
  }
}
