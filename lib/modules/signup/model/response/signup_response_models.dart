/// A generic success/failure response model for signup API calls.
class SignUpResponse {
  final String message;
  final bool success;

  SignUpResponse({required this.message, required this.success});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      message: json['message']?.toString() ?? '',
      success: json['success'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'success': success,
    };
  }
}
