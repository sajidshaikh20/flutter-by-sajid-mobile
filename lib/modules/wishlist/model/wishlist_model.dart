
/// A model representing the data structure of a user's wish list.
class WishlistModel {
  /// Constructor for WishlistModel, initializes wish list data and metadata.
  WishlistModel({
    this.success,
    this.message,
    this.alreadyDeleted,
    this.totalCount,
    this.pageSize,
    this.wishList,
    this.eTag,
  });

  /// Creates a WishlistModel instance from a JSON map.
  WishlistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    alreadyDeleted = json['alreadyDeleted'];
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];

    if (json['wishList'] != null) {
      wishList = (json['wishList'] as List<dynamic>)
          .map<WishList>(
              (dynamic v) => WishList.fromJson(v as Map<String, dynamic>))
          .toList();
    }

    eTag = json['eTag'];
  }

  /// Indicates whether the operation was successful.
  bool? success;

  /// Message describing the result of the operation.
  String? message;

  /// Indicates if the wishlist was already deleted.
  bool? alreadyDeleted;

  /// Total number of items in the wishlist.
  int? totalCount;

  /// The page size used for pagination.
  String? pageSize;

  /// List of items in the wishlist.
  List<WishList>? wishList;

  /// The ETag used for cache validation.
  String? eTag;

  /// Converts the object to a JSON map, including nested wishList items.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['alreadyDeleted'] = alreadyDeleted;
    data['totalCount'] = totalCount;
    data['pageSize'] = pageSize;
    if (wishList != null) {
      data['wishList'] = wishList!.map((WishList v) => v.toJson()).toList();
    }
    data['eTag'] = eTag;
    return data;
  }
}

/// A model representing the data structure of a user's wish list using ProductListingResponse.
class WishlistModelWithProducts {
  /// Constructor for WishlistModelWithProducts, initializes wish list data and metadata.
  WishlistModelWithProducts({
    this.success,
    this.message,
    this.totalCount,

  });

  /// Creates a WishlistModelWithProducts instance from a JSON map.
  WishlistModelWithProducts.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    totalCount = json['totalCount'];
  }

  /// Indicates whether the operation was successful.
  bool? success;

  /// Message describing the result of the operation.
  String? message;

  /// Total number of items in the wishlist.
  int? totalCount;

  /// List of products in the wishlist.


  /// Converts the object to a JSON map, including nested products.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['totalCount'] = totalCount;

    return data;
  }
}

/// Represents an item in the user's wishlist.
class WishList {
  /// Constructs a WishList item, optionally including categories.
  WishList({
    this.categories,
    this.subCategories,
    this.id,
    this.sku,
    this.qty,
    this.name,
    this.price,
    this.productId,
    this.thumbNail,
    this.description,
    this.options,
    this.reviewCount,
    this.configurableData,
    this.isInWishlist,
    this.wishlistItemId,
    this.typeId,
    this.entityId,
    this.rating,
    this.isAvailable,
    this.finalPrice,
    this.formattedPrice,
    this.formattedFinalPrice,
    this.hasRequiredOptions,
    this.isNew,
    this.isInRange,
    this.dominantColor,
    this.tierPrice,
    this.formattedTierPrice,
    this.minAddToCartQty,
    this.availability,
    this.arUrl,
    this.arType,
    this.arTextureImages,
    this.sellerTag,
    this.isComingSoon,
    this.isHolyQuran,
    this.isAdult,
    this.adultAge,
    this.quoteItemQty,
    this.isQuote,
    this.itemId,
  });

