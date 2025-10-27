import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_wishlist_model.freezed.dart';
part 'delete_wishlist_model.g.dart';

/// A model representing a request to delete an item from the wish list.
///
/// This model contains the necessary information to identify and remove
/// a specific item from a user's wishlist, including authentication
/// and item identification details.
///
/// Supports JSON serialization and deserialization.
///
/// Example usage:
/// ```dart
/// final deleteRequest = DeleteWishlistModel(
///   websiteId: "123",
///   customerToken: "abc123",
///   itemId: "456",
/// );
///
/// final json = deleteRequest.toJson();
/// print(json);
/// ```
@freezed
class DeleteWishlistModel with _$DeleteWishlistModel {
  /// Creates a new [DeleteWishlistModel] instance.
  const factory DeleteWishlistModel({
    /// The website ID associated with the delete wish list request.
    required String websiteId,
    
    /// The customer token used for authentication in the request.
    required String customerToken,
    
    /// The ID of the item to be deleted from the wish list.
    required String itemId,
  }) = _DeleteWishlistModel;

  /// Creates a [DeleteWishlistModel] instance from a JSON map.
  factory DeleteWishlistModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteWishlistModelFromJson(json);
}
