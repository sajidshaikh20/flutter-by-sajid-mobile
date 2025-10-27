import '../../../../utils/exports.dart';

/// Model representing the response for a product list API.
class ProductListResponseModel {
  /// Creates an instance of [ProductListResponseModel].
  ProductListResponseModel({
    this.success,
    this.categoriesData,
    this.childCategories,
    this.productList,
    this.layeredData,
    this.sortingData,
    this.totalCount,
    this.size,
    this.pagination,
  });

  /// Creates an instance of [ProductListResponseModel] from a JSON object.
  ProductListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    categoriesData = json['categoriesData'] != null
        ? CategoriesData.fromJson(json['categoriesData'])
        : null;
    if (json['childCategories'] != null) {
      childCategories = (json['childCategories'] as List<dynamic>)
          .map((dynamic v) => ChildCategories.fromJson(v))
          .toList();
    }
    if (json['productList'] != null) {
      productList = (json['productList'] as List<dynamic>)
          .map((dynamic v) => ProductList.fromJson(v))
          .toList();
    }
    if (json['layeredData'] != null) {
      layeredData = (json['layeredData'] as List<dynamic>)
          .map((dynamic v) => LayeredData.fromJson(v))
          .toList();
    }
    if (json['sortingData'] != null) {
      sortingData = (json['sortingData'] as List<dynamic>)
          .map((dynamic v) => SortingData.fromJson(v))
          .toList();
    }
    totalCount = json['totalCount'];
    size = json['size'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  /// Indicates if the response was successful.
  bool? success;

  /// Data related to product categories.
  CategoriesData? categoriesData;

  /// List of child categories.
  List<ChildCategories>? childCategories;

  /// List of products in the response.
  List<ProductList>? productList;

  /// Layered data for filtering or attributes.
  List<LayeredData>? layeredData;

  /// Sorting options available for the product list.
  List<SortingData>? sortingData;

  /// Total count of products in the response.
  int? totalCount;

  /// Size of the product list page.
  int? size;

  /// Pagination details for the product list.
  Pagination? pagination;

  /// Converts the [ProductListResponseModel] instance to a JSON object.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (categoriesData != null) {
      data['categoriesData'] = categoriesData!.toJson();
    }
    if (childCategories != null) {
      data['childCategories'] =
          childCategories!.map((ChildCategories v) => v.toJson()).toList();
    }
    if (productList != null) {
      data['productList'] =
          productList!.map((ProductList v) => v.toJson()).toList();
    }
    if (layeredData != null) {
      data['layeredData'] =
          layeredData!.map((LayeredData v) => v.toJson()).toList();
    }
    if (sortingData != null) {
      data['sortingData'] =
          sortingData!.map((SortingData v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['size'] = size;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

/// A class representing category data.
class CategoriesData {
  /// Constructor to initialize the category with optional parameters.
  ///
  /// [id] The unique identifier of the category.
  /// [name] The name of the category.
  /// [url] The URL of the category.
  CategoriesData({this.id, this.name, this.url});

  /// Creates an instance of [CategoriesData] from a JSON map.
  ///
  /// [json] A map containing the category data.
  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  /// The unique identifier for the category.
  int? id;

  /// The name of the category.
  String? name;

  /// The URL associated with the category.
  String? url;

  /// Converts the [CategoriesData] instance into a JSON map.
  ///
  /// Returns a map containing the category data.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

/// A class representing an empty data structure.
class EmptyData {
  ///store map
  Map<String, dynamic> data = <String, dynamic>{};

  /// Default constructor for [EmptyData].
  EmptyData();

  /// Creates an instance of [EmptyData] from a JSON map.
  ///
  /// [json] A map containing data to initialize
  /// the instance (currently unused, reserved for future use).
  EmptyData.fromJson(Map<String, dynamic> json) {
    data = json;
  }

  /// Converts the [EmptyData] instance into a JSON map.
  ///
  /// Returns an empty map since this class represents empty data.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

/// A class representing child category data.
class ChildCategories {
  /// Constructor to initialize the child category with optional parameters.
  ChildCategories({
    this.image,
    this.customCatImg,
    this.level,
    this.customCatOrder,
    this.name,
    this.inMenu,
    this.requestPath,
    this.id,
  });

  /// Creates an instance of [ChildCategories] from a JSON map.
  ///
  /// [json] A map containing the child category data.
  ChildCategories.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    customCatImg = json['custom_cat_img'];
    level = json['level'];
    customCatOrder = json['custom_cat_order'];
    name = json['name'];
    inMenu = json['in_menu'];
    requestPath = json['request_path'];
    id = json['id'];
  }

  /// The image associated with the child category.
  String? image;

  /// The custom image for the child category.
  String? customCatImg;

  /// The level of the category (e.g., a hierarchy level).
  String? level;

  /// The custom order of the category.
  int? customCatOrder;

  /// The name of the child category.
  String? name;

  /// Whether the category appears in the menu (e.g., 'yes' or 'no').
  String? inMenu;

  /// The request path associated with the child category.
  String? requestPath;

  /// The unique identifier for the child category.
  String? id;

  /// Converts the [ChildCategories] instance into a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['custom_cat_img'] = customCatImg;
    data['level'] = level;
    data['custom_cat_order'] = customCatOrder;
    data['name'] = name;
    data['in_menu'] = inMenu;
    data['request_path'] = requestPath;
    data['id'] = id;
    return data;
  }
}

/// A class representing product details in a list.
//ignore: must_be_immutable
class ProductList extends Equatable {
  /// Default constructor to initialize the product list
  ///  with optional parameters.
  ProductList({
    this.entityId,
    this.child,
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
    this.specialPriceFrom,
    this.specialPriceTo,
    this.isAvailable,
    this.sellerTag,
    this.additionalInfo,
    this.isComingSoon,
    this.isHolyQuran,
    this.productVariant,
    this.reviewCount,
    this.ratings,
    this.isAddedToWishlist,
    this.cartQty,
    this.itemId,
    this.wishListItemid,
    this.statusOfCart = StatusOfCart.initial,
  });

  /// Factory constructor to convert a `RecentViewModel`
  ///  instance to a `ProductList` instance.
  ///

  /// Creates an instance of `ProductList` from a JSON map.
  ///
  /// [json] The JSON map to deserialize.
  ProductList.fromJson(Map<String, dynamic> json) {
    entityId = json['entityId'].toString();
    if (json['child'] != null) {
      child = (json['child'] as List<dynamic>)
          .map((dynamic v) => Child.fromJson(v))
          .toList();
    }
    name = json['name'];
    thumbNail = json['thumbNail'];
    imageLarge = json['image_large'];
    formattedPrice = json['formattedPrice'];
    price = json['price'];
    sku = json['sku'];
    urlKey = json['url_key'];
    url = json['url'];
    shareUrl = json['share_url'];
    formattedFinalPrice = json['formattedFinalPrice'];
    finalPrice = json['finalPrice'];
    percentOff = json['percent_off'];
    specialPriceFrom = json['special_price_from'];
    specialPriceTo = json['special_price_to'];
    isAvailable = json['isAvailable'];
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
    additionalInfo = json['additional_info'];
    isComingSoon = json['isComingSoon'];
    isHolyQuran = json['isHolyQuran'];
    cartQty = json['cartQty'];
    if (json['product_variant'] != null) {
      productVariant = (json['product_variant'] as List<dynamic>)
          .map((dynamic v) => ProductVariant.fromJson(v))
          .toList();
    }
    reviewCount = json['review_count'];
    ratings = json['ratings'];
    isAddedToWishlist = json['isAddedToWishlist'];
  }

  /// The unique identifier for the product entity.
  String? entityId;

  /// A list of child products related to this product.
  List<Child>? child;

  /// The name of the product.
  String? name;

  /// The thumbnail image for the product.
  String? thumbNail;

  /// The large image for the product.
  String? imageLarge;

  /// The formatted price of the product.
  String? formattedPrice;

  /// The actual price of the product.
  double? price;

  /// The SKU (Stock Keeping Unit) identifier for the product.
  String? sku;

  /// The URL key used for SEO or unique identification of the product.
  String? urlKey;

  /// The product URL.
  String? url;

  /// The shareable URL for the product.
  String? shareUrl;

  /// The formatted final price of the product.
  String? formattedFinalPrice;

  /// The actual final price of the product.
  double? finalPrice;

  /// The discount percentage of the product.
  String? percentOff;

  /// The starting date for the special price.
  String? specialPriceFrom;

  /// The ending date for the special price.
  String? specialPriceTo;

  /// A flag indicating if the product is available.
  bool? isAvailable;

  /// A seller's tag for the product.
  String? sellerTag;

  /// Additional information about the product.
  String? additionalInfo;

  /// A flag indicating if the product is coming soon.
  int? isComingSoon;

  /// A flag indicating if the product is related to the Holy Quran.
  int? isHolyQuran;

  /// The quantity of the product in the cart.
  int? cartQty;

  /// A list of product variants available for the product.
  List<ProductVariant>? productVariant;

  /// The number of reviews for the product.
  String? reviewCount;

  /// The average rating of the product.
  double? ratings;

  /// A flag indicating if the product is added to the wishlist.
  bool? isAddedToWishlist;

  /// The item ID in the cart.
  String? itemId;

  /// The wishlist item ID.
  String? wishListItemid;

  /// The status of the product in the cart.
  StatusOfCart? statusOfCart;

  /// Updates the wishlist and cart status based
  ///  on the given [cartWishIds].
  ///
  /// [cartWishIds] The cart and wishlist information
  /// to update the status of this product.
  void updateWishCartStatus(CartWishIds cartWishIds) {
    if (cartWishIds.wishList.isNotEmpty) {
      for (final CartWishModel product in cartWishIds.wishList) {
        if (product.productOrEntityId == entityId.toString()) {
          isAddedToWishlist = true;
          wishListItemid = product.originalId;
          break;
        } else {
          isAddedToWishlist = false;
          wishListItemid = '';
        }
      }
    } else {
      isAddedToWishlist = false;
      wishListItemid = '';
    }

    if (cartWishIds.cartList.isNotEmpty) {
      for (final CartWishModel cart in cartWishIds.cartList) {
        if (cart.productOrEntityId == entityId.toString()) {
          itemId = cart.originalId;
          cartQty = cart.qty;
          break;
        } else {
          itemId = '';
          cartQty = 0;
        }
      }
    } else {
      itemId = '';
      cartQty = 0;
    }
  }

  /// Converts the `ProductList` instance into a JSON map.
  ///
  /// Returns a JSON map representing the product list.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['entityId'] = entityId;
    if (child != null) {
      data['child'] = child!.map((Child v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['thumbNail'] = thumbNail;
    data['image_large'] = imageLarge;
    data['formattedPrice'] = formattedPrice;
    data['price'] = price;
    data['sku'] = sku;
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
    data['isComingSoon'] = isComingSoon;
    data['isHolyQuran'] = isHolyQuran;
    data['cartQty'] = cartQty;
    if (productVariant != null) {
      data['product_variant'] =
          productVariant!.map((ProductVariant v) => v.toJson()).toList();
    }
    data['review_count'] = reviewCount;
    data['ratings'] = ratings;
    data['isAddedToWishlist'] = isAddedToWishlist;
    return data;
  }

  @override
  List<Object?> get props => <Object?>[
        entityId,
        child,
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
        specialPriceFrom,
        specialPriceTo,
        isAvailable,
        sellerTag,
        additionalInfo,
        isComingSoon,
        isHolyQuran,
        productVariant,
        reviewCount,
        ratings,
        isAddedToWishlist,
        cartQty,
        itemId,
        wishListItemid,
        statusOfCart,
      ];

  /// Creates a copy of the current product list,
  /// with optional modifications.
  ///
  /// [entityId] The new entity ID for the product list.
  /// Other optional fields to modify the current product list.
  ProductList copyWith({
    String? entityId,
    List<Child>? child,
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
    String? specialPriceFrom,
    String? specialPriceTo,
    bool? isAvailable,
    String? sellerTag,
    String? additionalInfo,
    int? isComingSoon,
    int? isHolyQuran,
    int? cartQty,
    List<ProductVariant>? productVariant,
    String? reviewCount,
    double? ratings,
    bool? isAddedToWishlist,
    String? itemId,
    String? wishListItemid,
    StatusOfCart? statusOfCart,
  }) =>
      ProductList(
        entityId: entityId ?? this.entityId,
        child: child ?? this.child,
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
        specialPriceFrom: specialPriceFrom ?? this.specialPriceFrom,
        specialPriceTo: specialPriceTo ?? this.specialPriceTo,
        isAvailable: isAvailable ?? this.isAvailable,
        sellerTag: sellerTag ?? this.sellerTag,
        additionalInfo: additionalInfo ?? this.additionalInfo,
        isComingSoon: isComingSoon ?? this.isComingSoon,
        isHolyQuran: isHolyQuran ?? this.isHolyQuran,
        cartQty: cartQty ?? this.cartQty,
        productVariant: productVariant ?? this.productVariant,
        reviewCount: reviewCount ?? this.reviewCount,
        ratings: ratings ?? this.ratings,
        isAddedToWishlist: isAddedToWishlist ?? this.isAddedToWishlist,
        itemId: itemId ?? this.itemId,
        wishListItemid: wishListItemid ?? this.wishListItemid,
        statusOfCart: statusOfCart ?? this.statusOfCart,
      );
}

/// Model representing a product variant.
class ProductVariant {
  /// Creates an instance of [ProductVariant].
  ProductVariant({this.name, this.id});

  /// Creates an instance of [ProductVariant] from a JSON object.
  ProductVariant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  /// The name of the product variant.
  String? name;

  /// The unique identifier for the product variant.
  String? id;

  /// Converts the [ProductVariant] instance to a JSON object.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

/// A class representing layered data for product options.
//ignore: must_be_immutable
class LayeredData extends Equatable {
  /// Default constructor to initialize the `LayeredData`
  /// object with optional parameters.
  LayeredData({this.code, this.type, this.label, this.options});

  /// Factory constructor to create a `LayeredData`
  /// instance from a JSON map.
  LayeredData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    type = json['type'];
    label = json['label'];
    if (json['options'] != null) {
      options = (json['options'] as List<dynamic>)
          .map((dynamic v) => ProductOptions.fromJson(v))
          .toList();
    }
  }

  /// The unique code for the layered data.
  String? code;

  /// The type of the layered data (e.g., color, size).
  String? type;

  /// The label or display name for the layered data.
  String? label;

  /// A list of product options associated with this layered data.
  List<ProductOptions>? options;

  /// Converts the `LayeredData` instance into a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['type'] = type;
    data['label'] = label;
    if (options != null) {
      data['options'] = options!.map((ProductOptions v) => v.toJson()).toList();
    }
    return data;
  }

  /// Creates a copy of the current `LayeredData` object,
  ///  with optional modifications.
  LayeredData copyWith({
    String? code,
    String? type,
    String? label,
    List<ProductOptions>? options,
  }) =>
      LayeredData(
        code: code ?? this.code,
        type: type ?? this.type,
        label: label ?? this.label,
        options: options ?? this.options,
      );

  @override
  List<Object?> get props => <Object?>[code, type, label, options];
}

/// A class representing product options for a particular product.
//ignore: must_be_immutable
class ProductOptions extends Equatable {
  /// Default constructor to initialize the `ProductOptions` object.
  ProductOptions({
    this.id,
    this.label,
    this.count,
    this.isSelected = false,
    this.isApplySelected = false,
  });

  /// Factory constructor to create a `ProductOptions` instance from a JSON map.
  ProductOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    count = json['count'];
    isSelected = json['isSelected'] ?? false;
    isApplySelected = json['isApplySelected'] ?? false;
  }

  /// The unique identifier for the product option.
  String? id;

  /// The label or display name of the product
  /// option (e.g., 'Red', 'Small').
  String? label;

  /// The count of how many options are available for this product.
  int? count;

  /// Indicates whether the option is currently selected.
  bool? isSelected;

  /// Indicates whether the option is selected for
  /// application (e.g., for filtering).
  bool? isApplySelected;

  @override
  List<Object?> get props =>
      <Object?>[id, label, count, isSelected, isApplySelected];

  /// Converts the `ProductOptions` instance into a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['count'] = count;
    data['isSelected'] = isSelected;
    data['isApplySelected'] = isApplySelected;
    return data;
  }

  /// Creates a copy of the current `ProductOptions`
  /// object with optional modifications.
  ProductOptions copyWith({
    String? id,
    String? label,
    int? count,
    bool? isSelected,
    bool? isApplySelected,
  }) =>
      ProductOptions(
        id: id ?? this.id,
        label: label ?? this.label,
        count: count ?? this.count,
        isSelected: isSelected ?? this.isSelected,
        isApplySelected: isApplySelected ?? this.isApplySelected,
      );
}

/// Model representing sorting data for products.
class SortingData {
  /// Creates an instance of [SortingData].
  SortingData({this.code, this.label});

  /// Creates an instance of [SortingData] from a JSON object.
  SortingData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    label = json['label'];
  }

  /// The code associated with the sorting option.
  String? code;

  /// The label describing the sorting option.
  String? label;

  /// Converts the [SortingData] instance to a JSON object.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['label'] = label;
    return data;
  }
}

/// Model representing pagination information for a product list.
class Pagination {
  /// Creates an instance of [Pagination].
  Pagination({this.totalCount, this.start, this.next, this.end, this.size});

  /// Creates an instance of [Pagination] from a JSON object.
  Pagination.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    start = json['start'] is String
        ? int.tryParse(json['start']) ?? 0  // If it's a String, try parsing it to int
        : json['start'] as int;  // If it's already an int, use it as is
    next = json['next'];
    end = json['end'];
    size = json['size'];
  }

  /// The total count of items in the dataset.
  int? totalCount;

  /// The starting index of the current page.
  int? start;

  /// The index of the next page.
  int? next;

  /// Indicates whether the current page is the last page.
  bool? end;

  /// The number of items per page.
  int? size;

  /// Converts the [Pagination] instance to a JSON object.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['start'] = start;
    data['next'] = next;
    data['end'] = end;
    data['size'] = size;
    return data;
  }
}
