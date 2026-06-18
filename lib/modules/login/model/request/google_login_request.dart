class GoogleLoginRequest {
  GoogleLoginRequest({
    required this.token,
    this.role = 'CLIENT',
  });

  final String token;
  final String role;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'token': token,
        'role': role,
      };
}
