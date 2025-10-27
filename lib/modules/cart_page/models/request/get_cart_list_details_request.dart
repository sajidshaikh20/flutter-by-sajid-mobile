import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_cart_list_details_request.freezed.dart';
part 'get_cart_list_details_request.g.dart';

/// A data model representing the request payload for retrieving
/// detailed cart information.
///
/// This model is used when fetching cart details from the API,
/// including store info, currency, customer token, and optional
/// display parameters like [width].
///
///
/// Example usage:
/// ```dart
/// final request = GetCartListDetailsRequest(
///   customerToken: "abcd1234",
///   storeId: "1",
///   quoteId: "1001",
///   currency: "USD",
///   width: "375",
/// );
///
/// final json = request.toJson();
/// print(json);
/// ```
@freezed
class GetCartListDetailsRequest with _$GetCartListDetailsRequest {
  /// Creates a new [GetCartListDetailsRequest] instance.
  const factory GetCartListDetailsRequest({
    /// Customer authentication token.
    String? customerToken,
    
    /// Store identifier.
    String? storeId,
    
    /// Unique quote/cart ID.
    String? quoteId,
    
    /// Website identifier in a multi-website setup.
    String? websiteId,
    
    /// Currency code (e.g., `USD`, `KWD`).
    String? currency,
    
    /// HTTP method or API action type (e.g., `GET`, `POST`).
    String? method,
    
    /// Entity tag for caching or concurrency control.
    String? eTag,
    
    /// Optional width for display purposes (e.g., for responsive layouts).
    String? width,
  }) = _GetCartListDetailsRequest;

  /// Creates a [GetCartListDetailsRequest] instance from a JSON map.
  factory GetCartListDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetCartListDetailsRequestFromJson(json);
}
