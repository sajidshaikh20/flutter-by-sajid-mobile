class ClientProfileResponse {
  final String publicId;
  final String name;
  final String email;
  final String username;
  final String? phone;
  final String? countryCode;
  final String? profilePictureUrl;

  ClientProfileResponse({
    required this.publicId,
    required this.name,
    required this.email,
    required this.username,
    this.phone,
    this.countryCode,
    this.profilePictureUrl,
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
    };
  }
}

class UpdateClientProfileRequest {
  final String name;
  final String username;
  final String phone;

  UpdateClientProfileRequest({
    required this.name,
    required this.username,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'phone': phone,
    };
  }
}
