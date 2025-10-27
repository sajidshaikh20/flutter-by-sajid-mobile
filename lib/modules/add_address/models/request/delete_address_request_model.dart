
/// Request model for deleting an address
/// Request model for deleting a customer address.
class DeleteAddressRequestModel {
  /// Token identifying the customer.
  final String customerToken;

  /// Language identifier (e.g., 1 for English, 2 for Arabic).
  final int languageId;

  /// Platform from which the request is made (e.g., "android", "ios").
  final String platform;

  /// App version making the request.
  final String version;

  /// Identifier of the address to delete.
  final String addressId;

  /// Creates a [DeleteAddressRequestModel] instance.
  DeleteAddressRequestModel({
    required this.customerToken,
    required this.languageId,
    required this.platform,
    required this.version,
    required this.addressId,
  });

  /// Creates a [DeleteAddressRequestModel] instance from a JSON map.
  factory DeleteAddressRequestModel.fromJson(Map<String, dynamic> json) {
    return DeleteAddressRequestModel(
      customerToken: json['customerToken'] ?? '',
      languageId: json['languageId'] ?? 1,
      platform: json['platform'] ?? '',
      version: json['version'] ?? '',
      addressId: json['addressId'] ?? '',
    );
  }

  /// Converts this [DeleteAddressRequestModel] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'customerToken': customerToken,
      'languageId': languageId,
      'platform': platform,
      'version': version,
      'addressId': addressId,
    };
  }
}

