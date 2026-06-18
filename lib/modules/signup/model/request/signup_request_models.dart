import '../../../../app/enums/enums.dart';

/// Request model for the /api/auth/start-registration API.
class StartRegistrationRequest {
  final String name;
  final String email;
  final UserRole role;

  StartRegistrationRequest({
    required this.name,
    required this.email,
    this.role = UserRole.client,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'role': role.value,
    };
  }
}

/// Request model for the /api/auth/verify-email-otp API.
class VerifyEmailOtpRequest {
  final String email;
  final String otp;

  VerifyEmailOtpRequest({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'otp': otp,
    };
  }
}

/// Request model for the /api/auth/send-phone-otp API.
class SendPhoneOtpRequest {
  final String email;
  final String countryCode;
  final String phone;

  SendPhoneOtpRequest({
    required this.email,
    required this.countryCode,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'countryCode': countryCode,
      'phone': phone,
    };
  }
}

/// Request model for the /api/auth/verify-phone-otp API.
class VerifyPhoneOtpRequest {
  final String email;
  final String countryCode;
  final String phone;
  final String otp;

  VerifyPhoneOtpRequest({
    required this.email,
    required this.countryCode,
    required this.phone,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'countryCode': countryCode,
      'phone': phone,
      'otp': otp,
    };
  }
}

/// Request model for the /api/auth/complete-registration API.
class CompleteRegistrationRequest {
  final String email;
  final String username;
  final String password;
  final String name;
  final String phone;
  final UserRole role;

  CompleteRegistrationRequest({
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    this.role = UserRole.client,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'username': username,
      'password': password,
      'name': name,
      'phone': phone,
      'role': role.value,
    };
  }
}
