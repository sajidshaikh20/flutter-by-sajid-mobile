/// Represents a product listing request with filters
class ProductListingRequestModel {
  /// Constructor
  ProductListingRequestModel({
    this.customerToken,
    this.languageId,
    this.platform,
    this.version,
    this.typeId,
    this.type,
    this.query,
    this.sorting,
    this.filterData,
    this.storeId,
    this.limit,
    this.offset,
    this.quoteId,
  });

  /// Factory constructor for creating a new instance
  /// from a map (JSON deserialization)
  factory ProductListingRequestModel.fromJson(Map<String, dynamic> json) =>
      ProductListingRequestModel(
        customerToken: json['customerToken'] as String?,
        languageId: json['languageId'],
        platform: json['platform'] as String?,
        version: json['version'] as String?,
        typeId: json['typeId'] as int?,
        type: json['type'] as String?,
        query: json['query'] as String?,
        sorting: json['sorting'] as String?,
        storeId: json['storeId'] as String?, // ✅ added storeId
        limit: json['limit'] as int?,
        offset: json['offset'] as int?,
        quoteId: json['quoteId'],
        filterData: json['filterData'] != null
            ? (json['filterData'] as List<dynamic>)
            .map((dynamic item) =>
            FilterData.fromJson(item as Map<String, dynamic>))
            .toList()
            : null,
      );

  /// Customer token
  String? customerToken;

  /// Language Id
  int? languageId;

  /// Platform (android/ios)
  String? platform;

  /// App version
  String? version;

  /// Type Id (category/brand ID)
  int? typeId;

  /// Type (category/brand)
  String? type;

  /// Search query
  String? query;

  /// Sorting option
  String? sorting;

  /// Store Id
  String? storeId;

  /// Limit for pagination
  int? limit;

  /// Offset for pagination
  int? offset;

  /// Quote Id
  dynamic quoteId;

  /// Filter data
  List<FilterData>? filterData;

  /// Method to convert this class instance into a map (JSON serialization)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{
      'customerToken': customerToken,
      'languageId': languageId,
      'platform': platform,
      'version': version,
      'typeId': typeId,
      'type': type,
      'query': query,
      'sorting': sorting,
      'storeId': storeId,
      'limit': limit,
      'offset': offset,
      'quoteId': quoteId,
    };

    if (filterData != null) {
      map['filterData'] = filterData!.map((FilterData e) => e.toJson()).toList();
    }

    return map;
  }
}

/// Represents filter data for product listing
class FilterData {
  /// Constructor
  FilterData({
    this.code,
    this.minPrice,
    this.maxPrice,
    this.options,
  });

  /// Factory constructor for creating a new instance
  /// from a map (JSON deserialization)
  factory FilterData.fromJson(Map<String, dynamic> json) => FilterData(
    code: json['code'] as String?,
    minPrice: (json['min_price'] as num?)?.toDouble(),
    maxPrice: (json['max_price'] as num?)?.toDouble(),
    options: json['options'] != null
        ? (json['options'] as List<dynamic>)
        .map((dynamic item) =>
        FilterOption.fromJson(item as Map<String, dynamic>))
        .toList()
        : null,
  );

  /// Filter code
  String? code;

  /// Minimum price
  double? minPrice;

  /// Maximum price
  double? maxPrice;

  /// Filter options
  List<FilterOption>? options;

  /// Method to convert this class instance into a map (JSON serialization)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{
      'code': code,
      'min_price': minPrice,
      'max_price': maxPrice,
    };

    if (options != null) {
      map['options'] = options!.map((FilterOption e) => e.toJson()).toList();
    }

    return map;
  }
}

/// Represents filter option for product listing
class FilterOption {
  /// Constructor
  FilterOption({
    this.id,
    this.count,
  });

  /// Factory constructor for creating a new instance
  /// from a map (JSON deserialization)
  factory FilterOption.fromJson(Map<String, dynamic> json) => FilterOption(
    id: json['id'] as String?,
    count: json['count'] as int?,
  );

  /// Option id
  String? id;

  /// Option count
  int? count;

  /// Method to convert this class instance into a map (JSON serialization)
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'count': count,
  };
}
