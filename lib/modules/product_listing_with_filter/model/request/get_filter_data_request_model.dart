/// Request model for getting filter data
class GetFilterDataRequestModel {
  /// Constructor for GetFilterDataRequestModel
  GetFilterDataRequestModel({
    required this.customerToken,
    required this.languageId,
    required this.platform,
    required this.version,
    required this.currency,
    required this.storeId,
    this.typeId,
    this.tagName,
    this.type,
    this.productSku
  });

  /// Customer token for authentication
  final String? customerToken;

  /// Language ID for localization
  final int languageId;

  /// Quote ID for cart operations

  /// Platform (android/ios)
  final String platform;

  /// App version
  final String version;

  /// Currency code
  final String currency;

  /// Store ID
  final int storeId;

  /// Optional type ID
  final int? typeId;

  /// Optional tag name
  final String? tagName;

  /// Optional type (category/brand)
  final String? type;

  /// Optional product SKU for filtering
  final String? productSku;

  /// Converts the model to JSON for API request
  Map<String, dynamic> toJson() => <String, dynamic>{
    'customerToken': customerToken,
    'languageId': languageId,
    'platform': platform,
    'version': version,
    'currency': currency,
    'storeId': storeId,
    if (typeId != null) 'typeId': typeId,
    if (tagName != null) 'tag_name': tagName,
    if (type != null) 'type': type,
    if (productSku != null) 'productSku': productSku,
  };

  /// Creates a copy of the model with optional modifications
  GetFilterDataRequestModel copyWith({
    String? customerToken,
    int? languageId,
    String? platform,
    String? version,
    String? currency,
    int? storeId,
    int? typeId,
    String? tagName,
    String? type,
    String? productSku,
  }) =>
      GetFilterDataRequestModel(
        customerToken: customerToken ?? this.customerToken,
        languageId: languageId ?? this.languageId,
        platform: platform ?? this.platform,
        version: version ?? this.version,
        currency: currency ?? this.currency,
        storeId: storeId ?? this.storeId,
        typeId: typeId ?? this.typeId,
        tagName: tagName ?? this.tagName,
        type: type ?? this.type,
        productSku: productSku ?? this.productSku,
      );
}
