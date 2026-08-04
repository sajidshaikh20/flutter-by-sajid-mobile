import 'app_notification_model.dart';

/// Container class representing a paginated response of notifications.
class PaginatedNotifications {
  final List<AppNotificationModel> content;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int number;

  PaginatedNotifications({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.number,
  });

  /// Factory constructor to parse PaginatedNotifications from JSON.
  factory PaginatedNotifications.fromJson(Map<String, dynamic> json) {
    final List<dynamic> contentList = json['content'] as List<dynamic>? ?? <dynamic>[];
    return PaginatedNotifications(
      content: contentList
          .map((dynamic item) => AppNotificationModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'] ?? 1,
      totalElements: json['totalElements'] ?? 0,
      last: json['last'] ?? true,
      number: json['number'] ?? 0,
    );
  }
}
