import 'package:json_annotation/json_annotation.dart';

part 'get_city_address_request_model.g.dart';

@JsonSerializable(ignoreUnannotated: false)
/// Model class representing the request data to get city address information.
class GetCityAddressRequestModel {

  /// Constructor for [GetCityAddressRequestModel].
  /// Initializes the object with optional parameters for [websiteId],
  /// [storeId], [customerToken], [fieldId], and [regionId].
  GetCityAddressRequestModel({
    this.websiteId,
    this.storeId,
    this.customerToken,
    this.fieldId,
    this.regionId,
  });

  /// Creates a [GetCityAddressRequestModel] instance from a [json] map.
  factory GetCityAddressRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GetCityAddressRequestModelFromJson(json);

  /// The website identifier.
  @JsonKey(name: 'websiteId')
  final String? websiteId;

  /// The store identifier.
  @JsonKey(name: 'storeId')
  final String? storeId;

  /// The customer token for the request.
  @JsonKey(name: 'customerToken')
  final String? customerToken;

  /// The field identifier for the city address request.
  @JsonKey(name: 'fieldId')
  final String? fieldId;

  /// The region identifier for the city address.
  @JsonKey(name: 'regionId')
  final String? regionId;

  /// Converts the [GetCityAddressRequestModel] instance to a JSON map.
  Map<String, dynamic> toJson() => _$GetCityAddressRequestModelToJson(this);
}
