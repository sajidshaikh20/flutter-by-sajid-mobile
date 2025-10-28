import '../../../../utils/exports.dart';


/// A model class representing a product listing response from the API.
/// Contains all product information including pricing, inventory, and variant data.


class ProductListingResponse extends Equatable {
  /// The unique entity identifier for the product.
  final int? entityId;

  /// Indicates if the product is marked as new.
  final String? isNew;

  /// The name/title of the product.
  final String? name;

  /// The thumbnail image URL of the product.
  final String? thumbNail;

  /// The large image URL of the product.
  final String? imageLarge;

  /// The formatted price string (e.g., "$10.99").
  final String? formattedPrice;

  /// The numerical price value of the product.
  final double? price;

  /// The stock keeping unit identifier for the product.
  final String? sku;

  /// The URL key for SEO-friendly product URLs.
  final String? urlKey;

  /// The full URL to the product page.
  final String? url;

  /// The share URL for social media sharing.
  final String? shareUrl;

  /// The formatted final price after discounts (e.g., "$8.99").
  final String? formattedFinalPrice;

  /// The numerical final price after discounts.
  final double? finalPrice;

  /// The percentage discount off the original price.
  final String? percentOff;

  /// Whether the product is currently available for purchase.
  final bool? isAvailable;

  /// The seller tag or identifier.
  final String? sellerTag;

  /// Additional information about the product.
  final String? additionalInfo;

  /// The number of customer reviews for the product.
  final String? reviewCount;

  /// The average customer rating for the product.
  final double? ratings;

  /// Whether the product is in the user's wishlist.
  final bool? isFavorite;

  /// Whether the product is currently in the user's cart.
  final bool? isCart;

  /// The quantity of this product currently in the cart.
  final int? cartQuantity;

  /// List of product variants (different sizes, colors, etc.).
  final List<ProductVariantDukkan>? productVariant;

  /// Whether this product variant is currently selected.
  final bool isSelected;

  /// The label for quantity display (often same as SKU).
  final String? quantityLabel;

  /// The unit of measurement for the product.
  final String? uom;

  /// Whether this product is a reward item.
  final bool? isReward;

  /// Creates a [ProductListingResponse] instance.
  ///
  /// All parameters are optional and represent product data from the API.
  /// [isSelected] defaults to false if not specified.
  const ProductListingResponse({
    this.entityId,
    this.isNew,
    this.name,
    this.thumbNail,
    this.imageLarge,
    this.formattedPrice,
    this.price,
    this.sku,
    this.urlKey,
    this.url,
    this.shareUrl,
    this.formattedFinalPrice,
    this.finalPrice,
    this.percentOff,
    this.isAvailable,
    this.sellerTag,
    this.additionalInfo,
    this.reviewCount,
    this.ratings,
    this.isFavorite,
    this.isCart,
    this.cartQuantity,
    this.productVariant,
    this.isSelected = false,
    this.quantityLabel,
    this.uom,
    this.isReward,
  }      );

  /// Creates a copy of this [ProductListingResponse] with optional new values.
  ///
  /// If a parameter is not provided, the current value is used.
  /// Returns a new instance with the updated values.
  ProductListingResponse copyWith({
    int? entityId,
    String? isNew,
    String? name,
    String? thumbNail,
    String? imageLarge,
    String? formattedPrice,
    double? price,
    String? sku,
    String? urlKey,
    String? url,
    String? shareUrl,
    String? formattedFinalPrice,
    double? finalPrice,
    String? percentOff,
    bool? isAvailable,
    String? sellerTag,
    String? additionalInfo,
    String? reviewCount,
    double? ratings,
    bool? isFavorite,
    bool? isCart,
    int? cartQuantity,
    List<ProductVariantDukkan>? productVariant,
    bool? isSelected,
    String? quantityLabel,
    String? uom,
    bool? isReward,
  }) =>
      ProductListingResponse(
        entityId: entityId ?? this.entityId,
        isNew: isNew ?? this.isNew,
        name: name ?? this.name,
        thumbNail: thumbNail ?? this.thumbNail,
        imageLarge: imageLarge ?? this.imageLarge,
        formattedPrice: formattedPrice ?? this.formattedPrice,
        price: price ?? this.price,
        sku: sku ?? this.sku,
        urlKey: urlKey ?? this.urlKey,
        url: url ?? this.url,
        shareUrl: shareUrl ?? this.shareUrl,
        formattedFinalPrice: formattedFinalPrice ?? this.formattedFinalPrice,
        finalPrice: finalPrice ?? this.finalPrice,
        percentOff: percentOff ?? this.percentOff,
        isAvailable: isAvailable ?? this.isAvailable,
        sellerTag: sellerTag ?? this.sellerTag,
        additionalInfo: additionalInfo ?? this.additionalInfo,
        reviewCount: reviewCount ?? this.reviewCount,
        ratings: ratings ?? this.ratings,
        isFavorite: isFavorite ?? this.isFavorite,
        isCart: isCart ?? this.isCart,
        cartQuantity: cartQuantity ?? this.cartQuantity,
        productVariant: productVariant ?? this.productVariant,
        isSelected: isSelected ?? this.isSelected,
        quantityLabel: quantityLabel ?? this.quantityLabel,
        uom: uom ?? this.uom,
        isReward: isReward ?? this.isReward,
      );

