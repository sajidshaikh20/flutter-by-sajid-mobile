import '../../../../utils/exports.dart';

/// A model class representing the response containing shipping methods for
/// an order.
class ShippingMethodResponse {
  /// Creates a new instance of [ShippingMethodResponse].
  ///
  /// [shippingMethods] A list of [ShippingMethods] representing available
  /// shipping options.
  /// [customerId] The customer ID associated with the shipping methods.
  /// [success] A boolean flag indicating if the request was successful.
  ShippingMethodResponse({
    this.shippingMethods,
    this.customerId,
    this.success,
  });

  /// Creates a [ShippingMethodResponse] instance from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters of the
  /// constructor.
  ShippingMethodResponse.fromJson(Map<String, dynamic> json) {
    if (json['shippingMethods'] != null) {
      shippingMethods = (json['shippingMethods'] as List<dynamic>)
          .map((dynamic v) =>
              ShippingMethods.fromJson(v as Map<String, dynamic>))
          .toList();
    }

    customerId = json['customerId'] as String?;
    success = json['success'] as bool?;
  }

  /// A list of [ShippingMethods] representing the available shipping options.
  @JsonKey(name: 'shippingMethods')
  List<ShippingMethods>? shippingMethods;

  /// The customer ID associated with the shipping methods.
  @JsonKey(name: 'customerId')
  String? customerId;

  /// A boolean flag indicating whether the request was successful.
  @JsonKey(name: 'success')
  bool? success;

  /// Converts the [ShippingMethodResponse] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs representing the shipping method
  /// response data.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (shippingMethods != null) {
      data['shippingMethods'] =
          shippingMethods!.map((ShippingMethods v) => v.toJson()).toList();
    }
    data['customerId'] = customerId;
    data['success'] = success;
    return data;
  }
}
