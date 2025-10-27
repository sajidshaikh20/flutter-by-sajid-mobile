/// A model representing the response received after adding a new address.
class AddNewAddressResponseModel {
  /// The unique identifier of the address returned from the server.
  final String? id;

  /// Creates an instance of [AddNewAddressResponseModel].
  AddNewAddressResponseModel({
    this.id,
  });

  /// Creates an [AddNewAddressResponseModel] instance from a JSON map.
  ///
  /// Converts the `id` field to a string to maintain consistency,
  /// even if the API returns it as a number.
  factory AddNewAddressResponseModel.fromJson(Map<String, dynamic> json) {
    final dynamic idValue = json['id'];
    return AddNewAddressResponseModel(
      id: idValue?.toString(), // Always store as String
    );
  }

  /// Converts the [AddNewAddressResponseModel] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
    };
  }

  /// Returns a copy of this model with the given fields replaced by new values.
  AddNewAddressResponseModel copyWith({
    String? id,
  }) {
    return AddNewAddressResponseModel(
      id: id ?? this.id,
    );
  }
}
