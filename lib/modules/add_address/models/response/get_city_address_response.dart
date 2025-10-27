import 'package:json_annotation/json_annotation.dart';

part 'get_city_address_response.g.dart';

@JsonSerializable(ignoreUnannotated: false)
/// A class representing the response for getting city address data.
class GetCityAddressResponse {
  /// Creates a [GetCityAddressResponse] with the provided values.
  GetCityAddressResponse({
    this.success,
    this.message,
    this.cityArea,
    this.eTag,
  });

  /// Creates a [GetCityAddressResponse] from a JSON map.
  factory GetCityAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCityAddressResponseFromJson(json);

  /// Indicates whether the operation was successful.
  @JsonKey(name: 'success')
  final bool? success;

  /// A message providing additional details about the response.
  @JsonKey(name: 'message')
  final String? message;

  /// A list of city area data associated with the response.
  @JsonKey(name: 'cityArea')
  final List<CityArea>? cityArea;

  /// The ETag for the city address response.
  @JsonKey(name: 'eTag')
  final String? eTag;

  /// Converts the [GetCityAddressResponse] instance to a JSON map.
  Map<String, dynamic> toJson() => _$GetCityAddressResponseToJson(this);
}

@JsonSerializable(ignoreUnannotated: false)
/// A class representing city area data used in address forms.
class CityArea {
  /// Creates a [CityArea] with the provided name.
  CityArea({
    this.name,
  });

  /// Creates a [CityArea] from a JSON map.
  factory CityArea.fromJson(Map<String, dynamic> json) =>
      _$CityAreaFromJson(json);

  /// The name of the city area.
  @JsonKey(name: 'name')
  final String? name;

  /// Converts the [CityArea] instance to a JSON map.
  Map<String, dynamic> toJson() => _$CityAreaToJson(this);
}
