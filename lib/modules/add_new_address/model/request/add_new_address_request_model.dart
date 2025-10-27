/// A model representing a request to add or update a new address.
class AddNewAddressRequestModel {
  /// The ID of the selected language.
  final int? languageId;

  /// The quote ID associated with the address (may vary depending on platform).
  final dynamic quoteId;

  /// The token identifying the customer.
  final String? customerToken;

  /// The unique ID of the address (used when editing an existing address).
  final String? addressId;

  /// The name of the platform making the request (e.g., Android, iOS, Web).
  final String? platform;

  /// The version of the application or API.
  final String? version;

  /// The detailed address data.
  final AddressData? addressData;

  /// Creates an instance of [AddNewAddressRequestModel].
  AddNewAddressRequestModel({
    this.languageId,
    this.quoteId,
    this.customerToken,
    this.addressId,
    this.platform,
    this.version,
    this.addressData,
  });

  /// Converts the [AddNewAddressRequestModel] into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['quoteId'] = quoteId;
    data['customerToken'] = customerToken;
    data['addressId'] = addressId;
    data['platform'] = platform;
    data['version'] = version;

    if (addressData != null) {
      data['addressData'] = addressData!.toJson();
    }

    return data;
  }
}

/// Represents the detailed data of an address.
class AddressData {
  /// The area or locality name.
  final String? area;

  /// The type of address (e.g., home, office).
  final String? addressType;

  /// The street name or description.
  final String? street;

  /// The postal code.
  final String? postcode;

  /// The latitude coordinate.
  final double? latitude;

  /// The longitude coordinate.
  final double? longitude;

  /// The block number or house number.
  final String? blockNo;

  /// The name or number of the building or villa.
  final String? buildingVilla;

  /// The floor number of the address.
  final String? floor;

  /// The flat or apartment number.
  final String? flatAppartment;

  /// A nearby landmark for easier identification.
  final String? landmark;

  /// The formatted address from a map service.
  final String? mapAddress;

  /// The contact mobile number.
  final String? mobileNo;

  /// Whether this address is set as the default billing address.
  final bool? isDefaultBilling;

  /// The title or label for the map address.
  final String? mapAddressTitle;

  /// Creates an instance of [AddressData].
  AddressData({
    this.area,
    this.addressType,
    this.street,
    this.postcode,
    this.latitude,
    this.longitude,
    this.blockNo,
    this.buildingVilla,
    this.floor,
    this.flatAppartment,
    this.landmark,
    this.mapAddress,
    this.mobileNo,
    this.isDefaultBilling,
    this.mapAddressTitle,
  });

  /// Converts the [AddressData] into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area;
    data['addressType'] = addressType;
    data['street'] = street;
    data['postcode'] = postcode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['blockNo'] = blockNo;
    data['buildingVilla'] = buildingVilla;
    data['floor'] = floor;
    data['flatAppartment'] = flatAppartment;
    data['landmark'] = landmark;
    data['mapAddress'] = mapAddress;
    data['mobileNo'] = mobileNo;
    data['isDefaultBilling'] = isDefaultBilling;
    data['mapAddressTitle'] = mapAddressTitle;

    return data;
  }
}
