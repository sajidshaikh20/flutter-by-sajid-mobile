// To parse this JSON data, do:
//
//     final getFilterData = getFilterDataFromJson(jsonString);

import 'dart:convert';

/// Parses a JSON [String] into a [GetFilterData] instance.
GetFilterData getFilterDataFromJson(String str) =>
    GetFilterData.fromJson(json.decode(str));

/// Converts a [GetFilterData] instance to a JSON [String].
String getFilterDataToJson(GetFilterData data) => json.encode(data.toJson());

/// Model class for filter data response containing brands, categories, and price filters.
///
/// This class represents the structure of the response data
/// used to display product filter options such as brand, category,
/// and price range.
class GetFilterData {
  /// List of available brands for filtering.
  final List<FilterBrand>? brand;

  /// List of available categories for filtering.
  final List<FilterBrand>? category;

  /// Price range filter data.
  final FilterPrice? price;

  /// Creates a [GetFilterData] instance.
  ///
  /// All parameters are optional.
  GetFilterData({
    this.brand,
    this.category,
    this.price,
  });

  /// Creates a copy of this [GetFilterData] instance with optional updated values.
  GetFilterData copyWith({
    List<FilterBrand>? brand,
    List<FilterBrand>? category,
    FilterPrice? price,
  }) =>
      GetFilterData(
        brand: brand ?? this.brand,
        category: category ?? this.category,
        price: price ?? this.price,
      );

  /// Creates a [GetFilterData] instance from a JSON map.
  ///
  /// The [json] map should contain:
  /// - `brand`: A list of brand filters.
  /// - `category`: A list of category filters.
  /// - `price`: A price range object.
  factory GetFilterData.fromJson(Map<String, dynamic> json) => GetFilterData(
    brand: json["brand"] == null
        ? <FilterBrand>[]
        : List<FilterBrand>.from(
        (json["brand"] as List<dynamic>)
            .map((dynamic x) =>
            FilterBrand.fromJson(x as Map<String, dynamic>))),
    category: json["category"] == null
        ? <FilterBrand>[]
        : List<FilterBrand>.from(
        (json["category"] as List<dynamic>)
            .map((dynamic x) =>
            FilterBrand.fromJson(x as Map<String, dynamic>))),
    price: json["price"] == null
        ? null
        : FilterPrice.fromJson(json["price"] as Map<String, dynamic>),
  );

  /// Converts the [GetFilterData] instance into a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "brand": brand == null
        ? <dynamic>[]
        : List<dynamic>.from(brand!.map((FilterBrand x) => x.toJson())),
    "category": category == null
        ? <dynamic>[]
        : List<dynamic>.from(category!.map((FilterBrand x) => x.toJson())),
    "price": price?.toJson(),
  };
}

/// Model class representing a brand or category filter option.
class FilterBrand {
  /// The unique identifier of the brand or category.
  final int? id;

  /// The display name of the brand or category.
  final String? name;

  /// The number of products available under this brand or category.
  final int? count;

  /// Creates a [FilterBrand] instance.
  FilterBrand({
    this.id,
    this.name,
    this.count,
  });

  /// Creates a copy of this [FilterBrand] instance with optional updated values.
  FilterBrand copyWith({
    int? id,
    String? name,
    int? count,
  }) =>
      FilterBrand(
        id: id ?? this.id,
        name: name ?? this.name,
        count: count ?? this.count,
      );

  /// Creates a [FilterBrand] instance from a JSON map.
  ///
  /// The [json] map should contain:
  /// - `id`: The brand/category ID.
  /// - `name`: The brand/category name.
  /// - `count`: The number of products.
  factory FilterBrand.fromJson(Map<String, dynamic> json) => FilterBrand(
    id: json["id"] as int?,
    name: json["name"] as String?,
    count: json["count"] as int?,
  );

  /// Converts this [FilterBrand] instance into a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "id": id,
    "name": name,
    "count": count,
  };
}

/// Model class representing the price range filter options.
class FilterPrice {
  /// The minimum price in the filter range.
  final double? minPrice;

  /// The maximum price in the filter range.
  final double? maxPrice;

  /// Creates a [FilterPrice] instance.
  FilterPrice({
    this.minPrice,
    this.maxPrice,
  });

  /// Creates a copy of this [FilterPrice] instance with optional updated values.
  FilterPrice copyWith({
    double? minPrice,
    double? maxPrice,
  }) =>
      FilterPrice(
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
      );

  /// Creates a [FilterPrice] instance from a JSON map.
  ///
  /// The [json] map should contain:
  /// - `min_price`: The minimum price.
  /// - `max_price`: The maximum price.
  factory FilterPrice.fromJson(Map<String, dynamic> json) => FilterPrice(
    minPrice: (json["min_price"] as num?)?.toDouble(),
    maxPrice: (json["max_price"] as num?)?.toDouble(),
  );

  /// Converts this [FilterPrice] instance into a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "min_price": minPrice,
    "max_price": maxPrice,
  };
}
