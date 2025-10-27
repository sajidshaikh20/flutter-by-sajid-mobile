import '../../../../utils/exports.dart';

/// Model class for product details response data.
class ProductDetailsResponse extends Equatable {
  /// Creates an instance of [ProductDetailsResponse].
  const ProductDetailsResponse({
    required this.entityId,
    required this.child,
    required this.name,
    required this.thumbNail,
    required this.isNew,
    required this.imageGallery,
    required this.formattedPrice,
    required this.price,
    required this.sku,
    required this.shortDescription,
    required this.description,
    required this.ingredients,
    required this.nutritions,
    required this.keyFeatures,
    required this.urlKey,
    required this.url,
    required this.shareUrl,
    required this.formattedFinalPrice,
    required this.finalPrice,
    required this.percentOff,
    required this.specialPriceFrom,
    required this.specialPriceTo,
    required this.isAvailable,
    required this.sellerTag,
    required this.additionalInfo,
    required this.productVariant,
    required this.reviewCount,
    required this.ratings,
    required this.categories,
    required this.isComingSoon,
    required this.isHolyQuran,
    required this.relatedProducts,
    required this.isFavorite,
    required this.availableQty,
    required this.allowedQty,
  });

  /// Creates a [ProductDetailsResponse] instance from a JSON map.
  ProductDetailsResponse.fromJson(Map<String, dynamic> json)
      : entityId = json['entityId'],
        child = json['child'] != null
            ? (json['child'] as List<dynamic>)
                .map((dynamic v) => Child.fromJson(v))
                .toList()
            : null,
        name = json['name'],
        thumbNail = json['thumbNail'],
        isNew = json['isNew'],
        imageGallery = json['imageGallery'] != null
            ? (json['imageGallery'] as List<dynamic>)
                .map((dynamic v) => ImageGallery.fromJson(v))
                .toList()
            : null,
        formattedPrice = json['formattedPrice'],
        price = (json['price'] as num?)?.toDouble(),
        sku = json['sku'],
        shortDescription = json['short_description'],
        description = json['description'],
        ingredients = json['ingredients'],
        nutritions = json['nutritions'],
        keyFeatures = json['key_features'],
        urlKey = json['url_key'],
        url = json['url'],
        shareUrl = json['share_url'],
        formattedFinalPrice = json['formattedFinalPrice'],
        finalPrice = (json['finalPrice'] as num?)?.toDouble(),
        percentOff = json['percent_off'],
        specialPriceFrom = json['special_price_from'],
        specialPriceTo = json['special_price_to'],
        isAvailable = json['isAvailable'],
        sellerTag = json['sellerTag'] != null
            ? (json['sellerTag'] is List<dynamic>
                ? List<String>.from(json['sellerTag'])
                : json['sellerTag'] is String
                    ? (json['sellerTag'] as String).isNotEmpty
                        ? <String>[json['sellerTag'] as String]
                        : null
                    : null)
            : null,
        additionalInfo = json['additional_info'],
        productVariant = json['product_variant'] != null
            ? (json['product_variant'] as List<dynamic>)
                .map((dynamic v) => ProductVariantDukkan.fromJson(v))
                .toList()
            : null,
        reviewCount = json['review_count'],
        ratings = (json['ratings'] as num?)?.toDouble(),
        categories = json['categories'] != null
            ? (json['categories'] as List<dynamic>)
                .map((dynamic v) => ProductCategories.fromJson(v))
                .toList()
            : null,
        isComingSoon = json['isComingSoon'],
        isHolyQuran = json['isHolyQuran'],
        relatedProducts = json['related_products'] != null
            ? (json['related_products'] as List<dynamic>)
                .map((dynamic v) => ProductList.fromJson(v))
                .toList()
            : null,
        isFavorite = json['isFavorite'],
        availableQty = (json['available_qty'] as num?)?.toDouble(),
        allowedQty = (json['allowed_qty'] as num?)?.toDouble();

  /// The unique entity identifier for the product.
  final int? entityId;

  /// List of child products or variants.
  final List<Child>? child;

  /// The name/title of the product.
  final String? name;

  /// The thumbnail image URL of the product.
  final String? thumbNail;

  /// Indicates if the product is marked as new.
  final String? isNew;