  /// Creates a [ProductListingResponse] instance from a JSON map.
  ///
  /// [json] must contain the product data in the expected format.
  /// Returns a new instance populated with the JSON data.
  factory ProductListingResponse.fromJson(Map<String, dynamic> json) =>
      ProductListingResponse(
        entityId: json["entityId"],
        isNew: json["isNew"]?.toString(),
        name: json["name"],
        thumbNail: json["thumbNail"],
        imageLarge: json["image_large"],
        formattedPrice: json["formattedPrice"],
        price: (json["price"] as num?)?.toDouble(),
        sku: json["sku"],
        urlKey: json["url_key"],
        url: json["url"],
        shareUrl: json["share_url"],
        formattedFinalPrice: json["formattedFinalPrice"],
        finalPrice: (json["finalPrice"] as num?)?.toDouble(),
        percentOff: json["percent_off"],
        isAvailable: json["isAvailable"],
        sellerTag: json["sellerTag"] != null
            ? (json["sellerTag"] is List<dynamic>
            ? (json["sellerTag"] as List<dynamic>).isNotEmpty
            ? (json["sellerTag"] as List<dynamic>)[0].toString()
            : null
            : json["sellerTag"] is String
            ? (json["sellerTag"] as String).isNotEmpty
            ? json["sellerTag"] as String
            : null
            : null)
            : null,
        additionalInfo: json["additional_info"],
        reviewCount: json["review_count"],
        ratings: (json["ratings"] as num?)?.toDouble(),
        isFavorite: json["isFavorite"],
        isCart: json["isCart"],
        cartQuantity: json["cartQuantity"] is double
            ? (json["cartQuantity"] as double).toInt()
            : json["cartQuantity"],
        productVariant: json["product_variant"] == null
            ? <ProductVariantDukkan>[]
            : List<ProductVariantDukkan>.from(
            (json["product_variant"] as List<dynamic>).map((dynamic x) =>
                ProductVariantDukkan.fromJson(x as Map<String, dynamic>))),
        quantityLabel: json["sku"],
        uom: json["uom"],  // Map uom from JSON
        isReward: json["is_reward"],
      );

  /// Converts this [ProductListingResponse] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing all the product data
  /// in the format expected by the API.
  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        "entityId": entityId,
        "isNew": isNew,
        "name": name,
        "thumbNail": thumbNail,
        "image_large": imageLarge,
        "formattedPrice": formattedPrice,
        "price": price,
        "sku": sku,
        "url_key": urlKey,
        "url": url,
        "share_url": shareUrl,
        "formattedFinalPrice": formattedFinalPrice,
        "finalPrice": finalPrice,
        "percent_off": percentOff,
        "isAvailable": isAvailable,
        "sellerTag": sellerTag,
        "additional_info": additionalInfo,
        "review_count": reviewCount,
        "ratings": ratings,
        "isFavorite": isFavorite,
        "isCart": isCart,
        "cartQuantity": cartQuantity,
        "product_variant": productVariant == null
            ? <dynamic>[]
            : List<dynamic>.from(
            productVariant!.map((ProductVariantDukkan x) => x.toJson())),
        "isSelected": isSelected,
        "quantityLabel": quantityLabel,
        "uom": uom,
        "is_reward": isReward,
      };

  @override
  List<Object?> get props => <Object?>[
    entityId,
    isNew,
    name,
    thumbNail,
    imageLarge,
    formattedPrice,
    price,
    sku,
    urlKey,
    url,
    shareUrl,
    formattedFinalPrice,
    finalPrice,
    percentOff,
    isAvailable,
    sellerTag,
    additionalInfo,
    reviewCount,
    ratings,
    isFavorite,
    isCart,
    cartQuantity,
    productVariant,
    isSelected,
    quantityLabel,
    uom,
    isReward
  ];
}

/// A model class representing a product variant with detailed pricing and inventory information.
/// Extends Equatable for value comparison and contains all variant-specific data.
class ProductVariantDukkan extends Equatable {
  /// The unique entity identifier for the product variant.
  final int? entityId;

