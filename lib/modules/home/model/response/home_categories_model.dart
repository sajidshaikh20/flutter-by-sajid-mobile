import '../../../../utils/exports.dart';

/// Represents the model for home categories with a success status and a list of [Categories].
class HomeCategoriesModel {
  /// A flag indicating if the request was successful.
  bool? success;

  /// A list of [Categories] representing the categories on the home page.
  List<Categories>? categories;

  /// Constructs a [HomeCategoriesModel] with an optional [success] and [categories] parameter.
  HomeCategoriesModel({
    this.success,
    this.categories,
  });

  /// Creates a [HomeCategoriesModel] from a JSON map.
  HomeCategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      for (final dynamic v in json['categories'] as List<dynamic>) {
        categories!.add(Categories.fromJson(v as Map<String, dynamic>));
      }
    }
  }

  /// Converts the [HomeCategoriesModel] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (categories != null) {
      data['categories'] =
          categories!.map((Categories v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Represents an individual category with properties like order, name, and child categories.
class Categories {
  /// The custom order of the category.
  int? customCatOrder;

  /// The request path for the category.
  String? requestPath;

  /// The unique identifier for the category.
  int? categoryId;

  /// The name of the category.
  String? categoryName;

  /// The URL associated with the category.
  String? url;

  /// A flag indicating if the category has child categories.
  bool? hasChildren;

  /// A list of [ChildCategories] if the category has children.
  List<ChildCategories>? childCategories;

  /// Constructs a [Categories] with optional parameters for category details.
  Categories({
    this.customCatOrder,
    this.requestPath,
    this.categoryId,
    this.categoryName,
    this.url,
    this.hasChildren,
    this.childCategories,
  });

  /// Creates a [Categories] instance from a JSON map.
  Categories.fromJson(Map<String, dynamic> json) {
    customCatOrder = json['custom_cat_order'];
    requestPath = json['request_path'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    url = json['url'];
    hasChildren = json['hasChildren'];

    if (json['childCategories'] != null) {
      childCategories = <ChildCategories>[];
      for (final dynamic v in json['childCategories'] as List<dynamic>) {
        childCategories!
            .add(ChildCategories.fromJson(v as Map<String, dynamic>));
      }
    }
  }

  /// Converts the [Categories] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['custom_cat_order'] = customCatOrder;
    data['request_path'] = requestPath;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['url'] = url;
    data['hasChildren'] = hasChildren;
    if (childCategories != null) {
      data['childCategories'] =
          childCategories!.map((ChildCategories v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Represents a product category with its ID and name.
class ProductCategories {
  /// The unique identifier for the product category.
  String? categoryId;

  /// The name of the product category.
  String? name;

  /// Constructs a [ProductCategories] with optional [categoryId] and [name] parameters.
  ProductCategories({this.categoryId, this.name});

  /// Creates a [ProductCategories] from a JSON map.
  ProductCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    name = json['name'];
  }

  /// Converts the [ProductCategories] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['name'] = name;
    return data;
  }
}

/*class ChildCategories {
  String? categoryId;
  String? categoryName;
  String? url;
  String? requestPath;

  ChildCategories(
      {this.categoryId, this.categoryName, this.url, this.requestPath});

  ChildCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    url = json['url'];
    requestPath = json['request_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['url'] = url;
    data['request_path'] = requestPath;
    return data;
  }
}*/
