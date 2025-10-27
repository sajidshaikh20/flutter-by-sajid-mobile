/// A model class representing the configuration for an address form.
/// It holds information on which fields are visible and required in the form.
class AddressFormModel {

  /// Constructor for creating an instance of [AddressFormModel]
  /// with optional parameters.
  AddressFormModel({
    this.isCompanyVisible,
    this.isCompanyRequired,
    this.isTelephoneVisible,
    this.isTelephoneRequired,
    this.isAddressTitleVisible,
    this.isAddressTitleRequired,
    this.postalCodeVisible,
    this.postalCodeRequired,
  });

  /// Factory constructor for creating an instance of [AddressFormModel]
  /// from a JSON object.
  AddressFormModel.fromJson(Map<String, dynamic> json) {
    isCompanyVisible = json['isCompanyVisible'];
    isCompanyRequired = json['isCompanyRequired'];
    isTelephoneVisible = json['isTelephoneVisible'];
    isTelephoneRequired = json['isTelephoneRequired'];
    isAddressTitleVisible = json['isAddressTitleVisible'];
    isAddressTitleRequired = json['isAddressTitleRequired'];
    postalCodeVisible = json['postalCodeVisible'];
    postalCodeRequired = json['postalCodeRequired'];
  }

  /// A flag indicating if the company field is visible.
  bool? isCompanyVisible;

  /// A flag indicating if the company field is required.
  bool? isCompanyRequired;

  /// A flag indicating if the telephone field is visible.
  bool? isTelephoneVisible;

  /// A flag indicating if the telephone field is required.
  bool? isTelephoneRequired;

  /// A flag indicating if the address title field is visible.
  bool? isAddressTitleVisible;

  /// A flag indicating if the address title field is required.
  bool? isAddressTitleRequired;

  /// A flag indicating if the postal code field is visible.
  bool? postalCodeVisible;

  /// A flag indicating if the postal code field is required.
  bool? postalCodeRequired;

  /// Converts the current instance of [AddressFormModel] to a JSON object.
  /// This is useful for saving or transmitting the model's data.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['isCompanyVisible'] = isCompanyVisible;
    data['isCompanyRequired'] = isCompanyRequired;
    data['isTelephoneVisible'] = isTelephoneVisible;
    data['isTelephoneRequired'] = isTelephoneRequired;
    data['isAddressTitleVisible'] = isAddressTitleVisible;
    data['isAddressTitleRequired'] = isAddressTitleRequired;
    data['postalCodeVisible'] = postalCodeVisible;
    data['postalCodeRequired'] = postalCodeRequired;
    return data;
  }
}
