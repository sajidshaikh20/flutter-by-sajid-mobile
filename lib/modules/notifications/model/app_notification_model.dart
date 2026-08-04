/// Model class representing a single app-specific notification item.
class AppNotificationModel {
  final dynamic id;
  final String title;
  final String message;
  final String? type;
  final String? entityId;
  final bool read;
  final String createdAt;

  AppNotificationModel({
    required this.id,
    required this.title,
    required this.message,
    this.type,
    this.entityId,
    required this.read,
    required this.createdAt,
  });

  /// Factory constructor to parse an AppNotificationModel from a JSON object.
  factory AppNotificationModel.fromJson(Map<String, dynamic> json) {
    return AppNotificationModel(
      id: json['id'],
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'],
      entityId: (json['tradeId'] ?? json['entityId'] ?? json['entity'])?.toString(),
      read: json['read'] ?? false,
      createdAt: json['sentAt'] ?? json['createdAt'] ?? '',
    );
  }
}
