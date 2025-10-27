import '../../../../utils/exports.dart';

/// Model class representing the category listing data used for API requests.
class CategoryListingModel {
  /// Constructor to initialize the [CategoryListingModel] with optional fields.
  ///
  /// [website] - The website ID for the request.
  /// [store] - The store ID for the request.
  /// [type] - The type of the listing (e.g., category).
  /// [start] - The starting index for pagination.
  /// [size] - The number of items per page for pagination.
  /// [sort] - The sorting order for the items.
  /// [filterData] - The filter data applied to the category listing.
  /// [aggs] - Whether or not to include aggregation data in the response.
  /// [categoryId] - The ID of the category for which the listing is requested.
  /// [isFromSearch] - A flag indicating if the request is from a search.
  /// [label] - The label used for filtering or categorizing the data.
  CategoryListingModel({
    this.website,
    this.store,
    this.type,
    this.start,
    this.size,
    this.sort,
    this.filterData,
    this.aggs,
    this.categoryId,
    this.isFromSearch = false,
    this.label,
  });

  /// Creates a [CategoryListingModel] instance from a JSON map.
  ///
  /// [json] - The JSON response received from the API, parsed into a map.
  CategoryListingModel.fromJson(Map<String, dynamic> json) {
    website = json[APIConstant.website]; // Website ID for the request
    store = json[APIConstant.store]; // Store ID for the request
    type = json[
        APIConstant.type]; // Type of the category listing (e.g., 'category'),
    start = json[APIConstant.start]; // The starting index for pagination
    size = json[APIConstant.size]; // The number of items per page
    sort = json[APIConstant.sort]; // Sorting method for the items
    filterData = json[APIConstant.filterData]; // Filter applied to the category
    aggs = json[APIConstant.aggs]; // Whether aggregations should be included
    categoryId = json[APIConstant.categoryId]; // The ID of the category
    label =
        json[APIConstant.query]; // The label to filter or categorize the data
  }

  // Variable declarations with comments explaining their purpose:

  /// The website ID for the request.
  String? website;

  /// The store ID for the request.
  String? store;

  /// The type of the listing (e.g., category or other types).
  String? type;

  /// The starting index for pagination.
  int? start;

  /// The number of items per page for pagination.
  int? size;

  /// The sorting order of the items in the listing (e.g., price, name).
  String? sort;

  /// The filter data applied to the category listing.
  String? filterData;

  /// Whether to include aggregation data in the response.
  bool? aggs;

  /// The ID of the category for which the listing is requested.
  int? categoryId;

  /// A flag indicating whether the request is from a search query.
  bool? isFromSearch;

  /// The label used for filtering or categorizing the data in the listing.
  String? label;

  /// Converts the [CategoryListingModel] instance to a JSON map.
  ///
  /// Returns a map representing the properties of this model, which can be
  /// used in an API request.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data[APIConstant.website] = website; // Website ID for the request
    data[APIConstant.store] = store; // Store ID for the request
    data[APIConstant.type] =
        type; // Type of category listing (e.g., 'category')
    data[APIConstant.start] = start; // Pagination start index
    data[APIConstant.size] = Dimens.paginationMaxSize; // Max items per page
    data[APIConstant.sort] = sort; // Sorting method for items
    data[APIConstant.filterData] = filterData; // Applied filter data
    data[APIConstant.aggs] = aggs; // Whether aggregations are included
    data[APIConstant.categoryId] = categoryId; // The category ID
    data[APIConstant.query] = label; // Label for filtering or categorization
    return data;
  }
}
