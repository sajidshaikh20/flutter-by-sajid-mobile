/// Represents the request for retrieving a wishlist with necessary parameters.
class GetWishListRequest {
  /// Constructs a [GetWishListRequest] with optional parameters.
  GetWishListRequest({
    this.customerToken,
  });

  /// Creates a [GetWishListRequest] from a JSON map.
  GetWishListRequest.fromJson(Map<String, dynamic> json) {
    customerToken = json['customerToken'];
  }
  /// The customer token for authorization.
  String? customerToken;

  /// Converts the [GetWishListRequest] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['customerToken'] = customerToken;
    return data;
  }
}
