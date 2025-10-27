/// Represents the request for the home detail banner with necessary parameters.
class HomeDetailBannerRequest {
  /// Constructs a [HomeDetailBannerRequest] with an optional [website] parameter.
  HomeDetailBannerRequest({this.website});

  /// Creates a [HomeDetailBannerRequest] from a JSON map.
  HomeDetailBannerRequest.fromJson(Map<String, dynamic> json) {
    website = json['website'];
  }

  /// The website identifier for the request.
  String? website;

  /// Converts the [HomeDetailBannerRequest] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['website'] = website;
    return data;
  }
}
