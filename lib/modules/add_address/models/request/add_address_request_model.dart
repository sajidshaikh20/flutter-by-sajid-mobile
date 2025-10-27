import 'package:json_annotation/json_annotation.dart';

part 'add_address_request_model.g.dart';

@JsonSerializable(ignoreUnannotated: false)

/// Model class for creating an address request.
class AddAddressRequestModel {
  /// Constructor for the `AddAddressRequestModel` class.
  AddAddressRequestModel({
    this.websiteId,
    this.storeId,
    this.customerToken,
    this.addressId,
    this.addressData,
  });

  /// Creates an instance of `AddAddressRequestModel` from JSON.
  factory AddAddressRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddAddressRequestModelFromJson(json);

  /// The website ID associated with the address request.
  @JsonKey(name: 'websiteId')
  final String? websiteId;

  /// The store ID associated with the address request.
  @JsonKey(name: 'storeId')
  final String? storeId;

  /// The customer token for the address request.
  @JsonKey(name: 'customerToken')
  final String? customerToken;

  /// The address ID for editing an existing address.
  @JsonKey(name: 'addressId')
  final String? addressId;

  /// The address data in JSON string format.
  @JsonKey(name: 'addressData')
  final String? addressData;

  /// Converts the `AddAddressRequestModel` instance to JSON format.
  Map<String, dynamic> toJson() => _$AddAddressRequestModelToJson(this);
}

@JsonSerializable(ignoreUnannotated: false)

/// Model class for adding address data.
class AddressDataToAdd {
  /// Constructor for the `AddressDataToAdd` class.
  AddressDataToAdd({
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.company,
    this.mobileNumberPrefix,
    this.addressTitle,
    this.street,
    this.city,
    this.regionId,
    this.region,
    this.latitude,
    this.longitude,
    this.countryId,
    this.defaultBilling,
    this.defaultShipping,
    this.saveInAddressBook,
    this.postcode,
  });

  /// Creates an instance of `AddressDataToAdd` from JSON.
  factory AddressDataToAdd.fromJson(Map<String, dynamic> json) =>
      _$AddressDataToAddFromJson(json);

  /// The first name associated with the address.
  @JsonKey(name: 'firstName')
  final String? firstName;

  /// The last name associated with the address.
  @JsonKey(name: 'lastName')
  final String? lastName;

  /// The mobile number associated with the address.
  @JsonKey(name: 'mobileNumber')
  final String? mobileNumber;

  /// The prefix for the mobile number (e.g., country code).
  @JsonKey(name: 'mobileNumberPrefix')
  final String? mobileNumberPrefix;

  /// The address title (e.g., "Home", "Office").
  @JsonKey(name: 'address_title')
  final String? addressTitle;

  /// A list of street addresses.
  @JsonKey(name: 'street')
  final List<String>? street;

  /// The city associated with the address.
  @JsonKey(name: 'city')
  final String? city;

  /// The region ID associated with the address.
  @JsonKey(name: 'region_id')
  final String? regionId;

  /// The region name associated with the address.
  @JsonKey(name: 'region')
  final String? region;

  /// The latitude of the address location.
  @JsonKey(name: 'latitude')
  final String? latitude;

  /// The longitude of the address location.
  @JsonKey(name: 'longitude')
  final String? longitude;

  /// The country ID associated with the address.
  @JsonKey(name: 'country_id')
  final String? countryId;

  /// Indicates if the address is the default billing address.
  @JsonKey(name: 'default_billing')
  final String? defaultBilling;

  /// Indicates if the address is the default shipping address.
  @JsonKey(name: 'default_shipping')
  final String? defaultShipping;

  /// Indicates if the address should be saved in the address book.
  @JsonKey(name: 'saveInAddressBook')
  final String? saveInAddressBook;

  /// The postal code associated with the address.
  @JsonKey(name: 'postcode')
  final String? postcode;

  /// The company name associated with the address.
  @JsonKey(name: 'company')
  final String? company;

  /// Converts the `AddressDataToAdd` instance to JSON format.
  Map<String, dynamic> toJson() => _$AddressDataToAddToJson(this);
}
