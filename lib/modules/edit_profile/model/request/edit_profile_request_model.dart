import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_request_model.freezed.dart';
part 'edit_profile_request_model.g.dart';

/// Request model for editing user profile.
@freezed
class EditProfileRequestModel with _$EditProfileRequestModel {
  /// Creates an [EditProfileRequestModel] instance.
  const factory EditProfileRequestModel({
    /// The language ID for localization.
    int? languageId,
    /// The customer authentication token.
    String? customerToken,
    /// The platform identifier (e.g., 'android', 'ios', 'web').
    String? platform,
    /// The app version.
    String? version,
    /// The customer's first name.
    String? firstName,
    /// The customer's last name.
    String? lastName,
    /// The customer's mobile number.
    String? mobileNumber,
    /// The mobile number prefix/country code.
    String? mobileNumberPrefix,
    /// The customer's nationality.
    String? nationality,
    /// The customer's date of birth.
    String? dob,
    /// The customer's gender.
    String? gender,
    /// Device identifier for tracking and analytics.
    String? deviceId,
  }) = _EditProfileRequestModel;

  /// Creates an [EditProfileRequestModel] from a JSON map.
  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestModelFromJson(json);
}



