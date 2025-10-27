/// Model class for wishlist to cart request parameters.
class WishlistToCartRequest { // Quantity of the product

  /// Creates an instance of [WishlistToCartRequest].
  WishlistToCartRequest({
    this.websiteId,
    this.storeId,
    this.customerToken,
    this.id,
    this.itemId,
    this.qty,
  });

  /// Creates a [WishlistToCartRequest] instance from a JSON map.
  factory WishlistToCartRequest.fromJson(Map<String, dynamic> json) =>
      WishlistToCartRequest(
        websiteId: json['websiteId'],
        storeId: json['storeId'],
        customerToken: json['customerToken'],
        id: json['id'],
        itemId: json['itemId'],
        qty: json['qty'],
      );
  /// The website identifier.
  String? websiteId;

  /// The store identifier.
  String? storeId;

  /// The customer authentication token.
  String? customerToken;

  /// The wishlist item identifier.
  String? id;

  /// The product item identifier.
  String? itemId;

  /// The quantity of the product to move to cart.
  String? qty;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'websiteId': websiteId,
        'storeId': storeId,
        'customerToken': customerToken,
        'id': id,
        'itemId': itemId,
        'qty': qty,
      };
}
