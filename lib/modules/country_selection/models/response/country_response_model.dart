import '../../../../utils/exports.dart';

/// A model class representing the response for the country data.
/// It includes a success status and a list of [CountryModel] objects.
class CountryResponseModel {
  /// Constructor for creating an instance of [CountryResponseModel].
  /// It initializes the success status and an optional list of
  /// [CountryModel] objects.
  CountryResponseModel({this.success, this.countryList});

  /// Factory constructor for creating an instance of
  /// [CountryResponseModel] from a JSON object.
  /// It initializes the success status and, if present,
  /// parses the country list into a list of [CountryModel] instances.
  CountryResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['countryList'] != null) {
      countryList = (json['countryList'] as List<dynamic>)
          .map(
            (dynamic v) => CountryModel.fromJson(v),
          )
          .toList();
    }
  }

  /// A boolean indicating whether the response was successful or not.
  bool? success;

  /// A list of [CountryModel] objects representing
  /// the countries returned in the response.
  List<CountryModel>? countryList;

  /// Converts the current instance of [CountryResponseModel] to a JSON object.
  /// It serializes the success status and the country
  /// list into a JSON-compatible format.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (countryList != null) {
      data['countryList'] =
          countryList!.map((CountryModel v) => v.toJson()).toList();
    }
    return data;
  }
}
