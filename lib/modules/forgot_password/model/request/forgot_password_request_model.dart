/// Request model for forgot password with email.
class ForgotPasswordRequestModel {
  /// Creates [ForgotPasswordRequestModel].
  const ForgotPasswordRequestModel({required this.email});

  /// User email address.
  final String email;

  /// Converts to JSON for API request.
  Map<String, dynamic> toJson() => <String, dynamic>{'email': email};
}
