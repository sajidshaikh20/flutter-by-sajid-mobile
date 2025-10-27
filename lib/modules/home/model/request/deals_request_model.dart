/// Model class for deals API request parameters.
class DealsRequestModel {
  /// The language identifier for localization.
  int? languageId;

  /// The customer's cart quote identifier.
  dynamic quoteId;

  /// The customer's authentication token.
  String? customerToken;

  /// The currency code.
  String? currency;

  /// The platform type (e.g., mobile, web).
  String? platform;

  /// The app version.
  String? version;

  /// The tag name for filtering deals.
  String? tagName;

  /// The screen identifier.
  String? screen;

  /// The selected store identifier.
  int? storeId;

  /// The sorting criteria for deals.
  String? sorting;

  /// The maximum number of deals to fetch.
  int? limit;

  /// The offset for pagination.
  int? offset;

  /// Additional filter data for deals.
  dynamic filterData;

  /// Creates an instance of [DealsRequestModel].
  DealsRequestModel({
    this.languageId,
    this.quoteId,
    this.customerToken,
    this.currency,
    this.platform,
    this.version,
    this.storeId,
    this.tagName,
    this.screen,
    this.sorting,
    this.limit,
    this.offset,
    this.filterData,
  });

  /// Converts the model to a JSON map for API request.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['quoteId'] = quoteId;
    data['customerToken'] = customerToken;
    data['currency'] = currency;
    data['platform'] = platform;
    data['version'] = version;
    data['storeId'] = storeId;
    data['screen'] = screen;
    data['tag_name'] = tagName;
    data['sorting'] = sorting;
    data['limit'] = limit;
    data['offset'] = offset;

    if (filterData != null) {
      data['filterData'] = filterData;
    }

    return data;
  }
}