  /// The name/description of the product variant.
  final String? name;

  /// The thumbnail image URL for the variant.
  final String? thumbNail;

  /// The large image URL for the variant.
  final String? imageLarge;

  /// The formatted price string for the variant (e.g., "$10.99").
  final String? formattedPrice;

  /// The numerical price value for the variant.
  final double? price;

  /// The formatted final price after discounts for the variant.
  final String? formattedFinalPrice;

  /// The numerical final price after discounts for the variant.
  final double? finalPrice;

  /// The percentage discount for the variant.
  final String? percentOff;

  /// Whether this variant is available for purchase.
  final bool? isAvailable;

  /// Whether this variant is currently selected by the user.
  final bool isSelected;

  /// The label used for quantity display (often the variant name).
  final String? quantityLabel;

  /// The quantity of this variant currently in the user's cart.
  final int? cartQuantity;

  /// The total available quantity in stock for this variant.
  final double? availableQty;

  /// The maximum allowed quantity that can be purchased.
  final double? allowedQty;

  /// Whether this variant is currently in the user's cart.
  final bool? isCart;

  /// Whether this variant is in the user's wishlist.
  final bool? isFavorite;

  /// The stock keeping unit identifier for this variant.
  final String? sku;

  /// The unit of measurement for this variant.
  final String? uom;

  /// Creates a [ProductVariantDukkan] instance.
  ///
  /// All parameters are optional and represent variant-specific data.
  /// [isSelected] defaults to false if not specified.
  const ProductVariantDukkan({
    this.entityId,
    this.name,
    this.thumbNail,
    this.imageLarge,
    this.formattedPrice,
    this.price,
    this.formattedFinalPrice,
    this.finalPrice,
    this.percentOff,
    this.isAvailable,
    this.isSelected = false,
    this.quantityLabel,
    this.cartQuantity,
    this.availableQty,
    this.allowedQty,
    this.isCart,
    this.isFavorite,
    this.sku,
    this.uom,
  }      );

  /// Creates a copy of this [ProductVariantDukkan] with optional new values.
  ///
  /// If a parameter is not provided, the current value is used.
  /// Returns a new instance with the updated values.
  ProductVariantDukkan copyWith({
    int? entityId,
    String? name,
    String? thumbNail,
    String? imageLarge,
    String? formattedPrice,
    double? price,
    String? formattedFinalPrice,
    double? finalPrice,
    String? percentOff,
    bool? isAvailable,
    bool? isSelected,
    String? quantityLabel,
    int? cartQuantity,
    double? availableQty,
    double? allowedQty,
    bool? isCart,
    bool? isFavorite,
    String? sku,
    String? uom,
  }) =>
      ProductVariantDukkan(
        entityId: entityId ?? this.entityId,
        name: name ?? this.name,
        thumbNail: thumbNail ?? this.thumbNail,
        imageLarge: imageLarge ?? this.imageLarge,
        formattedPrice: formattedPrice ?? this.formattedPrice,
        price: price ?? this.price,
        formattedFinalPrice: formattedFinalPrice ?? this.formattedFinalPrice,
        finalPrice: finalPrice ?? this.finalPrice,
        percentOff: percentOff ?? this.percentOff,
        isAvailable: isAvailable ?? this.isAvailable,
        isSelected: isSelected ?? this.isSelected,
        quantityLabel: quantityLabel ?? this.quantityLabel,
        cartQuantity: cartQuantity ?? this.cartQuantity,
        availableQty: availableQty ?? this.availableQty,
        allowedQty: allowedQty ?? this.allowedQty,
        isCart: isCart ?? this.isCart,
        isFavorite: isFavorite ?? this.isFavorite,
        sku: sku ?? this.sku,
        uom: uom ?? this.uom,
      );

  /// Creates a [ProductVariantDukkan] instance from a JSON map.
  ///
  /// [json] must contain the variant data in the expected format.
  /// Returns a new instance populated with the JSON data.
  factory ProductVariantDukkan.fromJson(Map<String, dynamic> json) =>
      ProductVariantDukkan(
        entityId: json["entityId"],
        name: json["name"],
        thumbNail: json["thumbNail"],
        imageLarge: json["image_large"],
        formattedPrice: json["formattedPrice"],
        price: (json["price"] as num?)?.toDouble(),
        formattedFinalPrice: json["formattedFinalPrice"],
        finalPrice: (json["finalPrice"] as num?)?.toDouble(),
        percentOff: json["percent_off"],
        isAvailable: json["isAvailable"],
        quantityLabel: json["name"],
        cartQuantity: json["cartQuantity"] is double
            ? (json["cartQuantity"] as double).toInt()
            : json["cartQuantity"] as int?,
        availableQty: (json["available_qty"] as num?)?.toDouble(),
        allowedQty: (json["allowed_qty"] as num?)?.toDouble(),
        isCart: json["isCart"],
        isFavorite: json["isFavorite"],
        sku: json["sku"],
        uom: json["uom"],  // Map uom from JSON
      );

