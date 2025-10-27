import 'package:freezed_annotation/freezed_annotation.dart';

import 'simple_response.dart';

part 'remove_all_item_cart_model.freezed.dart';
part 'remove_all_item_cart_model.g.dart';

/// A data model representing the response from the API
/// when attempting to remove all items from a shopping cart.
///
/// This model follows the same pattern as [SimpleResponse] to provide
/// a consistent interface for simple success/message responses.
///
///
/// Example usage:
/// ```dart
/// final response = RemoveAllItemCartModel.fromJson(jsonData);
/// if (response.success == true) {
///   print("All items removed successfully: ${response.message}");
/// } else {
///   print("Failed to remove items: ${response.message}");
/// }
/// ```
@freezed
class RemoveAllItemCartModel with _$RemoveAllItemCartModel {
  /// Creates a new [RemoveAllItemCartModel] instance.
  const factory RemoveAllItemCartModel({
    /// Indicates whether the removal of all cart items was successful.
    @Default(false) bool? success,
    
    /// Message returned by the server, usually describing success or failure.
    @Default('') String? message,
  }) = _RemoveAllItemCartModel;

  /// Creates a [RemoveAllItemCartModel] instance from a JSON map.
  factory RemoveAllItemCartModel.fromJson(Map<String, dynamic> json) =>
      _$RemoveAllItemCartModelFromJson(json);
}

/// Extension to provide easy conversion between SimpleResponse and RemoveAllItemCartModel
extension RemoveAllItemCartModelExtension on SimpleResponse {
  /// Converts a [SimpleResponse] to a [RemoveAllItemCartModel].
  RemoveAllItemCartModel toRemoveAllItemCartModel() {
    return RemoveAllItemCartModel(
      success: success,
      message: message,
    );
  }
}

/// Extension to provide easy conversion between RemoveAllItemCartModel and SimpleResponse
extension RemoveAllItemCartModelToSimpleExtension on RemoveAllItemCartModel {
  /// Converts a [RemoveAllItemCartModel] to a [SimpleResponse].
  SimpleResponse toSimpleResponse() {
    return SimpleResponse(
      success: success,
      message: message,
    );
  }
}
