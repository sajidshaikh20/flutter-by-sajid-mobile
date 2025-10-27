/// Represents a wishlist request for the new API structure
class AddWishlistRequest {
  /// Constructor
  AddWishlistRequest({
    this.languageId,
    this.customerToken,
    this.sku,
    this.platform,
    this.version,
  });

  /// Factory constructor for creating a new instance
  /// from a map (JSON deserialization)
  factory AddWishlistRequest.fromJson(Map<String, dynamic> json) =>
      AddWishlistRequest(
        languageId: json['languageId'],
        customerToken: json['customerToken'],
        sku: json['sku'],
        platform: json['platform'],
        version: json['version'],
      );

  /// Language ID
  int? languageId;

  /// Customer token
  String? customerToken;

  /// Product SKU
  String? sku;

  /// Platform (android/ios)
  String? platform;

  /// App version
  String? version;

  /// Method to convert this class instance into a map (JSON serialization)
  Map<String, dynamic> toJson() => <String, dynamic>{
        'languageId': languageId,
        'customerToken': customerToken,
        'sku': sku,
        'platform': platform,
        'version': version,
      };
}
