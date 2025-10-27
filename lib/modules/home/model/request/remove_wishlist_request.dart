/// Represents a request to remove an item from the wishlist
class RemoveWishlistRequest {
  /// Constructor
  RemoveWishlistRequest({
    this.languageId,
    this.customerToken,
    this.sku,
    this.platform,
    this.version,
  });

  /// Factory constructor for creating a new instance
  /// from a map (JSON deserialization)
  factory RemoveWishlistRequest.fromJson(Map<String, dynamic> json) =>
      RemoveWishlistRequest(
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
