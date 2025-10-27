/// Represents a brand list request
class BrandListRequest {
  /// Constructor
  BrandListRequest({
    this.customerToken,
    this.languageId,
    this.quoteId,
    this.currency,
    this.storeId,
    this.offset,
    this.limit,
  });

  /// Factory constructor for creating a new instance
  /// from a map (JSON deserialization)
  factory BrandListRequest.fromJson(Map<String, dynamic> json) =>
      BrandListRequest(
        customerToken: json['customerToken'] as String?,
        languageId: json['languageId'] as int?,
        quoteId: json['quoteId'] as String?,
        currency: json['currency'] as String?,
        storeId: json['storeId'] as String?,
        offset: json['offset'] as int?,
        limit: json['limit'] as int?,
      );

  /// Customer token
  String? customerToken;

  /// Language Id
  int? languageId;

  /// Quote Id
  String? quoteId;

  /// Currency code
  String? currency;

  /// Store Id
  String? storeId;

  /// Offset for pagination
  int? offset;

  /// Limit for pagination
  int? limit;

  /// Method to convert this class instance into a map (JSON serialization)
  Map<String, dynamic> toJson() => <String, dynamic>{
    'customerToken': customerToken,
    'languageId': languageId,
    'quoteId': quoteId,
    'currency': currency,
    'storeId': storeId,
    'offset': offset,
    'limit': limit,
  };
}
