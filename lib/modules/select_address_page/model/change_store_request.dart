// To parse this JSON data, do
//
//     final changeStoreRequest = changeStoreRequestFromJson(jsonString);

/// Model class for change store request parameters.
class ChangeStoreRequest {
  /// The customer's authentication token.
  final String? customerToken;

  /// The language ID for localization.
  final int? languageId;

  /// The quote/cart ID.
  final dynamic quoteId;

  /// The platform from which the request is made.
  final String? platform;

  /// The app version.
  final String? version;

  /// The currency code.
  final String? currency;

  /// The address ID for delivery.
  final int? addressId;

  /// The store ID to change to.
  final int? storeId;

  /// The order method (delivery/pickup).
  final String? orderMethod;

  /// Creates a new instance of [ChangeStoreRequest].
  ///
  /// All parameters are optional and can be null.
  ChangeStoreRequest({
    this.customerToken,
    this.languageId,
    this.quoteId,
    this.platform,
    this.version,
    this.currency,
    this.addressId,
    this.storeId,
    this.orderMethod,
  });

  ///copy with
  ChangeStoreRequest copyWith({
    String? customerToken,
    int? languageId,
    dynamic quoteId,
    String? platform,
    String? version,
    String? currency,
    int? addressId,
    int? storeId,
    String? orderMethod,
  }) =>
      ChangeStoreRequest(
        customerToken: customerToken ?? this.customerToken,
        languageId: languageId ?? this.languageId,
        quoteId: quoteId ?? this.quoteId,
        platform: platform ?? this.platform,
        version: version ?? this.version,
        currency: currency ?? this.currency,
        addressId: addressId ?? this.addressId,
        storeId: storeId ?? this.storeId,
        orderMethod: orderMethod ?? this.orderMethod,
      );

  ///from json
  factory ChangeStoreRequest.fromJson(Map<String, dynamic> json) =>
      ChangeStoreRequest(
        customerToken: json["customerToken"],
        languageId: json["languageId"],
        quoteId: json["quoteId"],
        platform: json["platform"],
        version: json["version"],
        currency: json["currency"],
        addressId: json["addressId"],
        storeId: json["storeId"],
        orderMethod: json["orderMethod"],
      );

  ///to json
  Map<String, dynamic> toJson() => <String, dynamic>{
        "customerToken": customerToken,
        "languageId": languageId,
        "quoteId": quoteId,
        "platform": platform,
        "version": version,
        "currency": currency,
        "addressId": addressId,
        "storeId": storeId,
        "orderMethod": orderMethod,
      };
}
