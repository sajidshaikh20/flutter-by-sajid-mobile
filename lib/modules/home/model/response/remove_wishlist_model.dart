/// Represents the model for removing an item from the wishlist
class RemoveWishlistModel {
  /// Constructs a [RemoveWishlistModel] with optional [success], [statusCode], and [message] parameters.
  RemoveWishlistModel({
    this.success,
    this.statusCode,
    this.message,
  });

  /// Creates a [RemoveWishlistModel] from a JSON map.
  RemoveWishlistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
  }

  /// Indicates whether the removal from the wishlist was successful.
  bool? success;

  /// Status code of the response
  int? statusCode;

  /// A message providing more details about the removal from the wishlist.
  String? message;

  /// Converts the [RemoveWishlistModel] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    data['message'] = message;
    return data;
  }
}
