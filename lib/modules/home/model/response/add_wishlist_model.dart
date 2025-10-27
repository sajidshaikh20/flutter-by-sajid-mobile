/// Represents the model for adding an item to the wishlist with status and message.
class AddWishlistModel {
  /// Constructs an [AddWishlistModel] with optional [success], [message], and [data] parameters.
  AddWishlistModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  /// Creates an [AddWishlistModel] from a JSON map.
  AddWishlistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = (json['data'] as List<dynamic>)
          .map((dynamic v) => AddToWishlist.fromJson(v as Map<String, dynamic>))
          .toList();
    }
  }

  /// Indicates whether the addition to the wishlist was successful.
  bool? success;

  /// Status code of the response
  int? statusCode;

  /// A message providing more details about the addition to the wishlist.
  String? message;

  /// List of wishlist items added
  List<AddToWishlist>? data;

  /// Converts the [AddWishlistModel] to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((AddToWishlist v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Model for individual wishlist item in the response.
class AddToWishlist {
  /// The unique identifier of the wishlist item.
  final int? itemId;

  /// Creates an instance of [AddToWishlist].
  AddToWishlist({
    this.itemId,
  });

  /// Creates a copy of this [AddToWishlist] with optional new values.
  AddToWishlist copyWith({
    int? itemId,
  }) =>
      AddToWishlist(
        itemId: itemId ?? this.itemId,
      );

  /// Creates an instance of [AddToWishlist] from a JSON map.
  factory AddToWishlist.fromJson(Map<String, dynamic> json) => AddToWishlist(
    itemId: json["itemId"],
  );

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "itemId": itemId,
  };
}
