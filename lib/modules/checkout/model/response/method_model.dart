/// A model class representing a method, which could be a payment method,
/// shipping method, or similar.
class Method {

  /// Creates a new instance of [Method].
  ///
  /// [code] The unique code identifying the method.
  /// [label] The display label for the method.
  /// [price] The price associated with the method (if applicable).
  Method({this.code, this.label, this.price});

  /// Creates a [Method] from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters
  /// of the constructor.
  Method.fromJson(Map<String, dynamic> json) {
    code = json['code'] as String?;
    label = json['label'] as String?;
    price = json['price'] as String?;
  }

  /// The unique code identifying the method.
  String? code;

  /// The display label for the method.
  String? label;

  /// The price associated with the method, if applicable.
  String? price;

  /// Converts the [Method] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs representing the method's fields.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'code': code,
    'label': label,
    'price': price,
  };
}

