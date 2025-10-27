/// A class representing the response for deleting an address.
class DeleteAddressResponse {
  /// Creates a [DeleteAddressResponse]
  ///  with the given success status and message.
  DeleteAddressResponse({this.success, this.message});

  /// Creates a [DeleteAddressResponse] from a JSON map.
  DeleteAddressResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  /// Indicates whether the address deletion was successful.
  bool? success;

  /// A message providing additional information about the address deletion.
  String? message;

  /// Converts the [DeleteAddressResponse] instance to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
