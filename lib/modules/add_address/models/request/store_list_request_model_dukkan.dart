/// A data model representing the request payload for retrieving
/// a list of stores based on customer, location, and order method.
///
/// This model is used to pass parameters when making API calls related to
/// fetching available stores for the customer with pagination support.
///
/// Example usage:
/// ```dart
/// final request = StoreListRequestModelDukkan(
///   customerToken: "abcd1234",
///   languageId: 1,
///   platform: "android",
///   version: "5.1",
///   addressId: 91218,
///   orderMethod: "pickUp",
///   lat: "19.1196",
///   lang: "72.905",
///   limit: 8,
///   offset: 0,
/// );
///
/// final json = request.toJson();
/// print(json);
/// ```
class StoreListRequestModelDukkan {
  /// The authentication token for the customer.
  String? customerToken;

  /// The selected language ID.
  int? languageId;

  /// The platform making the request (e.g., `android`, `ios`, `web`).
  String? platform;

  /// The app version.
  String? version;

  /// The address ID of the customer (if applicable).
  int? addressId;

  /// The method of ordering (e.g., `pickUp`, `delivery`).
  String? orderMethod;

  /// The latitude of the customer's location.
  String? lat;

  /// The longitude of the customer's location.
  String? lang;

  /// Number of items per page (pagination).
  int? limit;

  /// Offset for pagination (starting index).
  int? offset;

  /// Creates a new [StoreListRequestModelDukkan] instance.
  StoreListRequestModelDukkan({
    this.customerToken,
    this.languageId,
    this.platform,
    this.version,
    this.addressId,
    this.orderMethod,
    this.lat,
    this.lang,
    this.limit,
    this.offset,
  });

  /// Creates an [StoreListRequestModelDukkan] instance from a JSON map.
  StoreListRequestModelDukkan.fromJson(Map<String, dynamic> json) {
    customerToken = json['customerToken'];
    languageId = json['languageId'];
    platform = json['platform'];
    version = json['version'];
    addressId = json['addressId'];
    orderMethod = json['orderMethod'];
    lat = json['lat'];
    lang = json['lang'];
    limit = json['limit'];
    offset = json['offset'];
  }

  /// Converts this [StoreListRequestModelDukkan] instance into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerToken'] = customerToken;
    data['languageId'] = languageId;
    data['platform'] = platform;
    data['version'] = version;
    data['addressId'] = addressId;
    data['orderMethod'] = orderMethod;
    data['lat'] = lat;
    data['lang'] = lang;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }
}