  /// Converts this [ProductVariantDukkan] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing all the variant data
  /// in the format expected by the API.
  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        "entityId": entityId,
        "name": name,
        "thumbNail": thumbNail,
        "image_large": imageLarge,
        "formattedPrice": formattedPrice,
        "price": price,
        "formattedFinalPrice": formattedFinalPrice,
        "finalPrice": finalPrice,
        "percent_off": percentOff,
        "isAvailable": isAvailable,
        "isSelected": isSelected,
        "quantityLabel": quantityLabel,
        "cartQuantity": cartQuantity,
        "available_qty": availableQty,
        "allowed_qty": allowedQty,
        "isCart": isCart,
        "isFavorite": isFavorite,
        "sku": sku,
        "uom": uom,
      };

  /// Gets the maximum allowed quantity that can be purchased for this variant.
  ///
  /// Returns the minimum of available quantity and allowed quantity.
  /// Returns 0 if either available or allowed quantity is 0 or less.
  double get maxAllowedQuantity {
    final double available = availableQty ?? 0;
    final double allowed = allowedQty ?? 0;

    if (available <= 0 || allowed <= 0) {
      return 0;
    }

    return available < allowed ? available : allowed;
  }

  /// Validates if the requested quantity can be added to the cart.
  ///
  /// [requestedQuantity] is the quantity the user wants to add.
  /// Returns a [QuantityValidationResult] indicating if the quantity is valid
  /// and provides details about any validation errors.
  QuantityValidationResult validateQuantity(int requestedQuantity) {
    final double maxAllowed = maxAllowedQuantity;
    final int currentCartQty = cartQuantity ?? 0;
    final int newTotalQuantity = currentCartQty + requestedQuantity;

    if (maxAllowed <= 0) {
      return const QuantityValidationResult(
        isValid: false,
        message: "Product is out of stock",
        maxAllowedQuantity: 0,
      );
    }

    if (newTotalQuantity > maxAllowed) {
      final int canAdd = (maxAllowed - currentCartQty).toInt();
      return QuantityValidationResult(
        isValid: false,
        message:
        "Only $canAdd items can be added. Available: ${availableQty?.toInt() ?? 0}, Allowed: ${(allowedQty ?? 0).toInt()}",
        maxAllowedQuantity: canAdd,
      );
    }

    return QuantityValidationResult(
      isValid: true,
      message: "Quantity validated successfully",
      maxAllowedQuantity: maxAllowed.toInt(),
    );
  }

  /// Gets a human-readable message about quantity limits for this variant.
  ///
  /// Returns different messages based on stock availability and purchase limits.
  String get quantityLimitMessage {
    final double available = availableQty ?? 0;
    final double allowed = allowedQty ?? 0;

    if (available <= 0 || allowed <= 0) {
      return "Out of stock";
    }

    if (available < allowed) {
      return "Only ${available.toInt()} items available";
    }

    return "Up to ${allowed.toInt()} items allowed";
  }

  /// Checks if this variant is currently in stock and available for purchase.
  ///
  /// Returns true if the maximum allowed quantity is greater than 0.
  bool get isInStock => maxAllowedQuantity > 0;

  @override
  List<Object?> get props => <Object?>[
    entityId,
    name,
    thumbNail,
    imageLarge,
    formattedPrice,
    price,
    formattedFinalPrice,
    finalPrice,
    percentOff,
    isAvailable,
    isSelected,
    quantityLabel,
    cartQuantity,
    availableQty,
    allowedQty,
    isCart,
    isFavorite,
    sku,
    uom,
  ];
}

/// A model class representing the result of quantity validation.
/// Contains information about whether a quantity request is valid and why.
class QuantityValidationResult {
  /// Whether the requested quantity is valid for purchase.
  final bool isValid;

  /// A message explaining the validation result or any errors.
  final String message;

  /// The maximum quantity that can be purchased.
  final int maxAllowedQuantity;

  /// Creates a [QuantityValidationResult] instance.
  ///
  /// [isValid] indicates if the quantity is valid.
  /// [message] provides details about the validation result.
  /// [maxAllowedQuantity] specifies the maximum allowed quantity.
  const QuantityValidationResult({
    required this.isValid,
    required this.message,
    required this.maxAllowedQuantity,
  });
}
