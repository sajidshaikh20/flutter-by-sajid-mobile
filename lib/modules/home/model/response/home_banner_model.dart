/// Represents the model for home banner data with a list of [Banners].
class HomeBannerModel {
  /// A list of [Banners] to represent the home page banners.
  List<Banners>? banners;

  /// Constructs a [HomeBannerModel] with an optional [banners] parameter.
  HomeBannerModel({this.banners});

  /// Creates a [HomeBannerModel] from a JSON map.
  HomeBannerModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[]; // Explicitly declaring as List<Banners>
      for (final dynamic v in json['banners']) {
        banners!.add(Banners.fromJson(v as Map<String, dynamic>));
      }
    }
  }

  /// Converts the [HomeBannerModel] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (banners != null) {
      data['banners'] = banners!.map((Banners v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Represents individual banner data with properties like URL, title, etc.
class Banners {
  /// Constructs a [Banners] with optional parameters for the banner details.
  Banners({
    this.url,
    this.mobileUrl,
    this.title,
    this.bannerType,
    this.dominantColor,
    this.id,
    this.name,
    this.baseUrl,
  });

  /// Creates a [Banners] instance from a JSON map.
  Banners.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    mobileUrl = json['mobileUrl'];
    title = json['title'];
    bannerType = json['bannerType'];
    dominantColor = json['dominantColor'];
    id = json['id'];
    name = json['name'];
    baseUrl = json['baseUrl'];
  }

  /// The URL of the banner image.
  String? url;

  /// The mobile URL of the banner image.
  String? mobileUrl;

  /// The title of the banner.
  String? title;

  /// The type of the banner.
  String? bannerType;

  /// The dominant color of the banner.
  String? dominantColor;

  /// The unique identifier for the banner.
  String? id;

  /// The name of the banner.
  String? name;

  /// The base URL for the banner.
  String? baseUrl;

  /// Converts the [Banners] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['mobileUrl'] = mobileUrl;
    data['title'] = title;
    data['bannerType'] = bannerType;
    data['dominantColor'] = dominantColor;
    data['id'] = id;
    data['name'] = name;
    data['baseUrl'] = baseUrl;
    return data;
  }
}
