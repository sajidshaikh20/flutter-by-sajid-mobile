class GoogleLoginRequest {
  GoogleLoginRequest({required this.token});

  final String token;

  Map<String, dynamic> toJson() => <String, dynamic>{'token': token};
}
