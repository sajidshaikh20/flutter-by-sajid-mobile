
/// Represents the response model for cart operations (add, update, remove).
/// This model contains the essential information returned after cart operations.
class CartOperationResponseModel {
  /// Creates a new instance of [CartOperationResponseModel].
  CartOperationResponseModel({
    this.quoteId,
    this.cartCount,
  });

  /// Creates a new instance of [CartOperationResponseModel] from a JSON map.
  CartOperationResponseModel.fromJson(Map<String, dynamic> json) {
    quoteId = json['quoteId']?.toString();
    cartCount = json['cartCount'];
  }

  /// The unique quote ID for the cart.
  /// This identifier is used to track the cart session.
  String? quoteId;

  /// The total count of items in the cart.
  /// This represents the number of items currently in the cart.
  int? cartCount;

  /// Creates a copy of this [CartOperationResponseModel] with the option to override specific fields.
  CartOperationResponseModel copyWith({
    String? quoteId,
    int? cartCount,
  }) {
    return CartOperationResponseModel(
      quoteId: quoteId ?? this.quoteId,
      cartCount: cartCount ?? this.cartCount,
    );
  }

  /// Converts the [CartOperationResponseModel] object to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quoteId'] = quoteId;
    data['cartCount'] = cartCount;
    return data;
  }

  @override
  String toString() {
    return 'CartOperationResponseModel(quoteId: $quoteId, cartCount: $cartCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartOperationResponseModel &&
        other.quoteId == quoteId &&
        other.cartCount == cartCount;
  }

  @override
  int get hashCode => quoteId.hashCode ^ cartCount.hashCode;
}
