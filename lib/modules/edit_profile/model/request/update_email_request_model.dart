import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_email_request_model.freezed.dart';
part 'update_email_request_model.g.dart';

/// Request model for updating user email address.
@freezed
class UpdateEmailRequestModel with _$UpdateEmailRequestModel {
  /// Creates an [UpdateEmailRequestModel] instance.
  const factory UpdateEmailRequestModel({
    /// The customer authentication token.
    String? customerToken,
    
    /// The new email address to update.
    String? email,
    
    /// The OTP (One-Time Password) for verification.
    String? otp,
    
    /// The platform identifier (e.g., 'android', 'ios', 'web').
    String? platform,
    
    /// The app version.
    String? version,
    
    /// Device identifier for tracking and analytics.
    String? deviceId,
    
    /// The website identifier.
    int? websiteId,
    
    /// The language identifier for localization.
    int? languageId,
    
    /// The store identifier.
    int? storeId,
    
    /// Flag indicating if OTP was sent (1 for sent, 0 for not sent).
    int? sentOtp,
    
    /// Flag indicating if OTP was verified (1 for verified, 0 for not verified).
    int? verifyOtp,
  }) = _UpdateEmailRequestModel;

  /// Creates an [UpdateEmailRequestModel] from a JSON map.
  factory UpdateEmailRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateEmailRequestModelFromJson(json);
}