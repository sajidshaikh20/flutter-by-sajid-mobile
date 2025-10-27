/// Represents the model for home notices, which contains a list of [Notice] items.
class HomeNoticeModel {
  /// A list of [Notice] representing home notices.
  List<Notice>? notice;

  /// Constructs a [HomeNoticeModel] with an optional [notice] parameter.
  HomeNoticeModel({this.notice});

  /// Creates a [HomeNoticeModel] from a JSON map.
  HomeNoticeModel.fromJson(Map<String, dynamic> json) {
    if (json['notice'] != null) {
      notice = <Notice>[];
      for (final dynamic v in json['notice'] as List<dynamic>) {
        notice!.add(Notice.fromJson(v as Map<String, dynamic>));
      }
    }
  }

  /// Converts the [HomeNoticeModel] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (notice != null) {
      data['notice'] = notice!.map((Notice v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Represents an individual notice with an image and text.
class Notice {
  /// The URL of the image for the notice.
  String? image;

  /// The text content of the notice.
  String? text;

  /// Constructs a [Notice] with optional [image] and [text] parameters.
  Notice({this.image, this.text});

  /// Creates a [Notice] from a JSON map.
  Notice.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    text = json['text'];
  }

  /// Converts the [Notice] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['text'] = text;
    return data;
  }
}
