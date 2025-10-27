/// Represents the response model for user loyalty points information.
///
/// Example JSON:
/// ```json
/// {
///   "total_loyalty_points": 100,
///   "total_user_amount_for_point": 10,
///   "orderStatus": true,
///   "loyalityPoints": false,
///   "promotionOffers": false,
///   "my_order_counts": 6,
///   "my_wallet": 0.0
/// }
/// ```
library;

/// Model class for loyalty points response data.
class LoyaltyPointsResponseModel {
  /// Creates an instance of [LoyaltyPointsResponseModel].
  ///
  /// - [totalLoyaltyPoints]: The total loyalty points of the user.
  /// - [totalUserAmountForPoint]: The total amount spent to earn loyalty points.
  /// - [orderStatus]: Indicates whether the order functionality is active.
  /// - [loyalityPoints]: Whether loyalty points are currently enabled.
  /// - [promotionOffers]: Whether promotional offers are active.
  /// - [myOrderCounts]: The total number of orders made by the user.
  /// - [myWallet]: The current wallet balance of the user.
  LoyaltyPointsResponseModel({
    num? totalLoyaltyPoints,
    num? totalUserAmountForPoint,
    bool? orderStatus,
    bool? loyalityPoints,
    bool? promotionOffers,
    num? myOrderCounts,
    double? myWallet,
  }) {
    _totalLoyaltyPoints = totalLoyaltyPoints;
    _totalUserAmountForPoint = totalUserAmountForPoint;
    _orderStatus = orderStatus;
    _loyalityPoints = loyalityPoints;
    _promotionOffers = promotionOffers;
    _myOrderCounts = myOrderCounts;
    _myWallet = myWallet;
  }

  /// Creates an instance of [LoyaltyPointsResponseModel] from JSON data.
  ///
  /// The [json] parameter should contain keys matching the expected response fields.
  LoyaltyPointsResponseModel.fromJson(Map<String, dynamic> json) {
    _totalLoyaltyPoints = json['total_loyalty_points'] as num?;
    _totalUserAmountForPoint = json['total_user_amount_for_point'] as num?;
    _orderStatus = json['orderStatus'] as bool? ?? false;
    _loyalityPoints = json['loyalityPoints'] as bool? ?? false;
    _promotionOffers = json['promotionOffers'] as bool? ?? false;
    _myOrderCounts = json['my_order_counts'] as num? ?? 0;
    _myWallet = (json['my_wallet'] as num? ?? 0).toDouble();
  }

  num? _totalLoyaltyPoints;
  num? _totalUserAmountForPoint;
  bool? _orderStatus;
  bool? _loyalityPoints;
  bool? _promotionOffers;
  num? _myOrderCounts;
  double? _myWallet;

  /// Returns the total loyalty points of the user.
  num? get totalLoyaltyPoints => _totalLoyaltyPoints;

  /// Returns the total amount spent by the user to earn points.
  num? get totalUserAmountForPoint => _totalUserAmountForPoint;

  /// Returns the order status.
  bool? get orderStatus => _orderStatus;

  /// Returns whether loyalty points are enabled.
  bool? get loyalityPoints => _loyalityPoints;

  /// Returns whether promotion offers are enabled.
  bool? get promotionOffers => _promotionOffers;

  /// Returns the total number of orders placed by the user.
  num? get myOrderCounts => _myOrderCounts;

  /// Returns the current wallet balance of the user.
  double? get myWallet => _myWallet;

  /// Creates a copy of the current [LoyaltyPointsResponseModel] with updated values.
  ///
  /// If a value is not provided, the existing one is retained.
  LoyaltyPointsResponseModel copyWith({
    num? totalLoyaltyPoints,
    num? totalUserAmountForPoint,
    bool? orderStatus,
    bool? loyalityPoints,
    bool? promotionOffers,
    num? myOrderCounts,
    double? myWallet,
  }) =>
      LoyaltyPointsResponseModel(
        totalLoyaltyPoints: totalLoyaltyPoints ?? _totalLoyaltyPoints,
        totalUserAmountForPoint:
        totalUserAmountForPoint ?? _totalUserAmountForPoint,
        orderStatus: orderStatus ?? _orderStatus,
        loyalityPoints: loyalityPoints ?? _loyalityPoints,
        promotionOffers: promotionOffers ?? _promotionOffers,
        myOrderCounts: myOrderCounts ?? _myOrderCounts,
        myWallet: myWallet ?? _myWallet,
      );

  /// Converts this [LoyaltyPointsResponseModel] instance into a JSON map.
  ///
  /// Useful for encoding or API requests.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['total_loyalty_points'] = _totalLoyaltyPoints;
    map['total_user_amount_for_point'] = _totalUserAmountForPoint;
    map['orderStatus'] = _orderStatus;
    map['loyalityPoints'] = _loyalityPoints;
    map['promotionOffers'] = _promotionOffers;
    map['my_order_counts'] = _myOrderCounts;
    map['my_wallet'] = _myWallet;
    return map;
  }
}
