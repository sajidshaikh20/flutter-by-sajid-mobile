/// A data model representing the request payload for cart operations.
///
/// This model is used when performing various cart operations from the API,
/// including website info, store details, customer authentication, and
/// platform-specific information.
///
/// Supports serialization via [toJson] and deserialization via [].
///
/// Example usage:
/// ```dart
/// final request = CartOperationRequest(
///   websiteId: 1,
///   storeId: 122,
///   customerToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
///   quoteId: "427",
///   platform: "android",
///   version: "5.1",
/// );
///
/// final json = request.toJson();
/// print(json);
/// ```
class CartListingRequest {
  /// Website identifier in a multi-website setup.
  int? websiteId;

  /// Store identifier.
  int? storeId;

  /// Customer authentication token.
  String? customerToken;

  /// Unique quote/cart ID.
  dynamic quoteId;

  /// Platform type (e.g., 'android', 'ios').
  String? platform;

  /// Application version.
  String? version;


  /// Application languageId.
  int? languageId;

  /// Creates a new [CartListingRequest] instance.
  CartListingRequest({
    this.websiteId,
    this.storeId,
    this.customerToken,
    this.quoteId,
    this.platform,
    this.version,
    this.languageId
  });

  /// Creates a [CartListingRequest] instance from a JSON map.
  CartListingRequest.fromJson(Map<String, dynamic> json) {
    websiteId = json['websiteId'];
    storeId = json['storeId'];
    customerToken = json['customerToken'];
    quoteId = json['quoteId'];
    platform = json['platform'];
    version = json['version'];
    languageId =json['languageId'];
  }

  /// Converts this [CartListingRequest] instance into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['websiteId'] = websiteId;
    data['storeId'] = storeId;
    data['customerToken'] = customerToken;
    data['quoteId'] = quoteId;
    data['platform'] = platform;
    data['version'] = version;
    data['languageId'] = languageId;

    return data;
  }

  /// Creates a copy of the current [CartListingRequest] with modified values.
  CartListingRequest copyWith({
    int? websiteId,
    int? storeId,
    String? customerToken,
    int? quoteId,
    String? platform,
    String? version,
    int? languageId
  }) {
    return CartListingRequest(
      websiteId: websiteId ?? this.websiteId,
      storeId: storeId ?? this.storeId,
      customerToken: customerToken ?? this.customerToken,
      quoteId: quoteId ?? this.quoteId,
      platform: platform ?? this.platform,
      version: version ?? this.version,
      languageId: languageId?? this.languageId
    );
  }
}
