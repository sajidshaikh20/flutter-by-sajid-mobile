/// A data model representing the request payload for cart checkout operations.
///
/// This model captures all inputs required on the cart page when
/// proceeding with checkout, including address, order type, selected
/// payment method, applied coupon, and any wallet/loyalty usage.
///
/// Example usage:
/// ```dart
/// final request = CartCheckoutRequest(
///   languageId: 1,
///   storeId: 2,
///   customerToken: '...jwt...',
///   quoteId: '480',
///   platform: 'android',
///   version: '5.1',
///   deliveryAddress: 183,
///   orderType: 'delivery',
///   websiteId: 1,
///   paymentMethod: 14,
///   deliveryInstructions: 'Sample Delivery Instructions',
///   couponCode: '1243',
///   timeslot: 1,
///   loyaltyPointsRedeem: 10.0,
///   walletAmount: 10.0,
/// );
///
/// final json = request.toJson();
/// ```
class CartCheckoutRequest {
  /// Creates a [CartCheckoutRequest] with optional fields.
  CartCheckoutRequest({
    this.languageId,
    this.storeId,
    this.customerToken,
    this.quoteId,
    this.platform,
    this.version,
    this.deliveryAddress,
    this.orderType,
    this.websiteId,
    this.paymentMethod,
    this.deliveryInstructions,
    this.couponCode,
    this.timeslot,
    this.loyaltyPointsRedeem,
    this.walletAmount,
  });

  /// Creates a [CartCheckoutRequest] instance from a JSON map.
  factory CartCheckoutRequest.fromJson(Map<String, dynamic> json) =>
      CartCheckoutRequest(
        languageId: json['languageId'] as int?,
        storeId: json['storeId'] as int?,
        customerToken: json['customerToken'] as String?,
        quoteId: json['quoteId'] as String?,
        platform: json['platform'] as String?,
        version: json['version'] as String?,
        deliveryAddress: json['deliveryAddress'] as int?,
        orderType: json['orderType'] as String?,
        websiteId: json['websiteId'] as int?,
        paymentMethod: json['paymentMethod'] as int?,
        deliveryInstructions: json['deliveryInstructions'] as String?,
        couponCode: json['couponCode'] as String?,
        timeslot: json['timeslot'] as int?,
        loyaltyPointsRedeem: (json['loyaltyPointsRedeem'] as num?)?.toDouble(),
        walletAmount: (json['walletAmount'] as num?)?.toDouble(),
      );

  /// The language ID for localization.
  int? languageId;

  /// The store ID for which the order is placed.
  int? storeId;

  /// The customer's authentication token.
  String? customerToken;

  /// The quote ID representing the cart session.
  String? quoteId;

  /// The platform from which the request originates (e.g., 'android', 'ios').
  String? platform;

  /// The application version from which the request originates.
  String? version;

  /// The delivery address ID selected by the customer.
  int? deliveryAddress;

  /// The type of order (e.g., 'delivery' or 'pickup').
  String? orderType;

  /// The website ID associated with the order.
  int? websiteId;

  /// The selected payment method ID.
  int? paymentMethod;

  /// Additional instructions for delivery.
  String? deliveryInstructions;

  /// Applied coupon code, if any.
  String? couponCode;

  /// Selected timeslot ID for delivery.
  int? timeslot;

  /// Amount of loyalty points to redeem.
  double? loyaltyPointsRedeem;

  /// Amount from wallet to use for this order.
  double? walletAmount;

  /// Converts this [CartCheckoutRequest] instance into a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'languageId': languageId,
    'storeId': storeId,
    'customerToken': customerToken,
    'quoteId': quoteId,
    'platform': platform,
    'version': version,
    'deliveryAddress': deliveryAddress,
    'orderType': orderType,
    'websiteId': websiteId,
    'paymentMethod': paymentMethod,
    'deliveryInstructions': deliveryInstructions,
    'couponCode': couponCode,
    'timeslot': timeslot,
    'loyaltyPointsRedeem': loyaltyPointsRedeem,
    'walletAmount': walletAmount,
  };

  /// Returns a copy of this [CartCheckoutRequest] with updated values.
  ///
  /// Any field not provided in [copyWith] will retain its current value.
  CartCheckoutRequest copyWith({
    int? languageId,
    int? storeId,
    String? customerToken,
    String? quoteId,
    String? platform,
    String? version,
    int? deliveryAddress,
    String? orderType,
    int? websiteId,
    int? paymentMethod,
    String? deliveryInstructions,
    String? couponCode,
    int? timeslot,
    double? loyaltyPointsRedeem,
    double? walletAmount,
  }) =>
      CartCheckoutRequest(
        languageId: languageId ?? this.languageId,
        storeId: storeId ?? this.storeId,
        customerToken: customerToken ?? this.customerToken,
        quoteId: quoteId ?? this.quoteId,
        platform: platform ?? this.platform,
        version: version ?? this.version,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
        orderType: orderType ?? this.orderType,
        websiteId: websiteId ?? this.websiteId,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        deliveryInstructions: deliveryInstructions ?? this.deliveryInstructions,
        couponCode: couponCode ?? this.couponCode,
        timeslot: timeslot ?? this.timeslot,
        loyaltyPointsRedeem: loyaltyPointsRedeem ?? this.loyaltyPointsRedeem,
        walletAmount: walletAmount ?? this.walletAmount,
      );
}
