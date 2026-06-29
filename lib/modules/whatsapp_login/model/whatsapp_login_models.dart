class SendLoginOtpRequest {
  SendLoginOtpRequest({
    required this.countryCode,
    required this.phone,
  });

  final String countryCode;
  final String phone;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'countryCode': countryCode,
        'phone': phone,
      };
}

class LoginWithOtpRequest {
  LoginWithOtpRequest({
    required this.countryCode,
    required this.phone,
    required this.otp,
  });

  final String countryCode;
  final String phone;
  final String otp;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'countryCode': countryCode,
        'phone': phone,
        'otp': otp,
      };
}
