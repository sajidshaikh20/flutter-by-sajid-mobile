import '../../../../utils/exports.dart';

/// A model class representing a country.
/// It contains various fields such as country details,
/// contact information, and address form data.
class CountryModel {
  /// Constructor for creating an instance of [CountryModel].
  CountryModel({
    this.websiteId,
    this.store,
    this.countryId,
    this.countryName,
    this.countryFlag,
    this.contactUs,
    this.countryCode,
    this.addressFormData,
    this.arabicName, // ✅ New field
  });

  /// Factory constructor for creating an instance
  /// of [CountryModel] from a JSON object.
  /// It initializes all fields and can parse nested models like
  /// [ContactUsModel] and [AddressFormModel].
  CountryModel.fromJson(Map<String, dynamic> json) {
    websiteId = json['websiteId'];
    store = json['store'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    countryFlag = json['countryFlag'];
    contactUs = json['contactUs'] != null
        ? ContactUsModel.fromJson(json['contactUs'])
        : null;
    countryCode = json['countryCode'];
    addressFormData = json['addressFormData'] != null
        ? AddressFormModel.fromJson(json['addressFormData'])
        : null;
    arabicName = json['arabicName']; // ✅ Parse from JSON
  }

  /// The website ID associated with the country.
  String? websiteId;

  /// The store associated with the country.
  int? store;

  /// The unique identifier for the country.
  String? countryId;

  /// The name of the country.
  String? countryName;

  /// The country flag image (or URL to the flag).
  String? countryFlag;

  /// Contact information related to the country.
  ContactUsModel? contactUs;

  /// The country code (e.g., for calling purposes).
  String? countryCode;

  /// Data related to the address form for the country.
  AddressFormModel? addressFormData;

  /// The Arabic name of the country.
  String? arabicName; // ✅ New property

  /// Converts the current instance of [CountryModel] to a JSON object.
  /// Useful for saving or transmitting the model's data.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data;
    data = <String, dynamic>{};
    data['websiteId'] = websiteId;
    data['store'] = store;
    data['countryId'] = countryId;
    data['countryName'] = countryName;
    data['countryFlag'] = countryFlag;
    if (contactUs != null) {
      data['contactUs'] = contactUs!.toJson();
    }
    data['countryCode'] = countryCode;
    if (addressFormData != null) {
      data['addressFormData'] = addressFormData!.toJson();
    }
    data['arabicName'] = arabicName; // ✅ Add in toJson
    return data;
  }
}
