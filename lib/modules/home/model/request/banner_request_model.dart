/// Model class for banner API request parameters.
class BannerRequestModel {
  /// The language identifier for localization.
  int? languageId;

  /// The customer's cart quote identifier.
  int? quoteId;

  /// The customer's authentication token.
  String? customerToken;

  /// The platform type (e.g., mobile, web).
  String? platform;

  /// The app version.
  String? version;

  /// The selected store identifier.
  int? storeId;

  /// Creates an instance of [BannerRequestModel].
  BannerRequestModel({
    this.languageId,
    this.quoteId,
    this.customerToken,
    this.platform,
    this.version,
    this.storeId,
  });

  /// Converts the model to a JSON map for API request.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['quoteId'] = quoteId;
    data['customerToken'] = customerToken;
    data['platform'] = platform;
    data['version'] = version;
    data['storeId'] = storeId;


    return data;
  }
}

