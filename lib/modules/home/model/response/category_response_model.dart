

/// Model class for category response data.
class CategoryResponseModel {
  /// The custom category order.
  final String? customCatOrder;

  /// The unique identifier of the category.
  final int? categoryId;

  /// The name of the category.
  final String? categoryName;

  /// The image URL of the category.
  final String? categoryImage;

  /// Whether the category has child categories.
  final bool hasChildren;

  /// List of child categories.
  final List<ChildCategoryModel> childCategories;

  /// Creates an instance of [CategoryResponseModel].
  CategoryResponseModel({
    this.customCatOrder,
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.hasChildren = false,
    this.childCategories = const <ChildCategoryModel>[],
  });
///fromJson
  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryResponseModel(
      customCatOrder: json['custom_cat_order'] as String?,
      categoryId: json['categoryId'] as int?,
      hasChildren: json['hasChildren'] as bool? ?? false,
      childCategories: (json['childCategories'] as List<dynamic>?)
          ?.map((dynamic e) =>
          ChildCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          <ChildCategoryModel>[],

      categoryName: json['categoryName'] as String?,
      categoryImage: json['categoryImage'] as String?,
    );
  }

}


/// Represents a child category within a category hierarchy.
///
/// This model contains basic details such as the category ID, name,
/// URL, and request path that can be used for API calls or navigation.
class ChildCategoryModel {
  /// The unique identifier for the category.
  final int? categoryId;

  /// The display name of the category.
  final String? categoryName;

  /// The URL associated with the category, if available.
  final String? url;

  /// The request path for the category, typically used for routing or API calls.
  final String? requestPath;

  /// Creates an instance of [ChildCategoryModel].
  ///
  /// All parameters are optional and can be null if the data is unavailable.
  ChildCategoryModel({
    this.categoryId,
    this.categoryName,
    this.url,
    this.requestPath,
  });

  /// Creates a [ChildCategoryModel] instance from a JSON map.
  ///
  /// The [json] map should contain the following keys:
  /// - `'categoryId'`: The category ID.
  /// - `'categoryName'`: The name of the category.
  /// - `'url'`: The URL associated with the category.
  /// - `'request_path'`: The request path for the category.
  factory ChildCategoryModel.fromJson(Map<String, dynamic> json) {
    return ChildCategoryModel(
      categoryId: json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
      url: json['url'] as String?,
      requestPath: json['request_path'] as String?,
    );
  }
}


