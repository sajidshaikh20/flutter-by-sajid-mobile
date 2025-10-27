import '../../../../utils/exports.dart';

/// Response model for cart listing API that includes cart summary and items
class CartDetailsListingResponseModel extends Equatable {
  /// Subtotal amount of the cart
  final double? subTotal;
  
  /// Delivery charge applied to the cart
  final double? deliveryCharge;
  
  /// Loyalty points applied to the cart
  final double? loyaltyPointsApplied;
  
  /// Wallet amount applied to the cart
  final double? walletApplied;
  
  /// Coupon code discount applied to the cart
  final double? couponCodeApplied;
  
  /// Final total amount of the cart
  final double? finalTotal;
  
  /// Total amount saved through discounts
  final double? totalSaved;
  
  /// List of cart items
  final List<ProductListingResponse>? cartItems;
///CartDetailsListingResponseModel
  const CartDetailsListingResponseModel({
    this.subTotal,
    this.deliveryCharge,
    this.loyaltyPointsApplied,
    this.walletApplied,
    this.couponCodeApplied,
    this.finalTotal,
    this.totalSaved,
    this.cartItems,
  });
///fromJson
  factory CartDetailsListingResponseModel.fromJson(Map<String, dynamic> json) {
    return CartDetailsListingResponseModel(
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      deliveryCharge: (json['deliveryCharge'] as num?)?.toDouble(),
      loyaltyPointsApplied: (json['LoyalityPointsApplied'] as num?)?.toDouble(),
      walletApplied: (json['walletApplied'] as num?)?.toDouble(),
      couponCodeApplied: (json['couponCodeApplied'] as num?)?.toDouble(),
      finalTotal: (json['finalTotal'] as num?)?.toDouble(),
      totalSaved: (json['totalSaved'] as num?)?.toDouble(),
      cartItems: json['cart_items'] != null
          ? (json['cart_items'] as List<dynamic>)
              .map((dynamic item) => ProductListingResponse.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
///toJson
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'subTotal': subTotal,
      'deliveryCharge': deliveryCharge,
      'LoyalityPointsApplied': loyaltyPointsApplied,
      'walletApplied': walletApplied,
      'couponCodeApplied': couponCodeApplied,
      'finalTotal': finalTotal,
      'totalSaved': totalSaved,
      'cart_items': cartItems?.map((ProductListingResponse item) => item.toJson()).toList(),
    };
  }
///copyWith
  CartDetailsListingResponseModel copyWith({
    double? subTotal,
    double? deliveryCharge,
    double? loyaltyPointsApplied,
    double? walletApplied,
    double? couponCodeApplied,
    double? finalTotal,
    double? totalSaved,
    List<ProductListingResponse>? cartItems,
  }) {
    return CartDetailsListingResponseModel(
      subTotal: subTotal ?? this.subTotal,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      loyaltyPointsApplied: loyaltyPointsApplied ?? this.loyaltyPointsApplied,
      walletApplied: walletApplied ?? this.walletApplied,
      couponCodeApplied: couponCodeApplied ?? this.couponCodeApplied,
      finalTotal: finalTotal ?? this.finalTotal,
      totalSaved: totalSaved ?? this.totalSaved,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        subTotal,
        deliveryCharge,
        loyaltyPointsApplied,
        walletApplied,
        couponCodeApplied,
        finalTotal,
        totalSaved,
        cartItems,
      ];
}
