import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request_model.freezed.dart';
part 'sign_up_request_model.g.dart';

/// A data model representing the request payload for user signup.
///
/// This model contains all the required fields for user registration
/// including personal information, contact details, and authentication data.
///
///
/// Example usage:
/// ```dart
/// final request = SignupRequestModel(
///   email: "user@example.com",
///   firstName: "John",
///   lastName: "Doe",
///   mobileNumberPrefix: "+1",
///   mobileNumber: "1234567890",
///   nationality: "US",
///   dob: "1990-01-01",
///   gender: "M",
///   referralCode: "REF123",
///   otp: "123456",
///   password: "password123",
///   languageId: 1,
///   platform: "iOS",
///   version: "1.0.0",
/// );
///
/// final json = request.toJson();
/// print(json);
/// ```
@freezed
class SignupRequestModel with _$SignupRequestModel {
  /// Creates a new [SignupRequestModel] instance.
  const factory SignupRequestModel({
    /// User's email address.
    required String email,
    
    /// User's first name.
    required String firstName,
    
    /// User's last name.
    required String lastName,
    
    /// Mobile number country prefix (e.g., "+1" for US).
    required String mobileNumberPrefix,
    
    /// User's mobile number.
    required String mobileNumber,
    
    /// User's nationality.
    required String Nationality,
    
    /// User's date of birth.
    required String dob,
    
    /// User's gender.
    required String gender,
    
    /// Referral code if applicable.
    required String referralCode,
    
    /// One-time password for verification.
    required String otp,
    
    /// User's password.
    required String password,
    
    /// Language ID for localization.
    required int languageId,
    
    /// Platform name (e.g., "iOS", "Android", "Web").
    required String platform,
    
    /// App version.
    required String version,
    
    /// Device identifier for tracking and analytics.
    String? deviceId,
  }) = _SignupRequestModel;

  /// Creates a [SignupRequestModel] instance from a JSON map.
  factory SignupRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestModelFromJson(json);
}
