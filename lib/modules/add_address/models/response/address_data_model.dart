import '../../../../utils/exports.dart';

part 'address_data_model.g.dart';

@JsonSerializable(ignoreUnannotated: false)

/// Model class representing address data with various attributes.
class AddressDataModel {
  /// Constructor for [AddressDataModel] that initializes all attributes.
  AddressDataModel({
    this.firstname,
    this.mobilenumber,
    this.city,
    this.prefix,
    this.createdAt,
    this.suffix,
    this.vatRequestDate,
    this.vatRequestId,
    this.updatedAt,
    this.addressTitle,
    this.incrementId,
    this.street,
    this.vatRequestSuccess,
    this.vatId,
    this.company,
    this.fax,
    this.isDefaultShipping,
    this.isActive,
    this.postcode,
    this.regionId,
    this.middlename,
    this.telephone,
    this.entityId,
    this.mobileNumberPrefix,
    this.lastname,
    this.parentId,
    this.vatIsValid,
    this.region,
    this.countryId,
  });

  /// Creates an [AddressDataModel] instance from a [json] map.
  factory AddressDataModel.fromJson(Map<String, dynamic> json) =>
      _$AddressDataModelFromJson(json);

  /// First name of the person associated with the address.
  @JsonKey(name: 'firstname')
  final String? firstname;

  /// Mobile number of the person associated with the address.
  @JsonKey(name: 'mobilenumber')
  final String? mobilenumber;

  /// City of the address.
  @JsonKey(name: 'city')
  final String? city;

  /// Prefix for the person's name (e.g., Mr, Mrs).
  @JsonKey(name: 'prefix')
  final String? prefix;

  /// The date when the address was created.
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  /// Suffix for the person's name (e.g., Jr, Sr).
  @JsonKey(name: 'suffix')
  final String? suffix;

  /// The date when the VAT request was made.
  @JsonKey(name: 'vat_request_date')
  final String? vatRequestDate;

  /// The ID associated with the VAT request.
  @JsonKey(name: 'vat_request_id')
  final String? vatRequestId;

  /// The date when the address was last updated.
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  /// Title of the address (e.g., Home, Office).
  @JsonKey(name: 'address_title')
  final String? addressTitle;

  /// Increment ID for the address.
  @JsonKey(name: 'increment_id')
  final String? incrementId;

  /// List of street addresses for this address.
  @JsonKey(name: 'street')
  final List<String>? street;

  /// Status of VAT request (success or failure).
  @JsonKey(name: 'vat_request_success')
  final String? vatRequestSuccess;

  /// VAT ID associated with the address.
  @JsonKey(name: 'vat_id')
  final String? vatId;

  /// Company name associated with the address.
  @JsonKey(name: 'company')
  final String? company;

  /// Fax number associated with the address.
  @JsonKey(name: 'fax')
  final String? fax;

  /// Flag indicating if this is the default shipping address.
  @JsonKey(name: 'isDefaultShipping')
  final bool? isDefaultShipping;

  /// Flag indicating if the address is active.
  @JsonKey(name: 'is_active')
  final String? isActive;

  /// Postal code for the address.
  @JsonKey(name: 'postcode')
  final String? postcode;

  /// Region ID for the address.
  @JsonKey(name: 'region_id')
  final String? regionId;

  /// Middle name of the person associated with the address.
  @JsonKey(name: 'middlename')
  final String? middlename;

  /// Telephone number associated with the address.
  @JsonKey(name: 'telephone')
  final String? telephone;

  /// Entity ID associated with the address.
  @JsonKey(name: 'entity_id')
  final String? entityId;

  /// Mobile number prefix for the address.
  @JsonKey(name: 'mobileNumberPrefix')
  final String? mobileNumberPrefix;

  /// Last name of the person associated with the address.
  @JsonKey(name: 'lastname')
  final String? lastname;

  /// Parent ID associated with the address.
  @JsonKey(name: 'parent_id')
  final String? parentId;

  /// Flag indicating if the VAT is valid.
  @JsonKey(name: 'vat_is_valid')
  final String? vatIsValid;

  /// Region name for the address.
  @JsonKey(name: 'region')
  final String? region;

  /// Country ID for the address.
  @JsonKey(name: 'country_id')
  final String? countryId;

  /// Converts the [AddressDataModel] instance to a JSON map.
  Map<String, dynamic> toJson() => _$AddressDataModelToJson(this);
}
