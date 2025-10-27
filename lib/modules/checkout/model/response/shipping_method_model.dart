import '../../../../utils/exports.dart';

/// A model class representing shipping methods for an order.
class ShippingMethods {
  /// Creates a new instance of [ShippingMethods].
  ///
  /// [isSelected] A boolean flag indicating whether the method is selected.
  /// [title] The title of the shipping method.
  /// [method] A list of [Method] objects representing different
  /// shipping options.
  ShippingMethods({this.isSelected, this.title, this.method});

  /// Creates a [ShippingMethods] instance from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters of the
  /// constructor.
  ShippingMethods.fromJson(Map<String, dynamic> json) {
    isSelected = json['isSelected'] as bool?;
    title = json['title'] as String?;
    if (json['method'] != null) {
      method = (json['method'] as List<dynamic>)
          .map(
            (dynamic v) => Method.fromJson(v as Map<String, dynamic>),
          )
          .toList();
    }
  }

  /// A boolean flag indicating whether the shipping method is selected.
  @JsonKey(name: 'isSelected')
  bool? isSelected;

  /// The title or name of the shipping method.
  @JsonKey(name: 'title')
  String? title;

  /// A list of [Method] objects representing various shipping options.
  @JsonKey(name: 'method')
  List<Method>? method;

  /// Converts the [ShippingMethods] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs representing the shipping method data.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['isSelected'] = isSelected;
    data['title'] = title;
    if (method != null) {
      data['method'] = method!.map((Method v) => v.toJson()).toList();
    }
    return data;
  }
}
