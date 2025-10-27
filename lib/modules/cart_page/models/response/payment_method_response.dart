// To parse this JSON data, do
//
//     final paymentMethodResponse = paymentMethodResponseFromJson(jsonString);


///class PaymentMethodResponse
class PaymentMethodResponse {

  /// id variable
  final int? id;
  ///name variable
  final String? name;

  ///PaymentMethodResponse
  PaymentMethodResponse({
    this.id,
    this.name,
  });
///copyWith
  PaymentMethodResponse copyWith({
    int? id,
    String? name,
  }) =>
      PaymentMethodResponse(
        id: id ?? this.id,
        name: name ?? this.name,
      );
///fromJson
  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) => PaymentMethodResponse(
    id: json["id"],
    name: json["name"],
  );

  ///toJson
  Map<String, dynamic> toJson() => <String, dynamic>{
    "id": id,
    "name": name,
  };
}
