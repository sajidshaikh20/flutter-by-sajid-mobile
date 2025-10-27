
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_model.freezed.dart';
part 'login_request_model.g.dart';

/// Model for login request containing user credentials and device information.
///
/// This model represents the data structure for login requests, including
/// both traditional email/password login and social login options.
///
/// Supports serialization via [toJson] and deserialization via [].
///
/// Example usage:
/// ```dart
/// final loginRequest = LoginRequestModel(
///   languageId: 1,
///   platform: "iOS",
///   version: "1.0.0",
///   emailMobile: "user@example.com",
///   password: "password123",
///   isSocialLogin: false,
/// );
///
/// final json = loginRequest.toJson();
/// print(json);
/// ```
@freezed
class LoginRequestModel with _$LoginRequestModel {
  /// Creates a new [LoginRequestModel] instance.
  const factory LoginRequestModel({
    /// Language identifier for the user's preferred language.
    int? languageId,
    
    /// Platform identifier (e.g., "iOS", "Android", "Web").
    String? platform,
    
    /// Application version.
    String? version,
    
    /// User's email or mobile number for login.
    String? emailMobile,
    
    /// User's password for authentication.
    String? password,
    
    /// Indicates if this is a social login request.
    bool? isSocialLogin,
    
    /// Type of social login (e.g., "google", "facebook", "apple").
    String? socialLoginType,
    
    /// Apple authentication token for Apple Sign-In.
    String? appleToken,

    /// Device identifier for tracking and analytics.
    String? deviceId,
    
    /// Device token for push notifications (FCM token).
    String? deviceToken,
    
    /// General authentication token.
    String? token,
  }) = _LoginRequestModel;

  /// Creates a [LoginRequestModel] instance from a JSON map.
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
}
