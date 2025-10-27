/// A data model representing the request payload for fetching payment methods.
///
/// This model is used when calling the payment methods API to retrieve
/// available payment options for the user.
///
///
/// Example usage:
/// ```dart
/// final request = PaymentMethodRequest(
///   customerToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
///   platform: "android",
///   version: "5.1",
///   languageId: 1,
///   storeId: 1,
/// );
///
/// final json = request.toJson();
/// print(json);
/// ```
class PaymentMethodRequest {
  /// Customer authentication token.
  String? customerToken;

  /// Platform type (e.g., 'android', 'ios').
  String? platform;

  /// Application version.
  String? version;

  /// Language identifier.
  int? languageId;

  /// Store identifier.
  int? storeId;

  /// Creates a new [PaymentMethodRequest] instance.
  PaymentMethodRequest({
    this.customerToken,
    this.platform,
    this.version,
    this.languageId,
    this.storeId,
  });

  /// Creates a [PaymentMethodRequest] instance from a JSON map.
  PaymentMethodRequest.fromJson(Map<String, dynamic> json) {
    customerToken = json['customerToken'];
    platform = json['platform'];
    version = json['version'];
    languageId = json['languageId'];
    storeId = json['storeId'];
  }

  /// Converts this [PaymentMethodRequest] instance into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerToken'] = customerToken;
    data['platform'] = platform;
    data['version'] = version;
    data['languageId'] = languageId;
    data['storeId'] = storeId;
    return data;
  }

  /// Creates a copy of the current [PaymentMethodRequest] with modified values.
  PaymentMethodRequest copyWith({
    String? customerToken,
    String? platform,
    String? version,
    int? languageId,
    int? storeId,
  }) {
    return PaymentMethodRequest(
      customerToken: customerToken ?? this.customerToken,
      platform: platform ?? this.platform,
      version: version ?? this.version,
      languageId: languageId ?? this.languageId,
      storeId: storeId ?? this.storeId,
    );
  }
}
