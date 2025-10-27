/// Model class for sign up response data.
class SignUpResponseModel {
  /// Indicates whether the signup was successful.
  bool? success;

  /// Response message from the server.
  String? message;

  /// Creates a new instance of [SignUpResponseModel].
  SignUpResponseModel({
    this.success,
    this.message,
  });

  /// Creates a [SignUpResponseModel] instance from a JSON map.
  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
