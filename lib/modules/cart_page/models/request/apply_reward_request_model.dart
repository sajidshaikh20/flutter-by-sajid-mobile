/// Model class representing a request to apply a reward or coupon to an order.
///
/// This model is typically used when sending reward or coupon information
/// to the backend API.
class ApplyRewardRequestModel {
  /// The language ID for localization.
  int? languageId;

  /// The customer's authentication token.
  String? customerToken;

  /// The ID of the selected reward.
  int? selectedReward;

  /// The coupon code applied, if any.
  String? couponcode;

  /// The platform from which the request originates (e.g., Android, iOS).
  String? platform;

  /// The app version from which the request originates.
  String? version;

  /// The ID of the store for which the reward is applied.
  int? storeId;

  /// The order ID for which the reward or coupon is applied.
  int? orderId;

  /// Creates an [ApplyRewardRequestModel] instance.
  ///
  /// All fields are optional and can be set via named parameters.
  ApplyRewardRequestModel({
    this.languageId,
    this.customerToken,
    this.selectedReward,
    this.couponcode,
    this.platform,
    this.version,
    this.storeId,
    this.orderId,
  });

  /// Converts this model into a JSON-compatible map.
  ///
  /// Useful for sending the data in an API request.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['customerToken'] = customerToken;
    data['selectedReward'] = selectedReward;
    data['couponcode'] = couponcode;
    data['platform'] = platform;
    data['version'] = version;
    data['storeId'] = storeId;
    data['orderId'] = orderId;

    return data;
  }
}
