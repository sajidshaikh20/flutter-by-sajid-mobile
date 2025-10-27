/// Model to hold all signup form data for passing to OTP verification
class SignUpFormDataModel {
  /// The user's full name.
  final String fullName;

  /// The user's mobile number.
  final String mobileNumber;

  /// The mobile number prefix (country code).
  final String mobileNumberPrefix;

  /// The user's email address.
  final String email;

  /// The user's nationality.
  final String nationality;

  /// The user's date of birth.
  final String dateOfBirth;

  /// The referral code used during signup.
  final String referralCode;

  /// The user's password.
  final String password;

  /// The user's gender.
  final String gender;

  /// The device ID for tracking.
  final String? deviceId;

  /// Creates a new instance of [SignUpFormDataModel].
  SignUpFormDataModel({
    required this.fullName,
    required this.mobileNumber,
    required this.mobileNumberPrefix,
    required this.email,
    required this.nationality,
    required this.dateOfBirth,
    required this.referralCode,
    required this.password,
    required this.gender,
    this.deviceId,
  });

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'mobileNumberPrefix': mobileNumberPrefix,
      'email': email,
      'nationality': nationality,
      'dateOfBirth': dateOfBirth,
      'referralCode': referralCode,
      'password': password,
      'gender': gender,
      'deviceId': deviceId,
    };
  }

  /// Creates a [SignUpFormDataModel] instance from a JSON map.
  factory SignUpFormDataModel.fromJson(Map<String, dynamic> json) {
    return SignUpFormDataModel(
      fullName: json['fullName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      mobileNumberPrefix: json['mobileNumberPrefix'] ?? '',
      email: json['email'] ?? '',
      nationality: json['nationality'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      referralCode: json['referralCode'] ?? '',
      password: json['password'] ?? '',
      gender: json['gender'] ?? '',
      deviceId: json['deviceId'],
    );
  }
} 