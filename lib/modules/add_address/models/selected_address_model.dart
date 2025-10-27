import '../../../utils/exports.dart';

/// Model for storing selected address data in SharedPreferences.
///
/// This model can represent either a pickup store or a delivery address,
/// and includes both coordinates and detailed address information.
class SelectedAddressModel {
  /// Title or name of the address.
  final String? title;

  /// Detailed description of the address.
  final String? details;

  /// Latitude coordinate of the address.
  final double? latitude;

  /// Longitude coordinate of the address.
  final double? longitude;

  /// First line of the street address.
  final String? streetAddress1;

  /// Second line of the street address.
  final String? streetAddress2;

  /// Third line of the street address.
  final String? streetAddress3;

  /// City of the address.
  final String? city;

  /// Postal code of the address.
  final String? postalCode;

  /// Country of the address.
  final String? country;

  /// Store ID if this address is a pickup store.
  final int? storeId;

  /// Address ID if this address is a delivery address.
  final int? addressId;

  /// Type of address (e.g., 'pickup' or 'delivery').
  final String? addressType;

  /// Creates a new [SelectedAddressModel].
  const SelectedAddressModel({
    this.title,
    this.details,
    this.latitude,
    this.longitude,
    this.streetAddress1,
    this.streetAddress2,
    this.streetAddress3,
    this.city,
    this.postalCode,
    this.country,
    this.storeId,
    this.addressId,
    this.addressType,
  });

  /// Creates a [SelectedAddressModel] from a JSON map.
  factory SelectedAddressModel.fromJson(Map<String, dynamic> json) {
    return SelectedAddressModel(
      title: json['title'],
      details: json['details'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      streetAddress1: json['streetAddress1'],
      streetAddress2: json['streetAddress2'],
      streetAddress3: json['streetAddress3'],
      city: json['city'],
      postalCode: json['postalCode'],
      country: json['country'],
      storeId: json['storeId'] as int?,
      addressId: json['addressId'] as int?,
      addressType: json['addressType'],
    );
  }

  /// Converts this [SelectedAddressModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'details': details,
      'latitude': latitude,
      'longitude': longitude,
      'streetAddress1': streetAddress1,
      'streetAddress2': streetAddress2,
      'streetAddress3': streetAddress3,
      'city': city,
      'postalCode': postalCode,
      'country': country,
      'storeId': storeId,
      'addressId': addressId,
      'addressType': addressType,
    };
  }

  /// Creates a [SelectedAddressModel] from a [LatLng] object and address details.
  ///
  /// Useful when you have coordinates and want to store full address info.
  factory SelectedAddressModel.fromLatLngAndDetails({
    required LatLng latLng,
    required String title,
    required String details,
    String? streetAddress1,
    String? streetAddress2,
    String? streetAddress3,
    String? city,
    String? postalCode,
    String? country,
    int? storeId,
    int? addressId,
    String? addressType,
  }) {
    return SelectedAddressModel(
      title: title,
      details: details,
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      streetAddress1: streetAddress1,
      streetAddress2: streetAddress2,
      streetAddress3: streetAddress3,
      city: city,
      postalCode: postalCode,
      country: country,
      storeId: storeId,
      addressId: addressId,
      addressType: addressType,
    );
  }

  /// Returns a [LatLng] object if coordinates are available.
  LatLng? get latLng {
    if (latitude != null && longitude != null) {
      return LatLng(latitude!, longitude!);
    }
    return null;
  }

  /// Returns `true` if the address data is valid (title is not null or empty).
  bool get isValid => title != null && title!.isNotEmpty;

  /// Returns `true` if this is a pickup store.
  bool get isPickupStore => storeId != null;

  /// Returns `true` if this is a delivery address.
  bool get isDeliveryAddress => addressId != null;

  /// Returns a formatted address string combining available parts.
  String get formattedAddress {
    final List<String> parts = <String>[];
    if (streetAddress1?.isNotEmpty ?? false) parts.add(streetAddress1!);
    if (streetAddress2?.isNotEmpty ?? false) parts.add(streetAddress2!);
    if (streetAddress3?.isNotEmpty ?? false) parts.add(streetAddress3!);
    if (city?.isNotEmpty ?? false) parts.add(city!);
    if (postalCode?.isNotEmpty ?? false) parts.add(postalCode!);
    if (country?.isNotEmpty ?? false) parts.add(country!);
    return parts.join(', ');
  }

  /// Creates a copy of this [SelectedAddressModel] with optional updated fields.
  SelectedAddressModel copyWith({
    String? title,
    String? details,
    LatLng? latLng,
    String? streetAddress1,
    String? streetAddress2,
    String? streetAddress3,
    String? city,
    String? postalCode,
    String? country,
    int? storeId,
    int? addressId,
    String? addressType,
  }) {
    return SelectedAddressModel(
      title: title ?? this.title,
      details: details ?? this.details,
      latitude: latLng?.latitude ?? latitude,
      longitude: latLng?.longitude ?? longitude,
      streetAddress1: streetAddress1 ?? this.streetAddress1,
      streetAddress2: streetAddress2 ?? this.streetAddress2,
      streetAddress3: streetAddress3 ?? this.streetAddress3,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      storeId: storeId ?? this.storeId,
      addressId: addressId ?? this.addressId,
      addressType: addressType ?? this.addressType,
    );
  }
}