  /// Gallery of product images.
  final List<ImageGallery>? imageGallery;

  /// The formatted price string (e.g., "$10.99").
  final String? formattedPrice;

  /// The numerical price value of the product.
  final double? price;

  /// The stock keeping unit identifier for the product.
  final String? sku;

  /// A brief description of the product.
  final String? shortDescription;

  /// The full detailed description of the product.
  final String? description;

  /// List of product ingredients.
  final String? ingredients;

  /// Nutritional information for the product.
  final String? nutritions;

  /// Key features of the product.
  final String? keyFeatures;

  /// The URL key for SEO-friendly product URLs.
  final String? urlKey;

  /// The full URL to the product page.
  final String? url;

  /// The share URL for social media sharing.
  final String? shareUrl;

  /// The formatted final price after discounts.
  final String? formattedFinalPrice;

  /// The numerical final price after discounts.
  final double? finalPrice;

  /// The percentage discount off the original price.
  final String? percentOff;

  /// The start date for the special price period.
  final String? specialPriceFrom;

  /// The end date for the special price period.
  final String? specialPriceTo;

  /// Whether the product is currently available for purchase.
  final bool? isAvailable;

  /// The seller tag or identifier.
  final List<String>? sellerTag;

  /// Additional information about the product.
  final String? additionalInfo;

  /// List of product variants (different sizes, colors, etc.).
  final List<ProductVariantDukkan>? productVariant;

  /// The number of customer reviews for the product.
  final String? reviewCount;

  /// The average customer rating for the product.
  final double? ratings;

  /// List of categories this product belongs to.
  final List<ProductCategories>? categories;

  /// Whether this product is coming soon.
  final int? isComingSoon;

  /// Whether this product is related to the Holy Quran.
  final int? isHolyQuran;

  /// List of related products.
  final List<ProductList>? relatedProducts;

  /// Whether the product is in the user's wishlist.
  final bool? isFavorite;

  /// The total available quantity in stock.
  final double? availableQty;

