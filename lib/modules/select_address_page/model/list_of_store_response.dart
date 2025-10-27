/// Represents the response model for a store listing.
class ListOfStoreResponse {
  /// Unique identifier for the store's location.
  final dynamic locationId;

  /// Unique store ID.
  final int? storeId;

  /// Name of the store.
  final String? storeName;

  /// City where the store is located.
  final dynamic city;

  /// District where the store is located.
  final String? district;

  /// Street name or address details.
  final dynamic street;

  /// Country where the store is located.
  final String? country;

  /// Full address of the store.
  final String? address;

  /// Latitude coordinate of the store location.
  final double? lat;

  /// Longitude coordinate of the store location.
  final double? lang;

  /// Note related to store’s busy hours.
  final String? busyHourNote;

  /// Note mentioning items that are not available in the store.
  final String? itemsNotAvailableNote;

  /// Indicates whether the store is currently available (e.g., "Yes" or "No").
  final String? isStoreAvailable;

  /// Distance from the current user location to the store.
  final double? distance;

  /// List of available time slots for the store.
  final List<dynamic>? timeSlot;

  /// Contact phone number of the store.
  final String? phoneNumber;

  /// Creates an instance of [ListOfStoreResponse].
  ListOfStoreResponse({
    this.locationId,
    this.storeId,
    this.storeName,
    this.city,
    this.district,
    this.street,
    this.country,
    this.address,
    this.lat,
    this.lang,
    this.busyHourNote,
    this.itemsNotAvailableNote,
    this.isStoreAvailable,
    this.distance,
    this.timeSlot,
    this.phoneNumber,
  });

  /// Returns a new instance of [ListOfStoreResponse] with updated fields.
  ///
  /// Any field not provided will retain its previous value.
  ListOfStoreResponse copyWith({
    dynamic locationId,
    int? storeId,
    String? storeName,
    dynamic city,
    String? district,
    dynamic street,
    String? country,
    String? address,
    double? lat,
    double? lang,
    String? busyHourNote,
    String? itemsNotAvailableNote,
    String? isStoreAvailable,
    double? distance,
    List<dynamic>? timeSlot,
    String? phoneNumber,
  }) =>
      ListOfStoreResponse(
        locationId: locationId ?? this.locationId,
        storeId: storeId ?? this.storeId,
        storeName: storeName ?? this.storeName,
        city: city ?? this.city,
        district: district ?? this.district,
        street: street ?? this.street,
        country: country ?? this.country,
        address: address ?? this.address,
        lat: lat ?? this.lat,
        lang: lang ?? this.lang,
        busyHourNote: busyHourNote ?? this.busyHourNote,
        itemsNotAvailableNote: itemsNotAvailableNote ?? this.itemsNotAvailableNote,
        isStoreAvailable: isStoreAvailable ?? this.isStoreAvailable,
        distance: distance ?? this.distance,
        timeSlot: timeSlot ?? this.timeSlot,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  /// Creates a [ListOfStoreResponse] object from a JSON map.
  factory ListOfStoreResponse.fromJson(Map<String, dynamic> json) => ListOfStoreResponse(
    locationId: json["locationId"],
    storeId: json["storeId"],
    storeName: json["storeName"],
    city: json["city"],
    district: json["district"],
    street: json["street"],
    country: json["country"],
    address: json["address"],
    lat: (json["lat"] as num?)?.toDouble(),
    lang: (json["lang"] as num?)?.toDouble(),
    busyHourNote: json["busy_hour_note"],
    itemsNotAvailableNote: json["items_not_available_note"],
    isStoreAvailable: json["is_store_available"],
    distance: (json["distance"] as num?)?.toDouble(),
    timeSlot: json["time_slot"] == null
        ? <dynamic>[]
        : List<dynamic>.from((json["time_slot"] as List<dynamic>).map((dynamic x) => x)),
    phoneNumber: json["phone"],
  );

  /// Converts the [ListOfStoreResponse] object into a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "locationId": locationId,
    "storeId": storeId,
    "storeName": storeName,
    "city": city,
    "district": district,
    "street": street,
    "country": country,
    "address": address,
    "lat": lat,
    "lang": lang,
    "busy_hour_note": busyHourNote,
    "items_not_available_note": itemsNotAvailableNote,
    "is_store_available": isStoreAvailable,
    "distance": distance,
    "time_slot": timeSlot == null
        ? <dynamic>[]
        : List<dynamic>.from(timeSlot!.map((dynamic x) => x)),
    "phone": phoneNumber,
  };
}
