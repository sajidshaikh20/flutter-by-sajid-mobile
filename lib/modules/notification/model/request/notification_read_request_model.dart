/// Model class for notification read request parameters.
class NotificationReadRequestModel {
  /// The language identifier.
  int? languageId;

  /// The customer authentication token.
  String? customerToken;

  /// The platform from which the request is made.
  String? platform;

  /// The application version.
  String? version;

  /// List of notification IDs to mark as read.
  List<int>? notifiactionIds;

  /// Creates an instance of [NotificationReadRequestModel].
  NotificationReadRequestModel({
    this.languageId,
    this.customerToken,
    this.platform,
    this.version,
    this.notifiactionIds,
  });

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['customerToken'] = customerToken;
    data['platform'] = platform;
    data['version'] = version;
    data['notifiactionIds'] = notifiactionIds;

    return data;
  }
}

