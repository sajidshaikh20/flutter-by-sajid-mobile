/// Model class for sign up OTP request parameters.
class SignUpUserOtpRequestModel {
  /// The user's mobile number.
  final String mobileNumber;

  /// The mobile number prefix (country code).
  final String mobileNumberPrefix;

  /// The language ID for localization.
  final int languageId;

  /// The platform from which the request is made.
  final String platform;

  /// The app version.
  final String version;

  /// Optional referral code for signup.
  final String? referralCode;

  /// Creates a new instance of [SignUpUserOtpRequestModel].
  SignUpUserOtpRequestModel({
    required this.mobileNumber,
    required this.mobileNumberPrefix,
    required this.languageId,
    required this.platform,
    required this.version,
    this.referralCode, // optional in constructor
  });

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mobileNumber': mobileNumber,
      'mobileNumberPrefix': mobileNumberPrefix,
      'languageId': languageId,
      'platform': platform,
      'version': version,
      if (referralCode != null) 'referralCode': referralCode, // add only if not null
    };
  }
}
