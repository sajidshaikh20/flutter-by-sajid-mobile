import '../../../../../utils/exports.dart';

/// A model class representing a home page response.
class HomeModel {
  /// Creates an instance of [HomeModel].
  HomeModel({this.success, this.carousel, this.offer});

  /// Creates an instance of [HomeModel] from a JSON map.
  HomeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['carousel'] != null) {
      carousel = <Carousel>[];
      for (final dynamic v in json['carousel'] as List<dynamic>) {
        carousel!.add(Carousel.fromJson(v as Map<String, dynamic>));
      }
    }

    offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
  }

  /// Indicates whether the operation was successful.
  bool? success;

  /// A list of carousel items.
  List<Carousel>? carousel;

  /// An offer associated with the home page.
  Offer? offer;

  /// Converts the [HomeModel] instance into a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (carousel != null) {
      data['carousel'] = carousel!.map((Carousel v) => v.toJson()).toList();
    }
    if (offer != null) {
      data['offer'] = offer!.toJson();
    }
    return data;
  }

  /// Returns a new [HomeModel] instance with updated values.
  HomeModel copyWith({bool? success, List<Carousel>? carousel, Offer? offer}) =>
      HomeModel(
        success: success ?? this.success,
        carousel: carousel ?? this.carousel,
        offer: offer ?? this.offer,
      );
}

/// A class that represents a carousel, which may contain images, products,
/// and other media for display in a carousel widget.
class Carousel {
  /// Creates a new [Carousel] object with optional properties.
  Carousel({
    this.id,
    this.type,
    this.label,
    this.redirectUrl,
    this.productList,
    this.imageList,
    this.webImageList,
    this.desktopImageList,
  });

  /// Creates a new [Carousel] from a JSON object.
  Carousel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    label = json['label'];
    redirectUrl = json['redirectUrl'];
    if (json['productList'] != null) {
      productList = <ProductList>[];
      for (final dynamic v in json['productList'] as List<dynamic>) {
        productList!.add(ProductList.fromJson(v as Map<String, dynamic>));
      }
    }

    if (json['imageList'] != null) {
      imageList = <ImageList>[];
      for (final dynamic v in json['imageList'] as List<dynamic>) {
        imageList!.add(ImageList.fromJson(v as Map<String, dynamic>));
      }
    }

    if (json['webImageList'] != null) {
      webImageList = <WebImageList>[];
      for (final dynamic v in json['webImageList'] as List<dynamic>) {
        webImageList!.add(WebImageList.fromJson(v as Map<String, dynamic>));
      }
    }

    if (json['desktopImageList'] != null) {
      desktopImageList = <DesktopImageList>[];
      for (final dynamic v in json['desktopImageList'] as List<dynamic>) {
        desktopImageList!.add(DesktopImageList.fromJson(v as Map<String, dynamic>));
      }
    }

  }

  /// The unique identifier for the carousel.
  String? id;

  /// The type of the carousel, e.g., 'image', 'product', etc.
  String? type;

  /// The label or title of the carousel.
  String? label;

  /// The URL to redirect when the carousel is clicked.
  String? redirectUrl;

  /// The list of products in the carousel, if applicable.
  List<ProductList>? productList;

  /// The list of images in the carousel, if applicable.
  List<ImageList>? imageList;

  /// The list of web-specific images in the carousel, if applicable.
  List<WebImageList>? webImageList;

  /// The list of desktop-specific images in the carousel, if applicable.
  List<DesktopImageList>? desktopImageList;

  /// Converts the [Carousel] object to a JSON object.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['label'] = label;
    data['redirectUrl'] = redirectUrl;
    if (productList != null) {
      data['productList'] = productList!.map((ProductList v) => v.toJson()).toList();
    }
    if (imageList != null) {
      data['imageList'] = imageList!.map((ImageList v) => v.toJson()).toList();
    }
    if (webImageList != null) {
      data['webImageList'] = webImageList!.map((WebImageList v) => v.toJson()).toList();
    }
    if (desktopImageList != null) {
      data['desktopImageList'] =
          desktopImageList!.map((DesktopImageList v) => v.toJson()).toList();
    }
    return data;
  }

  /// Creates a copy of the current [Carousel] object with optional new values.
  ///
  /// Any value that is not passed will be copied from the current object.
  Carousel copyWith({
    String? id,
    String? type,
    String? label,
    String? redirectUrl,
    List<ProductList>? productList,
    List<ImageList>? imageList,
    List<WebImageList>? webImageList,
    List<DesktopImageList>? desktopImageList,
  }) =>
      Carousel(
        id: id ?? this.id,
        type: type ?? this.type,
        label: label ?? this.label,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        productList: productList ?? this.productList,
        imageList: imageList ?? this.imageList,
        webImageList: webImageList ?? this.webImageList,
        desktopImageList: desktopImageList ?? this.desktopImageList,
      );
}

