import 'package:image_picker/image_picker.dart';

class ClientProfileResponse {
  final String publicId;
  final String name;
  final String email;
  final String username;
  final String? phone;
  final String? countryCode;
  final String? profilePictureUrl;
  final double? amountBalance;
  final double? riskPercentage;
  final bool? firstTimeLogin;

  ClientProfileResponse({
    required this.publicId,
    required this.name,
    required this.email,
    required this.username,
    this.phone,
    this.countryCode,
    this.profilePictureUrl,
    this.amountBalance,
    this.riskPercentage,
    this.firstTimeLogin,
  });

  factory ClientProfileResponse.fromJson(Map<String, dynamic> json) {
    return ClientProfileResponse(
      publicId: json['publicId'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone']?.toString(),
      countryCode: json['countryCode']?.toString(),
      profilePictureUrl: json['profilePictureUrl']?.toString(),
      amountBalance: json['amountBalance'] != null ? double.tryParse(json['amountBalance'].toString()) : null,
      riskPercentage: json['riskPercentage'] != null ? double.tryParse(json['riskPercentage'].toString()) : null,
      firstTimeLogin: json['firstTimeLogin'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'publicId': publicId,
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'countryCode': countryCode,
      'profilePictureUrl': profilePictureUrl,
      'amountBalance': amountBalance,
      'riskPercentage': riskPercentage,
      'firstTimeLogin': firstTimeLogin,
    };
  }
}

class UpdateClientProfileRequest {
  final String name;
  final String phone;
  final String countryCode;
  final XFile? profilePicture;

  UpdateClientProfileRequest({
    required this.name,
    required this.phone,
    required this.countryCode,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'countryCode': countryCode,
    };
  }
}

class TradingPreferencesResponse {
  final double amountBalance;
  final double riskPercentage;

  TradingPreferencesResponse({
    required this.amountBalance,
    required this.riskPercentage,
  });

  factory TradingPreferencesResponse.fromJson(Map<String, dynamic> json) {
    return TradingPreferencesResponse(
      amountBalance: json['amountBalance'] != null
          ? double.parse(json['amountBalance'].toString())
          : 1000.00,
      riskPercentage: json['riskPercentage'] != null
          ? double.parse(json['riskPercentage'].toString())
          : 1.00,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'amountBalance': amountBalance,
      'riskPercentage': riskPercentage,
    };
  }
}
