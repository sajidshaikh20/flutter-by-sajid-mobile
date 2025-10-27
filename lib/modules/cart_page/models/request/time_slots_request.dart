/// A data model representing the request payload for fetching time slots.
///
/// This model is used when calling the time slots API to retrieve
/// available delivery time slots for the user.
///
///
/// Example usage:
/// ```dart
/// final request = TimeSlotsRequest(
///   customerToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
///   platform: "android",
///   version: "5.1",
///   storeId: 2,
/// );
///
/// final json = request.toJson();
/// print(json);
/// ```
class TimeSlotsRequest {
  /// Customer authentication token.
  String? customerToken;

  /// Platform type (e.g., 'android', 'ios').
  String? platform;

  /// Application version.
  String? version;

  /// Store identifier.
  int? storeId;
/// language id
  int? languageId;

  /// Creates a new [TimeSlotsRequest] instance.
  TimeSlotsRequest({
    this.customerToken,
    this.platform,
    this.version,
    this.storeId,
    this.languageId
  });

  /// Creates a [TimeSlotsRequest] instance from a JSON map.
  TimeSlotsRequest.fromJson(Map<String, dynamic> json) {
    customerToken = json['customerToken'];
    platform = json['platform'];
    version = json['version'];
    storeId = json['storeId'];
    languageId=json['languageId'];
  }

  /// Converts this [TimeSlotsRequest] instance into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerToken'] = customerToken;
    data['platform'] = platform;
    data['version'] = version;
    data['storeId'] = storeId;
    data['languageId'] = languageId;
    return data;
  }

  /// Creates a copy of the current [TimeSlotsRequest] with modified values.
  TimeSlotsRequest copyWith({
    String? customerToken,
    String? platform,
    String? version,
    int? storeId,
    int? languageId
  }) {
    return TimeSlotsRequest(
      customerToken: customerToken ?? this.customerToken,
      platform: platform ?? this.platform,
      version: version ?? this.version,
      storeId: storeId ?? this.storeId,
      languageId: languageId ?? this.languageId
    );
  }
}
