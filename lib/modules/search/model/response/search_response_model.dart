import '../../../../utils/exports.dart';

/// Model class for search response data.
class SearchResponseModel {
  /// Creates a new instance of [SearchResponseModel].
  SearchResponseModel({
    this.suggestions,
    this.productList,
    this.layeredData,
    this.sortingData,
    this.pagination,
  });

  /// Creates a [SearchResponseModel] instance from a JSON map.
  SearchResponseModel.fromJson(Map<String, dynamic> json) {
    suggestions = (json['suggestions'] as List<dynamic>?)
        ?.map((dynamic e) => e.toString())
        .toList();
    if (json['productList'] != null) {
      productList =
          <ProductList>[]; // Explicitly declaring the type as List<ProductList>
      for (final dynamic v in json['productList'] as List<dynamic>) {
        productList!.add(ProductList.fromJson(v as Map<String, dynamic>));
      }
    }

    if (json['layeredData'] != null) {
      layeredData =
          <LayeredData>[]; // Explicitly declaring the type as List<LayeredData>
      for (final dynamic v in json['layeredData'] as List<dynamic>) {
        layeredData!.add(LayeredData.fromJson(v as Map<String, dynamic>));
      }
    }

    if (json['sortingData'] != null) {
      sortingData =
          <SortingData>[]; // Explicitly declaring the type as List<SortingData>
      for (final dynamic v in json['sortingData'] as List<dynamic>) {
        sortingData!.add(SortingData.fromJson(v as Map<String, dynamic>));
      }
    }

    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  /// List of search suggestions.
  List<String>? suggestions;

  /// List of products returned from search.
  List<ProductList>? productList;

  /// Layered navigation data for filtering.
  List<LayeredData>? layeredData;

  /// Sorting options for search results.
  List<SortingData>? sortingData;

  /// Pagination information for search results.
  Pagination? pagination;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['suggestions'] = suggestions;
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
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}
