// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_listing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryListingResponse _$CategoryListingResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryListingResponse(
      categoriesData: json['categoriesData'] == null
          ? null
          : CategoriesData.fromJson(
              json['categoriesData'] as Map<String, dynamic>),
      childCategories: (json['childCategories'] as List<dynamic>?)
          ?.map((e) => ChildCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
      productList: (json['productList'] as List<dynamic>?)
          ?.map((e) => ProductList.fromJson(e as Map<String, dynamic>))
          .toList(),
      layeredData: (json['layeredData'] as List<dynamic>?)
          ?.map((e) => LayeredData.fromJson(e as Map<String, dynamic>))
          .toList(),
      sortingData: (json['sortingData'] as List<dynamic>?)
          ?.map((e) => SortingData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryListingResponseToJson(
        CategoryListingResponse instance) =>
    <String, dynamic>{
      'categoriesData': instance.categoriesData,
      'childCategories': instance.childCategories,
      'productList': instance.productList,
      'sortingData': instance.sortingData,
      'layeredData': instance.layeredData,
      'totalCount': instance.totalCount,
      'size': instance.size,
      'pagination': instance.pagination,
    };
