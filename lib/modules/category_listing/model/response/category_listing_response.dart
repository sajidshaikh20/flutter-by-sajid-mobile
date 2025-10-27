import '../../../../utils/exports.dart';

part 'category_listing_response.g.dart';

@JsonSerializable(ignoreUnannotated: true)

/// Represents the response for category listing
/// API that extends [BaseProductListResponse].
///
/// This class holds detailed data such as categories,
/// products, sorting information,
/// pagination details, and the total count of items in the response.
class CategoryListingResponse extends BaseProductListResponse {
  /// Constructor for initializing [CategoryListingResponse] object.
  ///
  /// [categoriesData] - Data for categories returned in the response.
  /// [childCategories] - List of child categories under the main categories.
  /// [productList] - List of products available in the category.
  /// [sortingData] - Information related to sorting options.
  /// [layeredData] - Additional layered data for filtering or refinement.
  /// [totalCount] - Total number of items available in the response.
  /// [size] - The size or number of items in the current response.
  /// [pagination] - Pagination details such as the next page or
  /// if there are more items.
  CategoryListingResponse({
    this.categoriesData,
    this.childCategories,
    this.productList,
    this.layeredData,
    this.sortingData,
    this.totalCount,
    this.size,
    this.pagination,
  });

  /// Factory constructor for creating an instance from a JSON map.
  factory CategoryListingResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryListingResponseFromJson(json);

  /// Data representing the categories available in the response.
  @JsonKey(name: 'categoriesData')
  final CategoriesData? categoriesData;

  /// List of child categories nested under the main categories.
  @JsonKey(name: 'childCategories')
  final List<ChildCategories>? childCategories;

  /// List of products available within the category.
  @JsonKey(name: 'productList')
  final List<ProductList>? productList;

  /// Sorting data options available for the products.
  @JsonKey(name: 'sortingData')
  final List<SortingData>? sortingData;

  /// Layered data such as filters, refinement options, etc.
  @JsonKey(name: 'layeredData')
  final List<LayeredData>? layeredData;

  /// The total count of products available in the category.
  @JsonKey(name: 'totalCount')
  final int? totalCount;

  /// The number of items returned in the current response.
  @JsonKey(name: 'size')
  final int? size;

  /// Pagination details to handle multiple pages of products.
  @JsonKey(name: 'pagination')
  final Pagination? pagination;

  /// Converts the [CategoryListingResponse] object to a JSON map.
  Map<String, dynamic> toJson() => _$CategoryListingResponseToJson(this);
}
