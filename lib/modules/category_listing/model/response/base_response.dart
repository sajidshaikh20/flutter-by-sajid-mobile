import '../../../../utils/exports.dart';

/// Represents the response from a product list API.
class BaseProductListResponse {

  /// Constructor for initializing the [BaseProductListResponse] object.
  ///
  /// [message] - A message related to the response (e.g., success or error message).
  /// [success] - A flag indicating whether the API request was successful.
  /// [cartCount] - The number of items in the cart.
  /// [etag] - The entity tag used for caching purposes.
  /// [otherError] - A string containing any other errors returned in the response.
  BaseProductListResponse({
    this.message,
    this.success,
    this.cartCount,
    this.etag,
    this.otherError,
  });

  /// Indicates whether the API request was successful.
  @JsonKey(name: 'success')
  final bool? success;

  /// A message describing the result of the API request (success or failure).
  @JsonKey(name: 'message')
  final String? message;

  /// The entity tag (etag) used for caching the response.
  @JsonKey(name: 'eTag')
  final String? etag;

  /// The count of items in the cart.
  @JsonKey(name: 'cartCount')
  final int? cartCount;

  /// A string containing any other errors returned in the response.
  @JsonKey(name: 'otherError')
  final String? otherError;
}
