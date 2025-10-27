/// Represents a request to apply or remove a coupon in the cart.
class CartApplyCouponRequest {
  /// Constructor Represents a request to apply or remove a coupon in the cart.
  CartApplyCouponRequest({
    String? websiteId,
    String? storeId,
    String? customerToken,
    String? quoteId,
    String? couponCode,
    int? removeCoupon,
  }) {
    _websiteId = websiteId;
    _storeId = storeId;
    _customerToken = customerToken;
    _quoteId = quoteId;
    _couponCode = couponCode;
    _removeCoupon = removeCoupon;
  }

  /// Creates a CartApplyCouponRequest from a JSON object.
  CartApplyCouponRequest.fromJson(Map<String, dynamic> json) {
    _websiteId = json['websiteId'];
    _storeId = json['storeId'];
    _customerToken = json['customerToken'];
    _quoteId = json['quoteId'];
    _couponCode = json['couponCode'];
    _removeCoupon = json['removeCoupon'];
  }

  String? _websiteId;
  String? _storeId;
  String? _customerToken;
  String? _quoteId;
  String? _couponCode;
  int? _removeCoupon;

  /// Returns a new instance of CartApplyCouponRequest with updated fields.
  CartApplyCouponRequest copyWith({
    String? websiteId,
    String? storeId,
    String? customerToken,
    String? quoteId,
    String? couponCode,
    int? removeCoupon,
  }) =>
      CartApplyCouponRequest(
        websiteId: websiteId ?? _websiteId,
        storeId: storeId ?? _storeId,
        customerToken: customerToken ?? _customerToken,
        quoteId: quoteId ?? _quoteId,
        couponCode: couponCode ?? _couponCode,
        removeCoupon: removeCoupon ?? _removeCoupon,
      );

  /// Website identifier for the request.
  String? get websiteId => _websiteId;

  /// Store identifier for the request.
  String? get storeId => _storeId;

  /// Customer token for the request.
  String? get customerToken => _customerToken;

  /// Quote identifier for the request.
  String? get quoteId => _quoteId;

  /// Coupon code to be applied.
  String? get couponCode => _couponCode;

  /// Flag to indicate if the coupon should be removed.
  int? get removeCoupon => _removeCoupon;

  /// Converts the CartApplyCouponRequest to a JSON object.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['websiteId'] = _websiteId;
    map['storeId'] = _storeId;
    map['customerToken'] = _customerToken;
    map['quoteId'] = _quoteId;
    map['couponCode'] = _couponCode;
    map['removeCoupon'] = _removeCoupon;
    return map;
  }
}
