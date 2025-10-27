import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_model.freezed.dart';
part 'edit_profile_model.g.dart';

/// Model representing the response from the Edit Profile API.
@freezed
class EditProfileModel with _$EditProfileModel {
  /// Constructor for [EditProfileModel].
  const factory EditProfileModel({
    /// Indicates if the API call was successful.
    @Default(false) bool? success,
    
    /// Message returned from the API, e.g., success or error message.
    @Default('') String? message,
    
    /// Whether an OTP was sent as part of the profile update.
    @Default(false) bool? otpSent,
    
    /// URL of the user's profile image.
    String? profileImage,
    
    /// Name of the customer.
    String? customerName,
  }) = _EditProfileModel;

  /// Creates an instance from a JSON map.
  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileModelFromJson(json);
}
