/// Model class for language request parameters.
class LanguageRequestModel {
  /// The website identifier.
  String? website;

  /// The store identifier.
  String? store;

  /// Creates a new instance of [LanguageRequestModel].
  ///
  /// All parameters are optional and can be null.
  LanguageRequestModel({this.website, this.store});

  /// Creates a [LanguageRequestModel] instance from a JSON map.
  LanguageRequestModel.fromJson(Map<String, dynamic> json) {
    website = json['website'];
    store = json['store'];
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['website'] = website;
    data['store'] = store;
    return data;
  }
}
