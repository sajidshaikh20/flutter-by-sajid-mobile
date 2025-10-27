/// A generic class representing the standard structure of API responses.
///
/// [T] represents the type of the response data.
class BaseResponse<T> {
  /// The HTTP status code returned by the API.
  final int statusCode;

  /// Indicates whether the API request was successful.
  final bool success;

  /// The message returned from the API (e.g., success or error message).
  final String message;

  /// The actual data returned from the API, of type [T].
  final T? data;

  /// Optional: The current count of items in the cart.
  final int? cartCount;

  /// Optional: Any error message returned by the API.
  final String? error;

  /// Optional: The quote ID associated with the cart or transaction.
  final String? quoteId;

  /// Optional: Total number of items available (useful for pagination).
  final int? totalCount;

  /// Creates an instance of [BaseResponse].
  ///
  /// [statusCode], [success], and [message] are required.
  BaseResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    this.data,
    this.cartCount,
    this.error,
    this.quoteId,
    this.totalCount,
  });

  /// Creates a [BaseResponse] instance from a JSON map.
  ///
  /// The [fromJsonT] function is used to parse the [data] field into type [T].
  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return BaseResponse<T>(
      statusCode: json['status_code'] ?? 0,
      success: json['success'] == true && json['status_code'] == 200,
      message: json['message']?.toString() ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      cartCount: json.containsKey('cartCount') ? json['cartCount'] : null,
      error: json.containsKey('error') ? json['error'] : null,
      totalCount: json.containsKey('total_count') ? json['total_count'] : null,
      quoteId: json['quoteId']?.toString() ?? '',
    );
  }

  /// Converts the [BaseResponse] instance to a JSON map.
  ///
  /// The [toJsonT] function is used to convert the [data] field of type [T]
  /// into a JSON-compatible format.
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    final Map<String, dynamic> map = <String, dynamic>{
      'status_code': statusCode,
      'success': success,
      'message': message,
    };
    if (data != null) map['data'] = toJsonT(data as T);
    if (totalCount != null) map['total_count'] = totalCount;
    if (cartCount != null) map['cartCount'] = cartCount;
    if (error != null) map['error'] = error;
    return map;
  }
}
