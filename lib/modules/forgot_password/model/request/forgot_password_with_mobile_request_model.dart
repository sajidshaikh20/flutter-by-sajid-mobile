/// Model class for forgot password with mobile API request parameters.
class ForgotPasswordWithMobileRequestModel {
  /// The platform type (e.g., mobile, web).
  String? platform;

  /// The app version.
  String? version;

  /// The website identifier.
  String? websiteId;

  /// The store identifier.
  String? storeId;

  /// The user's mobile number.
  String? mobileNumber;

  /// The mobile number prefix/country code.
  String? mobileNumberPrefix;

  /// Flag indicating if OTP was sent.
  String? sentOtp;

  /// Flag indicating if OTP should be verified.
  String? verifyOtp;

  /// Flag indicating if password should be updated.
  String? updatePassword;

  /// The OTP code entered by the user.
  String? otp;

  /// The language identifier for localization.
  String? languageId;  // New parameter added

  /// Creates an instance of [ForgotPasswordWithMobileRequestModel].
  ForgotPasswordWithMobileRequestModel({
    this.platform,
    this.version,
    this.websiteId,
    this.storeId,
    this.mobileNumber,
    this.mobileNumberPrefix,
    this.sentOtp,
    this.verifyOtp,
    this.updatePassword,
    this.otp,
    this.languageId,
  });

  /// Converts the model to a JSON map for API request.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform;
    data['version'] = version;
    data['websiteId'] = websiteId;
    data['storeId'] = storeId;
    data['mobileNumber'] = mobileNumber;
    data['mobileNumberPrefix'] = mobileNumberPrefix;
    data['sentOtp'] = sentOtp;
    data['verifyOtp'] = verifyOtp;
    data['updatePassword'] = updatePassword;
    data['otp'] = otp;
    data['languageId'] = languageId;  // Add to JSON map
    return data;
  }
}
