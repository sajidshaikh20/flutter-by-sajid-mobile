/// Model class for category API request parameters.
class CategoryRequestModel {
  /// The language identifier for localization.
  int? languageId;

  //As per discussion with backend team we remove this field
 // String? quoteId;

  /// The customer's authentication token.
  String? customerToken;

  /// The currency code.
  String? currency;

  /// The platform type (e.g., mobile, web).
  String? platform;

  /// The app version.
  String? version;

  /// The selected store identifier.
  int? storeId;

  /// The maximum number of categories to fetch.
  int? limit;

  /// The offset for pagination.
  int? offset;

  /// Creates an instance of [CategoryRequestModel].
  CategoryRequestModel({
    this.languageId,
    //this.quoteId,
    this.customerToken,
    this.currency,
    this.platform,
    this.version,
    this.storeId,
    this.limit,
    this.offset,
  });

  /// Converts the model to a JSON map for API request.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
   // data['quoteId'] = quoteId;
    data['customerToken'] = customerToken;
    data['currency'] = currency;
    data['platform'] = platform;
    data['version'] = version;
    data['storeId'] = storeId;
    data['limit'] = limit;
    data['offset'] = offset;

    return data;
  }
}

