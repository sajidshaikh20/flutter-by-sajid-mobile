/// A data model representing the request payload for retrieving customer addresses.
///
/// This model is used to pass parameters when making API calls related to
/// fetching the address list of a customer with pagination support.
///
/// Example usage:
/// ```dart
/// final request = AddressListRequestModel(
///   customerToken: "abcd1234",
///   languageId: 1,
///   platform: "android",
///   version: "5.1",
///   limit: 8,
///   offset: 0,
/// );
///
/// final json = request.toJson();
/// print(json);
/// ```
class AddressListRequestModelDukkan {

  /// The authentication token for the customer.
  String? customerToken;

  /// The selected language ID.
  int? languageId;

  /// The platform making the request (e.g., `android`, `ios`, `web`).
  String? platform;

  /// The app version.
  String? version;

  /// Number of items per page (pagination).
  int? limit;

  /// Offset for pagination (starting index).
  int? offset;

  /// Creates a new [AddressListRequestModelDukkan] instance.
  AddressListRequestModelDukkan({
    this.customerToken,
    this.languageId,
    this.platform,
    this.version,
    this.limit,
    this.offset,
  });

  /// Creates an [AddressListRequestModelDukkan] instance from a JSON map.
  AddressListRequestModelDukkan.fromJson(Map<String, dynamic> json) {
    customerToken = json['customerToken'];
    languageId = json['languageId'];
    platform = json['platform'];
    version = json['version'];
    limit = json['limit'];
    offset = json['offset'];
  }

  /// Converts this [AddressListRequestModelDukkan] instance into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerToken'] = customerToken;
    data['languageId'] = languageId;
    data['platform'] = platform;
    data['version'] = version;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }
}
