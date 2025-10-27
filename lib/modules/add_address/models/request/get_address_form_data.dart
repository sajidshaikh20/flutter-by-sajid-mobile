import 'package:json_annotation/json_annotation.dart';

part 'get_address_form_data.g.dart';

@JsonSerializable(ignoreUnannotated: false)
/// Model class representing the data required to get address form data.
class GetAddressFormData {

  /// Constructor for [GetAddressFormData].
  /// Initializes the object with optional parameters for [eTag], [websiteId],
  /// [storeId], [customerToken], and [addressId].
  GetAddressFormData({
    this.eTag,
    this.websiteId,
    this.storeId,
    this.customerToken,
    this.addressId,
  });

  /// Creates a [GetAddressFormData] instance from a [json] map.
  factory GetAddressFormData.fromJson(Map<String, dynamic> json) =>
      _$GetAddressFormDataFromJson(json);

  /// The entity tag (ETag) for the address data.
  @JsonKey(name: 'eTag')
  final String? eTag;

  /// The website identifier.
  @JsonKey(name: 'websiteId')
  final String? websiteId;

  /// The store identifier.
  @JsonKey(name: 'storeId')
  final String? storeId;

  /// The customer token for the request.
  @JsonKey(name: 'customerToken')
  final String? customerToken;

  /// The address identifier for the requested address form data.
  @JsonKey(name: 'addressId')
  final String? addressId;

  /// Converts the [GetAddressFormData] instance to a JSON map.
  Map<String, dynamic> toJson() => _$GetAddressFormDataToJson(this);
}