  /// Creates a WishList instance from a JSON map.
  WishList.fromJson(Map<String, dynamic> json) {
    /*   if (json['categories'] != null) {
      categories = (json['categories'] as List<WishListCategories>)
          .map<WishListCategories>(
              (dynamic v) => WishListCategories.fromJson(v))
          .toList();
    }*/

    if (json['categories'] != null) {
      categories = (json['categories'] as List<dynamic>)
          .map<WishListCategories>((dynamic v) =>
              WishListCategories.fromJson(v as Map<String, dynamic>))
          .toList();
    }

    if (json['subCategories'] != null) {
      subCategories = (json['subCategories'] as List<dynamic>)
          .map<SubCategories>((dynamic v) => SubCategories.fromJson(v))
          .toList();
    }

    id = json['id'];
    sku = json['sku'];
    qty = json['qty'];
    name = json['name'];
    price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : (json['price'] is double)
            ? json['price']
            : 0.0;

    // price = json['price'] is int ? json['price'].toDouble() : json['price'];
    productId = json['productId'];
    thumbNail = json['thumbNail'];
    description = json['description'];
    if (json['options'] != null) {
      options = (json['options'] as List<dynamic>)
          .map<OptionsModel>((dynamic v) => OptionsModel.fromJson(v))
          .toList();
    }

    reviewCount = json['reviewCount'];
    configurableData = json['configurableData'] != null
        ? ConfigurableData.fromJson(json['configurableData'])
        : null;
    isInWishlist = json['isInWishlist'];
    wishlistItemId = json['wishlistItemId'];
    typeId = json['typeId'];
    entityId = json['entityId'];
    rating = json['rating'] is int ? json['rating'].toString() : json['rating'];
    isAvailable = json['isAvailable'];
    finalPrice = (json['finalPrice'] is int)
        ? (json['finalPrice'] as int).toDouble()
        : (json['finalPrice'] is double)
            ? json['finalPrice']
            : 0.0;
    /*finalPrice = json['finalPrice'] is int
        ? json['finalPrice'].toDouble()
        : json['finalPrice'];*/
    formattedPrice = json['formattedPrice'];
    formattedFinalPrice = json['formattedFinalPrice'];
    hasRequiredOptions = json['hasRequiredOptions'];
    isNew = json['isNew'];
    isInRange = json['isInRange'];
    dominantColor = json['dominantColor'];
    tierPrice = json['tierPrice'];
    formattedTierPrice = json['formattedTierPrice'];
    minAddToCartQty = json['minAddToCartQty'];
    availability = json['availability'];
    arUrl = json['arUrl'];
    arType = json['arType'];
    if (json['arTextureImages'] != null) {
      arTextureImages = (json['arTextureImages'] as List<dynamic>)
          .map<TextureImages>((dynamic v) => TextureImages.fromJson(v))
          .toList();
    }

    if (json['sellerTag'] != null) {
      if (json['sellerTag'] is List) {
        // If sellerTag is a list, take the first element as a string
        final List<dynamic> tagList = json['sellerTag'] as List<dynamic>;
        sellerTag = tagList.isNotEmpty ? tagList.first.toString() : null;
      } else if (json['sellerTag'] is String) {
        // If sellerTag is a string, use it directly
        String tagString = json['sellerTag'] as String;
        sellerTag = tagString.isNotEmpty ? tagString : null;
      }
    }
    isComingSoon = json['isComingSoon'];
    isHolyQuran = json['isHolyQuran'];
    isAdult = json['isAdult'];
    adultAge = json['adultAge'];
    quoteItemQty = json['quoteItemQty'];
    isQuote = json['isQuote'];
    itemId = json['itemId'];
  }

  /// List of categories associated with the wishlist item.
  List<WishListCategories>? categories;

  /// List of subcategories associated with the wishlist item.
  List<SubCategories>? subCategories;

  /// Unique identifier for the wishlist item.
  String? id;

  /// The SKU (Stock Keeping Unit) of the wishlist item.
  String? sku;

  /// The quantity of the wishlist item.
  int? qty;

  /// The name of the wishlist item.
  String? name;

  /// The price of the wishlist item.
  double? price;

  /// The product ID associated with the wishlist item.
  String? productId;

  /// The thumbnail image URL of the wishlist item.
  String? thumbNail;

  /// A description of the wishlist item.
  String? description;

  /// List of available options for the wishlist item.
  List<OptionsModel>? options;

  /// The review count for the wishlist item.
  int? reviewCount;

  /// Data related to configurable product options.
  ConfigurableData? configurableData;

  /// Indicates whether the item is in the wishlist.
  bool? isInWishlist;

  /// Unique identifier for the wishlist item in the database.
  int? wishlistItemId;

  /// The type ID of the wishlist item (e.g., simple, configurable).
  String? typeId;

  /// The entity ID associated with the wishlist item.
  String? entityId;

  /// The product rating of the wishlist item.
  String? rating;

  /// Indicates whether the wishlist item is available.
  bool? isAvailable;

  /// The final price of the wishlist item after any discounts.
  double? finalPrice;

  /// The formatted price of the wishlist item.
  String? formattedPrice;

  /// The formatted final price of the wishlist item after any discounts.
  String? formattedFinalPrice;

  /// Indicates whether the wishlist item has required options.
  bool? hasRequiredOptions;

  /// Indicates whether the wishlist item is new.
  bool? isNew;

  /// Indicates whether the wishlist item is in range for offers or promotions.
  bool? isInRange;

  /// The dominant color of the wishlist item.
  String? dominantColor;

  /// The tier price of the wishlist item (for bulk purchases).
  String? tierPrice;

  /// The formatted tier price for the wishlist item.
  String? formattedTierPrice;

  /// The minimum quantity required to add the item to the cart.
  int? minAddToCartQty;

  /// The availability status of the wishlist item.
  String? availability;

  /// The URL for augmented reality features of the wishlist item.
  String? arUrl;

  /// The type of augmented reality features available for the wishlist item.
  String? arType;

  /// List of textures available for the augmented reality feature.
  List<TextureImages>? arTextureImages;

  /// The seller tag associated with the wishlist item.
  String? sellerTag;

  /// Indicates whether the wishlist item is coming soon.
  int? isComingSoon;

  /// Indicates whether the wishlist item is a Holy Quran.
  int? isHolyQuran;

