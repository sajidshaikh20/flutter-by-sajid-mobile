import '../../../../utils/exports.dart';

part 'get_address_form_data_response.g.dart';

@JsonSerializable(ignoreUnannotated: false)

/// A class representing the response for getting address form data.
class GetAddressFormDataResponse {
  /// Creates a [GetAddressFormDataResponse] with the provided values.
  GetAddressFormDataResponse({
    this.success,
    this.message,
    this.addressDataModel,
    this.isCompanyVisible,
    this.isCompanyRequired,
    this.isTelephoneVisible,
    this.isTelephoneRequired,
    this.isFaxVisible,
    this.isPrefixVisible,
    this.isMiddlenameVisible,
    this.isSuffixVisible,
    this.isDOBVisible,
    this.isTaxVisible,
    this.isGenderVisible,
    this.isAddressTitleVisible,
    this.isAddressTitleRequired,
    this.countryData,
    this.countryDatas,
    this.lastname,
    this.firstname,
    this.defaultCountry,
    this.streetLineCount,
    this.allowToChooseState,
    this.eTag,
  });

  /// Creates a [GetAddressFormDataResponse] from a JSON map.
  factory GetAddressFormDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAddressFormDataResponseFromJson(json);

  /// Indicates whether the operation was successful.
  @JsonKey(name: 'success')
  final bool? success;

  /// A message providing additional details about the response.
  @JsonKey(name: 'message')
  final String? message;

  /// The address data model associated with the form.
  @JsonKey(name: 'addressData')
  final AddressDataModel? addressDataModel;

  /// Indicates whether the company field is visible in the form.
  @JsonKey(name: 'isCompanyVisible')
  final bool? isCompanyVisible;

  /// Indicates whether the company field is required in the form.
  @JsonKey(name: 'isCompanyRequired')
  final bool? isCompanyRequired;

  /// Indicates whether the telephone field is visible in the form.
  @JsonKey(name: 'isTelephoneVisible')
  final bool? isTelephoneVisible;

  /// Indicates whether the telephone field is required in the form.
  @JsonKey(name: 'isTelephoneRequired')
  final bool? isTelephoneRequired;

  /// Indicates whether the fax field is visible in the form.
  @JsonKey(name: 'isFaxVisible')
  final bool? isFaxVisible;

  /// Indicates whether the prefix field is visible in the form.
  @JsonKey(name: 'isPrefixVisible')
  final bool? isPrefixVisible;

  /// Indicates whether the middlename field is visible in the form.
  @JsonKey(name: 'isMiddlenameVisible')
  final bool? isMiddlenameVisible;

  /// Indicates whether the suffix field is visible in the form.
  @JsonKey(name: 'isSuffixVisible')
  final bool? isSuffixVisible;

  /// Indicates whether the date of birth field is visible in the form.
  @JsonKey(name: 'isDOBVisible')
  final bool? isDOBVisible;

  /// Indicates whether the tax field is visible in the form.
  @JsonKey(name: 'isTaxVisible')
  final bool? isTaxVisible;

  /// Indicates whether the gender field is visible in the form.
  @JsonKey(name: 'isGenderVisible')
  final bool? isGenderVisible;

  /// Indicates whether the address title field is visible in the form.
  @JsonKey(name: 'isAddressTitleVisible')
  final bool? isAddressTitleVisible;

  /// Indicates whether the address title field is required in the form.
  @JsonKey(name: 'isAddressTitleRequired')
  final bool? isAddressTitleRequired;

  /// A list of country data associated with the form.
  @JsonKey(name: 'countryData')
  final List<CountryData>? countryData;

  /// A list of additional country data associated with the form.
  @JsonKey(name: 'countryDatas')
  final List<CountryData>? countryDatas;

  /// The last name field in the address form.
  @JsonKey(name: 'lastname')
  final String? lastname;

  /// The first name field in the address form.
  @JsonKey(name: 'firstname')
  final String? firstname;

  /// The default country for the address form.
  @JsonKey(name: 'defaultCountry')
  final String? defaultCountry;

  /// The number of street lines in the address form.
  @JsonKey(name: 'streetLineCount')
  final int? streetLineCount;

  /// Indicates whether the state field can be chosen in the form.
  @JsonKey(name: 'allowToChooseState')
  final bool? allowToChooseState;

  /// The ETag for the address form data.
  @JsonKey(name: 'eTag')
  final String? eTag;

  /// Converts the [GetAddressFormDataResponse] instance to a JSON map.
  Map<String, dynamic> toJson() => _$GetAddressFormDataResponseToJson(this);
}

@JsonSerializable(ignoreUnannotated: false)

/// A class representing country-specific data used in address forms.
class CountryData {
  /// Creates a [CountryData] with the provided values.
  CountryData({
    this.name,
    this.countryId,
    this.isStateRequired,
    this.isZipOptional,
    this.states,
  });

  /// Creates a [CountryData] from a JSON map.
  factory CountryData.fromJson(Map<String, dynamic> json) =>
      _$CountryDataFromJson(json);

  /// The name of the country.
  @JsonKey(name: 'name')
  final String? name;

  /// The unique ID of the country.
  @JsonKey(name: 'country_id')
  final String? countryId;

  /// Indicates whether a state is required for
  /// this country in the address form.
  @JsonKey(name: 'isStateRequired')
  final bool? isStateRequired;

  /// Indicates whether the zip code is optional for this country.
  @JsonKey(name: 'isZipOptional')
  final bool? isZipOptional;

  /// A list of states associated with this country.
  @JsonKey(name: 'states')
  final List<States>? states;

  /// Converts the [CountryData] instance to a JSON map.
  Map<String, dynamic> toJson() => _$CountryDataToJson(this);
}

@JsonSerializable(ignoreUnannotated: false)

/// A class representing state-specific data used in address forms.
class States {
  /// Creates a [States] with the provided values.
  States({
    this.code,
    this.name,
    this.regionId,
  });

  /// Creates a [States] from a JSON map.
  factory States.fromJson(Map<String, dynamic> json) => _$StatesFromJson(json);

  /// The code representing the state.
  @JsonKey(name: 'code')
  final String? code;

  /// The name of the state.
  @JsonKey(name: 'name')
  final String? name;

  /// The region ID associated with the state.
  @JsonKey(name: 'region_id')
  final String? regionId;

  /// Converts the [States] instance to a JSON map.
  Map<String, dynamic> toJson() => _$StatesToJson(this);
}
