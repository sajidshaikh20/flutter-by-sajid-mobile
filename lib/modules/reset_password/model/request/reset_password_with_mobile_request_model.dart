import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_with_mobile_request_model.freezed.dart';
part 'reset_password_with_mobile_request_model.g.dart';

@freezed
/// Model class for reset password with mobile request parameters.
class ResetPasswordWithMobileRequestModel with _$ResetPasswordWithMobileRequestModel {
  /// Creates a new instance of [ResetPasswordWithMobileRequestModel].
  const factory ResetPasswordWithMobileRequestModel({
    String? platform,
    String? version,
    String? websiteId,
    String? mobileNumber,
    String? mobileNumberPrefix,
    String? sentOtp,
    String? verifyOtp,
    String? updatePassword,
    String? newPassword,
    String? confirmPassword,
    String? languageId,
  }) = _ResetPasswordWithMobileRequestModel;

  /// Creates a [ResetPasswordWithMobileRequestModel] instance from a JSON map.
  factory ResetPasswordWithMobileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordWithMobileRequestModelFromJson(json);
}
