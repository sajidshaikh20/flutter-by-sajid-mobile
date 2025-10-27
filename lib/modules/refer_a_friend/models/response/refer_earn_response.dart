/// Model class for refer and earn response data.
 class ReferEarnResponse {
  /// Indicates whether the request was successful.
  bool? success;

  /// Response message from the server.
  String? message;

  /// The referral code for sharing.
  String? referralCode;

  /// Creates a new instance of [ReferEarnResponse].
  ReferEarnResponse({this.success, this.message, this.referralCode});

  /// Creates a [ReferEarnResponse] instance from a JSON map.
  ReferEarnResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    referralCode = json['referralCode'];
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['referralCode'] = referralCode;
    return data;
  }
}
