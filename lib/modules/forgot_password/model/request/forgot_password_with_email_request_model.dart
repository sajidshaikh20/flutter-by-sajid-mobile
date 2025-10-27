import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_with_email_request_model.freezed.dart';
part 'forgot_password_with_email_request_model.g.dart';

/// Request model for forgot password with email API call.
@freezed
class ForgotPasswordWithEmailRequestModel with _$ForgotPasswordWithEmailRequestModel {
  /// Creates an instance of [ForgotPasswordWithEmailRequestModel].
  ///
  /// [platform] The platform type (e.g., mobile, web).
  /// [version] The app version.
  /// [email] The user's email address.
  /// [languageId] The language identifier for localization.
  const factory ForgotPasswordWithEmailRequestModel({
    String? platform,
    String? version,
    String? email,
    String? languageId,  // New parameter added
  }) = _ForgotPasswordWithEmailRequestModel;

  /// Creates an instance of [ForgotPasswordWithEmailRequestModel] from a JSON map.
  factory ForgotPasswordWithEmailRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordWithEmailRequestModelFromJson(json);
}