/// A model class representing an image list for the desktop.
class DesktopImageList {
  /// Creates an instance of [DesktopImageList].
  DesktopImageList({
    this.url,
    this.redirectUrl,
    this.bannerType,
    this.id,
    this.label,
  });

  /// Creates an instance of [DesktopImageList] from a JSON map.
  DesktopImageList.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    redirectUrl = json['redirectUrl'];
    bannerType = json['bannerType'];
    id = json['id'];
    label = json['label'];
  }

  /// The label of the image.
  String? label;

  /// The URL of the image.
  String? url;

  /// The URL to redirect when the image is clicked.
  String? redirectUrl;

  /// The type of banner (e.g., promotional, feature).
  String? bannerType;

  /// The unique identifier of the image.
  String? id;

  /// Converts the [DesktopImageList] instance into a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['redirectUrl'] = redirectUrl;
    data['bannerType'] = bannerType;
    data['id'] = id;
    data['label'] = label;
    return data;
  }

  /// Returns a new [DesktopImageList] instance with updated values.
  ///
  /// If a field is not provided, it will default to the current value.
  DesktopImageList copyWith({
    String? url,
    String? redirectUrl,
    String? bannerType,
    String? id,
    String? label,
  }) =>
      DesktopImageList(
        url: url ?? this.url,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        bannerType: bannerType ?? this.bannerType,
        id: id ?? this.id,
        label: label ?? this.label,
      );
}

/// A model class representing an image in the image list.
class ImageList {
  /// Creates an instance of [ImageList].
  ImageList({
    this.url,
    this.dominantColor,
    this.bannerType,
    this.id,
    this.name,
  });

  /// Creates an instance of [ImageList] from a JSON map.
  ImageList.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    dominantColor = json['dominantColor'];
    bannerType = json['bannerType'];
    id = json['id'];
    name = json['name'];
  }

  /// The URL of the image.
  String? url;

  /// The dominant color of the image.
  String? dominantColor;

  /// The type of banner associated with the image (e.g., promotional, feature).
  String? bannerType;

  /// The unique identifier for the image.
  String? id;

  /// The name of the image or banner.
  String? name;

  /// Converts the [ImageList] instance into a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['dominantColor'] = dominantColor;
    data['bannerType'] = bannerType;
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  /// Returns a new [ImageList] instance with updated values.
  ImageList copyWith({
    String? url,
    String? dominantColor,
    String? bannerType,
    String? id,
    String? name,
  }) =>
      ImageList(
        url: url ?? this.url,
        dominantColor: dominantColor ?? this.dominantColor,
        bannerType: bannerType ?? this.bannerType,
        id: id ?? this.id,
        name: name ?? this.name,
      );
}

/// A model class representing an image list for the web.
class WebImageList {
  /// Creates an instance of [WebImageList].
  WebImageList({
    this.label,
    this.url,
    this.redirectUrl,
    this.bannerType,
    this.id,
  });

  /// Creates an instance of [WebImageList] from a JSON map.
  WebImageList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    url = json['url'];
    redirectUrl = json['redirectUrl'];
    bannerType = json['bannerType'];
    id = json['id'];
  }

  /// The label of the image.
  String? label;

  /// The URL of the image.
  String? url;

  /// The URL to redirect when the image is clicked.
  String? redirectUrl;

  /// The type of banner (e.g., promotional, feature).
  String? bannerType;

  /// The unique identifier of the image.
  String? id;

  /// Converts the [WebImageList] instance into a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['url'] = url;
    data['redirectUrl'] = redirectUrl;
    data['bannerType'] = bannerType;
    data['id'] = id;
    return data;
  }

  /// Returns a new [WebImageList] instance with updated values.
  WebImageList copyWith({
    String? label,
    String? url,
    String? redirectUrl,
    String? bannerType,
    String? id,
  }) =>
      WebImageList(
        label: label ?? this.label,
        url: url ?? this.url,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        bannerType: bannerType ?? this.bannerType,
        id: id ?? this.id,
      );
}

/// A model class representing an offer.
class Offer {
  /// Creates an instance of [Offer].
  Offer({this.label, this.id});

  /// Creates an instance of [Offer] from a JSON map.
  Offer.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    id = json['id'];
  }

  /// The label associated with the offer.
  String? label;

  /// The unique identifier of the offer.
  String? id;

  /// Converts the [Offer] instance into a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['id'] = id;
    return data;
  }

  /// Returns a new [Offer] instance with updated values.
  Offer copyWith({String? label, String? id}) => Offer(
        label: label ?? this.label,
        id: id ?? this.id,
      );
}
