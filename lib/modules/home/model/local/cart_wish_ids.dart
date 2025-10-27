import '../../../../utils/exports.dart';

/// Represents a combined list of cart and wishlist items along with cart count.
class CartWishIds extends Equatable {
  /// Constructs a CartWishIds
  const CartWishIds({
    required this.cartList,
    required this.wishList,
    this.cartCount,
  });

  /// List of cart items
  final List<CartWishModel> cartList;

  /// List of wishlist items
  final List<CartWishModel> wishList;

  /// Total count of items in the cart
  final int? cartCount;

  @override
  List<Object?> get props => <Object?>[
        cartList,
        wishList,
        cartCount,
      ];

  /// Creates a copy of this object with updated values for the properties.
  CartWishIds copyWith({
    List<CartWishModel>? cartList,
    List<CartWishModel>? wishList,
    int? cartCount,
  }) =>
      CartWishIds(
        cartList: cartList ?? this.cartList,
        wishList: wishList ?? this.wishList,
        cartCount: cartCount ?? this.cartCount,
      );
}

/// Represents an individual cart or wishlist item with relevant details.
class CartWishModel extends Equatable {
  ///Constructor a Cart wist model
  const CartWishModel({
    required this.productOrEntityId,
    required this.qty,
    required this.originalId,
  });

  /// Creates a [CartWishModel] from a JSON map.
  CartWishModel.fromJson(Map<String, dynamic> json)
      : productOrEntityId = json['id'],
        qty = json['qty'],
        originalId = json['originalId'];

  /// The unique product or entity ID for the item
  final String? productOrEntityId;

  /// The quantity of the item
  final int? qty;

  /// The original ID of the item
  final String? originalId;

  /// Converts the [CartWishModel] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = productOrEntityId;
    data['qty'] = qty;
    data['originalId'] = originalId;
    return data;
  }

  @override
  List<Object?> get props => <Object?>[productOrEntityId, qty, originalId];

  /// Creates a copy of this object with updated values for the properties.
  CartWishModel copyWith({
    String? id,
    int? qty,
    String? itemId,
  }) =>
      CartWishModel(
        productOrEntityId: id ?? productOrEntityId,
        qty: qty ?? this.qty,
        originalId: itemId ?? originalId,
      );
}
