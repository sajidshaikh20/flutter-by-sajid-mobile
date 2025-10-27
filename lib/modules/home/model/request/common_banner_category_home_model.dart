/// A model class representing common banner category details for the home page.
class CommonBannerCategoryHomeModel {
  /// Creates an instance of [CommonBannerCategoryHomeModel].
  CommonBannerCategoryHomeModel({
    this.website,
    this.store,
  });

  /// Creates an instance of [CommonBannerCategoryHomeModel] from a JSON map.
  factory CommonBannerCategoryHomeModel.fromJson(Map<String, dynamic> json) =>
      CommonBannerCategoryHomeModel(
        website: json['website'],
        store: json['store'],
      );

  /// The website associated with the banner category.
  String? website;

  /// The store associated with the banner category.
  String? store;

  /// Converts the [CommonBannerCategoryHomeModel] instance into a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'website': website,
        'store': store,
      };
}
