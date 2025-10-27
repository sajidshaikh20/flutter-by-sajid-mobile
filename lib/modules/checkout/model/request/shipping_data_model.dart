/// A model class representing shipping data for an order.
class ShippingData {

  /// Creates a new instance of [ShippingData].
  ///
  /// [addressId] The ID of the shipping address.
  /// [newAddress] A map representing the details of the new shipping address.
  /// [sameAsShipping] A flag indicating if the shipping address is the same as
  /// the billing address.
  ShippingData({this.addressId, this.newAddress, this.sameAsShipping});

  /// Creates a [ShippingData] from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters
  /// of the constructor.
  ShippingData.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'] as String?;
    newAddress =
    json['newAddress'] as Map<String, dynamic>?; // Adjusted for type
    sameAsShipping = json['sameAsShipping'] as String?;
  }

  /// The ID of the shipping address.
  String? addressId;

  /// A map representing the details of the new shipping address.
  Map<String, dynamic>? newAddress; // Changed to a Map

  /// A flag indicating if the shipping address is the same as the
  /// billing address.
  String? sameAsShipping;

  /// Converts the [ShippingData] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs that represent the instance's fields.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['addressId'] = addressId;
    data['newAddress'] = newAddress; // Directly use the map
    data['sameAsShipping'] = sameAsShipping;
    return data;
  }
}
