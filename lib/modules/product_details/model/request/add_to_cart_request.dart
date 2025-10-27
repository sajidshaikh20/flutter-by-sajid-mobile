/// Model class for add to cart request parameters.
class AddToCartRequest {
  /// Creates an instance of [AddToCartRequest].
  AddToCartRequest({
    this.websiteId,
    this.storeId,
    this.customerToken,
    this.quoteId,
    this.sku,
    this.platform,
    this.version,
    this.productVariant,
    this.languageId
  });

  /// Creates an [AddToCartRequest] instance from a JSON map.
  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      AddToCartRequest(
        languageId: json['languageId'],
        websiteId: json['websiteId'],
        storeId: json['storeId'],
        customerToken: json['customerToken'],
        quoteId: json['quoteId'],
        sku: json['sku'],
        platform: json['platform'],
        version: json['version'],
        productVariant: json['product_variant'] != null
            ? CartProductVariant.fromJson(json['product_variant'])
            : null,
      );

  /// The website identifier.
  int? websiteId;

  /// The store identifier.
  int? storeId;

  /// The customer authentication token.
  String? customerToken;

  /// The quote/cart identifier.
  int? quoteId;

  /// The product SKU.
  String? sku;

  /// The platform from which the request is made.
  String? platform;

  /// The application version.
  String? version;

  /// The language identifier.
  int? languageId;

  /// The product variant information for cart.
  CartProductVariant? productVariant;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'websiteId': websiteId,
        'storeId': storeId,
        'customerToken': customerToken,
        'quoteId': quoteId,
        'sku': sku,
        'platform': platform,
        'version': version,
    'languageId':languageId,

        if (productVariant != null) 'product_variant': productVariant!.toJson(),
      };
}

/// Model for cart product variant with entityId and qty
/// Model class for cart product variant information.
class CartProductVariant {
  /// Creates an instance of [CartProductVariant].
  CartProductVariant({
    this.entityId,
    this.qty,
  });

  /// Creates a [CartProductVariant] instance from a JSON map.
  factory CartProductVariant.fromJson(Map<String, dynamic> json) =>
      CartProductVariant(
        entityId: json['entityId'],
        qty: json['qty'],
      );

  /// The entity identifier of the product variant.
  int? entityId;

  /// The quantity of the product variant.
  int? qty;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'entityId': entityId,
        'qty': qty,
      };
}
