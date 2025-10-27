/// A model class for applying coupon requests.
/// Contains all necessary data to apply a coupon to an order.
class ApplyCouponRequestModel {
  /// The language ID for localization.
  int? languageId;

  /// The customer's authentication token.
  String? customerToken;

  /// The coupon code to be applied.
  String? couponcode;

  /// The platform from which the request is made.
  String? platform;

  /// The version of the application making the request.
  String? version;

  /// The store ID where the order is placed.
  int? storeId;

  /// The order ID to which the coupon should be applied.
  int? orderId;

  /// Creates an [ApplyCouponRequestModel] instance.
  ///
  /// All parameters are optional and can be null.
  ApplyCouponRequestModel({
    this.languageId,
    this.customerToken,
    this.couponcode,
    this.platform,
    this.version,
    this.storeId,
    this.orderId,
  });

  /// Converts the model to a JSON map for API requests.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['customerToken'] = customerToken;
    data['couponcode'] = couponcode;
    data['platform'] = platform;
    data['version'] = version;
    data['storeId'] = storeId;
    data['orderId'] = orderId;

    return data;
  }
}

