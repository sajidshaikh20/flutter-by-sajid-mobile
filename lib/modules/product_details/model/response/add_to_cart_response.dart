/// Model class for add to cart response data.
class AddToCartModel {
  /// Creates an instance of [AddToCartModel].
  AddToCartModel({
    this.success,
    this.message,
    this.itemId,
    this.quoteId,
    this.cartCount,
  });

  /// Creates an [AddToCartModel] instance from a JSON map.
  AddToCartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    itemId = json['itemId'];
    quoteId = json['quoteId'] == null ? '' : json['quoteId'].toString();
    cartCount = json['cartCount'];
  }

  /// Indicates whether the add to cart operation was successful.
  bool? success;

  /// Response message from the server.
  String? message;

  /// The unique item identifier in the cart.
  String? itemId;

  /// The quote/cart identifier.
  String? quoteId;

  /// The updated cart count after adding the item.
  int? cartCount;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['itemId'] = itemId;
    data['quoteId'] = quoteId;
    data['cartCount'] = cartCount;
    return data;
  }
}
