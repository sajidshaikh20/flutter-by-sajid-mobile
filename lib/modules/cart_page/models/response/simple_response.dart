import 'package:freezed_annotation/freezed_annotation.dart';

part 'simple_response.freezed.dart';
part 'simple_response.g.dart';

/// A simple response model for API responses that only contain success and message.
/// 
/// This model can be reused across the application for simple API responses
/// that don't require complex data structures.
/// 
/// Example usage:
/// ```dart
/// final response = SimpleResponse.fromJson(jsonData);
/// if (response.success == true) {
///   print("Success: ${response.message}");
/// } else {
///   print("Error: ${response.message}");
/// }
/// ```
@freezed
class SimpleResponse with _$SimpleResponse {
  /// Creates a new [SimpleResponse] instance.
  const factory SimpleResponse({
    /// Indicates whether the operation was successful.
    @Default(false) bool? success,
    
    /// Message returned by the server, usually describing success or failure.
    @Default('') String? message,
  }) = _SimpleResponse;

  /// Creates a [SimpleResponse] instance from a JSON map.
  factory SimpleResponse.fromJson(Map<String, dynamic> json) =>
      _$SimpleResponseFromJson(json);
}