  /// The maximum allowed quantity that can be purchased.
  final double? allowedQty;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entityId'] = entityId;
    if (child != null) {
      data['child'] = child!.map((Child v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['thumbNail'] = thumbNail;
    data['isNew'] = isNew;
    if (imageGallery != null) {
      data['imageGallery'] =
          imageGallery!.map((ImageGallery v) => v.toJson()).toList();
    }
    data['formattedPrice'] = formattedPrice;
    data['price'] = price;
    data['sku'] = sku;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['ingredients'] = ingredients;
    data['nutritions'] = nutritions;
    data['key_features'] = keyFeatures;
    data['url_key'] = urlKey;
    data['url'] = url;
    data['share_url'] = shareUrl;
    data['formattedFinalPrice'] = formattedFinalPrice;
    data['finalPrice'] = finalPrice;
    data['percent_off'] = percentOff;
    data['special_price_from'] = specialPriceFrom;
    data['special_price_to'] = specialPriceTo;
    data['isAvailable'] = isAvailable;
    data['sellerTag'] = sellerTag;
    data['additional_info'] = additionalInfo;
    if (productVariant != null) {
      data['product_variant'] =
          productVariant!.map((ProductVariantDukkan v) => v.toJson()).toList();
    }
    data['review_count'] = reviewCount;
    data['ratings'] = ratings;
    if (categories != null) {
      data['categories'] =
          categories!.map((ProductCategories v) => v.toJson()).toList();
    }
    data['isComingSoon'] = isComingSoon;
    data['isHolyQuran'] = isHolyQuran;
    if (relatedProducts != null) {
      data['related_products'] =
          relatedProducts!.map((ProductList v) => v.toJson()).toList();
    }
    data['isFavorite'] = isFavorite;
    data['available_qty'] = availableQty;
    data['allowed_qty'] = allowedQty;
    return data;
  }

  /// Creates a copy of this [ProductDetailsResponse] with optional new values.
  ProductDetailsResponse copyWith({
    int? entityId,
    List<Child>? child,
    String? name,
    String? thumbNail,
    String? isNew,
    List<ImageGallery>? imageGallery,
    String? formattedPrice,
    double? price,
    String? sku,
    String? shortDescription,
    String? description,
    String? ingredients,
    String? nutritions,
    String? keyFeatures,
    String? urlKey,
    String? url,
    String? shareUrl,
    String? formattedFinalPrice,
    double? finalPrice,
    String? percentOff,
    String? specialPriceFrom,
    String? specialPriceTo,
    bool? isAvailable,
    List<String>? sellerTag,
    String? additionalInfo,
    List<ProductVariantDukkan>? productVariant,
    String? reviewCount,
    double? ratings,
    List<ProductCategories>? categories,
    int? isComingSoon,
    int? isHolyQuran,
    List<ProductList>? relatedProducts,
    bool? isFavorite,
    double? availableQty,
    double? allowedQty,
  }) =>
      ProductDetailsResponse(
        entityId: entityId ?? this.entityId,
        child: child ?? this.child,
        name: name ?? this.name,
        thumbNail: thumbNail ?? this.thumbNail,
        isNew: isNew ?? this.isNew,
        imageGallery: imageGallery ?? this.imageGallery,
        formattedPrice: formattedPrice ?? this.formattedPrice,
        price: price ?? this.price,
        sku: sku ?? this.sku,
        shortDescription: shortDescription ?? this.shortDescription,
        description: description ?? this.description,
        ingredients: ingredients ?? this.ingredients,
        nutritions: nutritions ?? this.nutritions,
        keyFeatures: keyFeatures ?? this.keyFeatures,
        urlKey: urlKey ?? this.urlKey,
        url: url ?? this.url,
        shareUrl: shareUrl ?? this.shareUrl,
        formattedFinalPrice: formattedFinalPrice ?? this.formattedFinalPrice,
        finalPrice: finalPrice ?? this.finalPrice,
        percentOff: percentOff ?? this.percentOff,
        specialPriceFrom: specialPriceFrom ?? this.specialPriceFrom,
        specialPriceTo: specialPriceTo ?? this.specialPriceTo,
        isAvailable: isAvailable ?? this.isAvailable,
        sellerTag: sellerTag ?? this.sellerTag,
        additionalInfo: additionalInfo ?? this.additionalInfo,
        productVariant: productVariant ?? this.productVariant,
        reviewCount: reviewCount ?? this.reviewCount,
        ratings: ratings ?? this.ratings,
        categories: categories ?? this.categories,
        isComingSoon: isComingSoon ?? this.isComingSoon,
        isHolyQuran: isHolyQuran ?? this.isHolyQuran,
        relatedProducts: relatedProducts ?? this.relatedProducts,
        isFavorite: isFavorite ?? this.isFavorite,
        availableQty: availableQty ?? this.availableQty,
        allowedQty: allowedQty ?? this.allowedQty,
      );

  @override
  List<Object?> get props => <Object?>[
        entityId,
        child,
        name,
        thumbNail,
        isNew,
        imageGallery,
        formattedPrice,
        price,
        sku,
        shortDescription,
        description,
        ingredients,
        nutritions,
        keyFeatures,
        urlKey,
        url,
        shareUrl,
        formattedFinalPrice,
        finalPrice,
        percentOff,
        specialPriceFrom,
        specialPriceTo,
        isAvailable,
        sellerTag,
        additionalInfo,
        productVariant,
        reviewCount,
        ratings,
        categories,
        isComingSoon,
        isHolyQuran,
        relatedProducts,
        isFavorite,
        availableQty,
        allowedQty,
      ];
}

/// A model class representing an image in the product gallery.
/// Contains image type, URL, and position information.
class ImageGallery {
  /// The type of the image (e.g., "main", "thumbnail", "gallery").
  String? type;

  /// The URL of the image.
  String? url;

  /// The position/order of the image in the gallery.
  String? position;

  /// Creates an [ImageGallery] instance.
  ///
  /// [type], [url], and [position] are optional image metadata fields.
  ImageGallery({this.type, this.url, this.position});

  /// Creates an [ImageGallery] instance from a JSON map.
  ///
  /// [json] must contain the image gallery data in the expected format.
  /// Returns a new instance populated with the JSON data.
  ImageGallery.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    position = json['position'];
  }

  /// Converts this [ImageGallery] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing the image data
  /// in the format expected by the API.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['url'] = url;
    data['position'] = position;
    return data;
  }
}
