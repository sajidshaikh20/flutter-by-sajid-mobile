/// Model class for search request parameters.
class SearchRequestModel {
  /// Aggregation parameters for search.
  final String? aggs;

  /// Filter data for refining search results.
  final String? filterData;

  /// The search query string.
  final String? query;

  /// Number of results to return.
  final String? size;

  /// Starting index for pagination.
  final String? start;

  /// Store identifier for filtering.
  final String? store;

  /// Website identifier.
  final String? website;

  /// Creates a new instance of [SearchRequestModel].
  ///
  /// All parameters are optional and can be null.
  SearchRequestModel({
    this.aggs,
    this.filterData,
    this.query,
    this.size,
    this.start,
    this.store,
    this.website,
  });

  /// Creates a [SearchRequestModel] instance from a JSON map.
  factory SearchRequestModel.fromJson(Map<String, dynamic> json) {
    return SearchRequestModel(
      aggs: json['aggs'] as String?,
      filterData: json['filterData'] as String?,
      query: json['query'] as String?,
      size: json['size'] as String?,
      start: json['start'] as String?,
      store: json['store'] as String?,
      website: json['website'] as String?,
    );
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'aggs': aggs,
      'filterData': filterData,
      'query': query,
      'size': size,
      'start': start,
      'store': store,
      'website': website,
    };
  }

  /// Creates a copy of this [SearchRequestModel] with optional new values.
  SearchRequestModel copyWith({
    String? aggs,
    String? filterData,
    String? query,
    String? size,
    String? start,
    String? store,
    String? website,
  }) {
    return SearchRequestModel(
      aggs: aggs ?? this.aggs,
      filterData: filterData ?? this.filterData,
      query: query ?? this.query,
      size: size ?? this.size,
      start: start ?? this.start,
      store: store ?? this.store,
      website: website ?? this.website,
    );
  }
}
