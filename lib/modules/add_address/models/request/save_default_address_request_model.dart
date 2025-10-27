import 'package:json_annotation/json_annotation.dart';

part 'save_default_address_request_model.g.dart';

@JsonSerializable(ignoreUnannotated: false)

/// Model class representing the request data to save a default address.
class SaveDefaultAddressRequestModel {
  /// Constructor for [SaveDefaultAddressRequestModel].
  /// Initializes the object with optional parameters for setting default
  /// billing, shipping, and other address-related data.
  SaveDefaultAddressRequestModel({
    this.setIsDefaultBilling,
    this.storeId,
    this.websiteId,
    this.customerToken,
    this.addressId,
    this.setIsDefaultShipping,
  });

  /// Creates a [SaveDefaultAddressRequestModel] instance from a [json] map.
  factory SaveDefaultAddressRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SaveDefaultAddressRequestModelFromJson(json);

  /// Flag indicating if the address should be set the default billing address.
  @JsonKey(name: 'setIsDefaultBilling')
  final String? setIsDefaultBilling;

  /// The store identifier.
  @JsonKey(name: 'storeId')
  final String? storeId;

  /// The website identifier.
  @JsonKey(name: 'websiteId')
  final String? websiteId;

  /// The customer token for the request.
  @JsonKey(name: 'customerToken')
  final String? customerToken;

  /// The address identifier.
  @JsonKey(name: 'addressId')
  final String? addressId;

  /// Flag indicating if the address should be set as
  /// the default shipping address.
  @JsonKey(name: 'setIsDefaultShipping')
  final String? setIsDefaultShipping;

  /// Converts the [SaveDefaultAddressRequestModel] instance to a JSON map.
  Map<String, dynamic> toJson() => _$SaveDefaultAddressRequestModelToJson(this);
}
