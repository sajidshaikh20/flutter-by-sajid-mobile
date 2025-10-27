// To parse this JSON data, do
//
//     final myAddressListingResponse = myAddressListingResponseFromJson(jsonString);

import 'dart:convert';

/// Converts a list of [MyAddressListingResponse] objects to a JSON string.
String myAddressListingResponseToJson(List<MyAddressListingResponse> data) =>
    json.encode(List<dynamic>.from(data.map((MyAddressListingResponse x) => x.toJson())));

/// Represents a customer's address listing response.
class MyAddressListingResponse {
  /// Unique identifier of the address.
  final String? id;

  /// Area of the address.
  final String? area;

  /// Type of the address (e.g., home, office).
  final String? addressType;

  /// Street of the address.
  final String? street;

  /// Postal code of the address.
  final String? postcode;

  /// Latitude of the address.
  final double? latitude;

  /// Longitude of the address.
  final double? longitude;

  /// Block number of the address.
  final String? blockNo;

  /// Building or villa name/number.
  final String? buildingVilla;

  /// Floor number of the address.
  final String? floor;

  /// Flat or apartment number.
  final String? flatAppartment;

  /// Landmark near the address.
  final String? landmark;

  /// Full address as shown on the map.
  final String? mapAddress;

  /// Mobile number associated with the address.
  final String? mobileNo;

  /// Indicates if this is the default billing address.
  final bool? isDefaultBilling;

  /// Title of the address shown on the map.
  final String? mapAddressTitle;

  /// Creates a [MyAddressListingResponse] instance.
  MyAddressListingResponse({
    this.id,
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

  /// Returns a copy of this object with updated fields.
  MyAddressListingResponse copyWith({
    String? id,
    String? area,
    String? addressType,
    String? street,
    String? postcode,
    double? latitude,
    double? longitude,
    String? blockNo,
    String? buildingVilla,
    String? floor,
    String? flatAppartment,
    String? landmark,
    String? mapAddress,
    String? mobileNo,
    bool? isDefaultBilling,
    String? mapAddressTitle,
  }) =>
      MyAddressListingResponse(
        id: id ?? this.id,
        area: area ?? this.area,
        addressType: addressType ?? this.addressType,
        street: street ?? this.street,
        postcode: postcode ?? this.postcode,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        blockNo: blockNo ?? this.blockNo,
        buildingVilla: buildingVilla ?? this.buildingVilla,
        floor: floor ?? this.floor,
        flatAppartment: flatAppartment ?? this.flatAppartment,
        landmark: landmark ?? this.landmark,
        mapAddress: mapAddress ?? this.mapAddress,
        mobileNo: mobileNo ?? this.mobileNo,
        isDefaultBilling: isDefaultBilling ?? this.isDefaultBilling,
        mapAddressTitle: mapAddressTitle ?? this.mapAddressTitle,
      );

  /// Creates a [MyAddressListingResponse] from a JSON object.
  factory MyAddressListingResponse.fromJson(Map<String, dynamic> json) {
    try {
      return MyAddressListingResponse(
        id: json["id"]?.toString(),
        area: json["area"]?.toString(),
        addressType: json["addressType"]?.toString(),
        street: json["street"]?.toString(),
        postcode: json["postcode"]?.toString(),
        latitude: _parseDouble(json["latitude"]),
        longitude: _parseDouble(json["longitude"]),
        blockNo: json["blockNo"]?.toString(),
        buildingVilla: json["buildingVilla"]?.toString(),
        floor: json["floor"]?.toString(),
        flatAppartment: json["flatAppartment"]?.toString(),
        landmark: json["landmark"]?.toString(),
        mapAddress: json["mapAddress"]?.toString(),
        mobileNo: json["mobileNo"]?.toString(),
        isDefaultBilling: _parseBool(json["isDefaultBilling"]),
        mapAddressTitle: json["mapAddressTitle"]?.toString(),
      );
    } on Exception catch (_) {
      // Return empty object on error
      return MyAddressListingResponse();
    }
  }

  /// Converts this object to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "id": id,
    "area": area,
    "addressType": addressType,
    "street": street,
    "postcode": postcode,
    "latitude": latitude,
    "longitude": longitude,
    "blockNo": blockNo,
    "buildingVilla": buildingVilla,
    "floor": floor,
    "flatAppartment": flatAppartment,
    "landmark": landmark,
    "mapAddress": mapAddress,
    "mobileNo": mobileNo,
    "isDefaultBilling": isDefaultBilling,
    "mapAddressTitle": mapAddressTitle,
  };

  /// Parses a value to [bool].
  static bool? _parseBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    if (value is int) return value == 1;
    return null;
  }

  /// Parses a value to [double].
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } on Exception {
        return null;
      }
    }
    return null;
  }
}