  /// Indicates whether the wishlist item is an adult product.
  int? isAdult;

  /// The recommended minimum age for the wishlist item if it's an adult product.
  String? adultAge;

  /// The quantity of the wishlist item in the quote.
  int? quoteItemQty;

  /// Indicates whether the wishlist item is part of a quote.
  int? isQuote;

  /// The item ID for the wishlist item.
  int? itemId;

  /// Converts the WishList object to a JSON map, including nested objects and
  /// lists.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] =
          categories!.map((WishListCategories v) => v.toJson()).toList();
    }
    if (subCategories != null) {
      data['subCategories'] =
          subCategories!.map((SubCategories v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['sku'] = sku;
    data['qty'] = qty;
    data['name'] = name;
    data['price'] = price;
    data['productId'] = productId;
    data['thumbNail'] = thumbNail;
    data['description'] = description;
    if (options != null) {
      data['options'] = options!.map((OptionsModel v) => v.toJson()).toList();
    }
    data['reviewCount'] = reviewCount;
    if (configurableData != null) {
      data['configurableData'] = configurableData!.toJson();
    }
    data['isInWishlist'] = isInWishlist;
    data['wishlistItemId'] = wishlistItemId;
    data['typeId'] = typeId;
    data['entityId'] = entityId;
    data['rating'] = rating;
    data['isAvailable'] = isAvailable;
    data['finalPrice'] = finalPrice;
    data['formattedPrice'] = formattedPrice;
    data['formattedFinalPrice'] = formattedFinalPrice;
    data['hasRequiredOptions'] = hasRequiredOptions;
    data['isNew'] = isNew;
    data['isInRange'] = isInRange;
    data['dominantColor'] = dominantColor;
    data['tierPrice'] = tierPrice;
    data['formattedTierPrice'] = formattedTierPrice;
    data['minAddToCartQty'] = minAddToCartQty;
    data['availability'] = availability;
    data['arUrl'] = arUrl;
    data['arType'] = arType;
    if (arTextureImages != null) {
      data['arTextureImages'] =
          arTextureImages!.map((TextureImages v) => v.toJson()).toList();
    }
    data['sellerTag'] = sellerTag;
    data['isComingSoon'] = isComingSoon;
    data['isHolyQuran'] = isHolyQuran;
    data['isAdult'] = isAdult;
    data['adultAge'] = adultAge;
    data['quoteItemQty'] = quoteItemQty;
    data['isQuote'] = isQuote;
    data['itemId'] = itemId;
    return data;
  }
}

/// Represents a category in the wishlist.
class WishListCategories {
  /// Represents a category in the wishlist.
  WishListCategories({this.categoryId, this.categoryName});

  /// Creates a WishListCategories object from a JSON map.
  WishListCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
  }

  /// Category ID of the wishlist item, can be null if not available.
  String? categoryId;

  /// Category name of the wishlist item, can be null if not available.
  String? categoryName;

  /// Converts the WishListCategories object to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    return data;
  }
}

/// Represents a subcategory in the wishlist.
class SubCategories {
  /// Constructor for creating SubCategories with optional subcategory ID and
  /// name.
  SubCategories({this.subCategoryId, this.subCategoryName});

  /// Creates a SubCategories instance from a JSON map.
  SubCategories.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
  }

  /// Subcategory ID, can be null if not available.
  String? subCategoryId;

  /// Subcategory name, can be null if not available.
  String? subCategoryName;

  /// Converts SubCategories instance to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['subCategoryId'] = subCategoryId;
    data['subCategoryName'] = subCategoryName;
    return data;
  }
}

/// Represents the configurable data for a wishlist item.
class ConfigurableData {
  /// Initializes an empty map to store key-value pairs for JSON serialization.
  Map<String, dynamic> data = <String, dynamic>{};

  /// [json] A map containing data to initialize the
  ///  instance (currently unused, reserved for future use).
  ConfigurableData.fromJson(Map<String, dynamic> json) {
    data = json;
  }

  /// Converts the object to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

/// Represents options for a wishlist item, such as size or color.
class OptionsModel {
  /// Creates an empty map to store the object's data for JSON conversion.
  Map<String, dynamic> data = <String, dynamic>{};

  /// [json] A map containing data to initialize
  /// the instance (currently unused, reserved for future use).
  OptionsModel.fromJson(Map<String, dynamic> json) {
    data = json;
  }

  /// Converts the object to a JSON-compatible map and returns it.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

/// Represents texture images related to the object, used for 3D or AR
/// visualization.
class TextureImages {
  /// Initializes an empty map to store texture image data for JSON serialization.
  Map<String, dynamic> data = <String, dynamic>{};

  /// [json] A map containing data to initialize
  /// the instance (currently unused, reserved for future use).
  TextureImages.fromJson(Map<String, dynamic> json) {
    data = json;
  }

  /// Converts the object to a JSON-compatible map for serialization.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
