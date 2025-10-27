import '/utils/exports.dart';

/// Enum representing different types of banner items.
enum BannerItemType {
  /// Category type banner.
  category('category'),

  /// Product type banner.
  product('product'),

  /// Brand type banner.
  brand('brand'),

  /// URL type banner.
  url('url');

  /// Creates a banner item type.
  const BannerItemType(this.value);

  /// The string value of the banner type.
  final String value;
}

/// Model class for banner response data.
class BannerResponseModel {
  /// The type of banner.
  final String? type;

  /// List of banner items.
  final List<BannersListModel> bannersListModel;

  /// Creates an instance of [BannerResponseModel].
  BannerResponseModel({
    this.type,
    this.bannersListModel = const <BannersListModel>[],
  });
  ///fromJson
  factory BannerResponseModel.fromJson(Map<String, dynamic> json) {
    List<BannersListModel> bannersList = <BannersListModel>[];

    if (json['banners'] != null) {
      final dynamic bannersListData = json['banners'];

      if (bannersListData is List) {
        for (int i = 0; i < bannersListData.length; i++) {
          final dynamic item = bannersListData[i];

          if (item is Map<String, dynamic>) {
            final BannersListModel banners = BannersListModel.fromJson(item);
            bannersList.add(banners);
          }
        }
      }
    }

    final BannerResponseModel result = BannerResponseModel(
      type: json['type'] as String?,
      bannersListModel: bannersList,
    );
    return result;
  }
}

/// Model class for individual banner items in the banner list.
class BannersListModel {
  /// The mobile URL for the banner image.
  final String? mobileUrl;

  /// The type of the banner.
  final String? bannerType;

  /// The unique identifier of the banner.
  final int? id;

  /// Category data associated with the banner (can be List<> or String).
  final dynamic category;

  /// URL associated with the banner.
  final String? url;

  /// Brand data associated with the banner (can be List<> or String).
  final dynamic brand;

  /// Product list data associated with the banner (can be List<> or String).
  final dynamic productListModel;

  /// Creates an instance of [BannersListModel].
  BannersListModel({
    this.mobileUrl,
    this.bannerType,
    this.id,
    this.category,
    this.url,
    this.brand,
    this.productListModel,
  });
///fromJson
  factory BannersListModel.fromJson(Map<String, dynamic> json) {
    final String? mobileUrl = json['mobile_url'] as String?;
    final String? bannerType = json['bannerType'] as String?;
    final int? id = json['id'] as int?;
    final String? url = json['url'] as String?;

    // Parse category
    dynamic categoryData;
    if (json['category'] != null &&
        json['category'] != 'null' &&
        json['category'] != '') {
      if (json['category'] is List) {
        List<CategoryResponseModel> categoryList = (json['category']
                as List<dynamic>)
            .map((dynamic item) =>
                CategoryResponseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        categoryData = categoryList;
      } else {
        categoryData = json['category'] as String;
      }
    }

    /// Parse brand
    dynamic brandData;
    if (json['brand'] != null &&
        json['brand'] != 'null' &&
        json['brand'] != '') {
      if (json['brand'] is List) {
        List<ListOfBrandsResponse> brandList = (json['brand'] as List<dynamic>)
            .map((dynamic item) =>
                ListOfBrandsResponse.fromJson(item as Map<String, dynamic>))
            .toList();
        brandData = brandList;
      } else {
        brandData = json['brand'] as String;
      }
    }

    // Parse product
    dynamic productData;
    if (json['product'] != null &&
        json['product'] != 'null' &&
        json['product'] != '') {
      if (json['product'] is List) {
        List<ProductListingResponse> productList = (json['product']
                as List<dynamic>)
            .map((dynamic item) =>
                ProductListingResponse.fromJson(item as Map<String, dynamic>))
            .toList();
        productData = productList;
      } else {
        productData = json['product'] as String;
      }
    }

    final BannersListModel result = BannersListModel(
      mobileUrl: mobileUrl,
      bannerType: bannerType,
      id: id,
      category: categoryData,
      url: url,
      brand: brandData,
      productListModel: productData,
    );

    return result;
  }
}
