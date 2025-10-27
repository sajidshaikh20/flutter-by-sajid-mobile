/// Model class for trending products request parameters.
class TrendingProductsRequestModel {
  /// The customer authentication token.
  final String? customerToken;

  /// The platform from which the request is made.
  final String? platform;

  /// The application version.
  final String? version;

  /// The store identifier.
  final int? storeId;

  /// The language identifier.
  final int? languageId;

  /// The maximum number of results to return.
  final int? limit;

  /// The number of results to skip.
  final int? offset;

  /// The sorting criteria for results.
  final String? sorting;

  /// The filter data to apply.
  final dynamic filterData;

  /// The quote/cart identifier.
  final dynamic quoteId;

  /// Creates an instance of [TrendingProductsRequestModel].
  TrendingProductsRequestModel({
    this.customerToken,
    this.platform,
    this.version,
    this.storeId,
    this.languageId,
    this.limit,  // Initialize limit
    this.offset,  // Initialize offset
    this.sorting,  // Initialize sorting
    this.filterData,  // Initialize filterData
    this.quoteId,  // Initialize quoteId
  });

  /// Creates a [TrendingProductsRequestModel] instance from a JSON map.
  factory TrendingProductsRequestModel.fromJson(Map<String, dynamic> json) => TrendingProductsRequestModel(
    customerToken: json["customerToken"],
    platform: json["platform"],
    version: json["version"],
    storeId: json["storeId"],
    languageId: json["languageId"],
    limit: json["limit"],  // Deserialize limit
    offset: json["offset"],  // Deserialize offset
    sorting: json["sorting"],  // Deserialize sorting
    filterData: json["filterData"],  // Deserialize filterData
    quoteId: json["quoteId"],  // Deserialize quoteId
  );

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "customerToken": customerToken,
    "platform": platform,
    "version": version,
    "storeId": storeId,
    "languageId": languageId,
    "limit": limit,  // Serialize limit
    "offset": offset,  // Serialize offset
    "sorting": sorting,  // Serialize sorting
    "quoteId": quoteId,  // Serialize quoteId
    if (filterData != null) "filterData": filterData,  // Serialize filterData if not null
  };
}
