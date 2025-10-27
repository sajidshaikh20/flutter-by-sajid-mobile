
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_of_notification_response.freezed.dart';
part 'list_of_notification_response.g.dart';

/// Response model for a list of notifications.
@freezed
class ListOfNotificationResponse with _$ListOfNotificationResponse {
  /// Creates a [ListOfNotificationResponse] instance.
  const factory ListOfNotificationResponse({
    /// The unique identifier for the notification.
    int? notificationId,
    /// The title of the notification.
    String? notificationTitle,
    /// The subtitle of the notification.
    String? notificationSubTitle,
    /// The detailed description of the notification.
    String? notificationDescription,
    /// The detailed description of the notification in Arabic.
    String? notificationDescriptionArabic,
    /// The date and time when the notification was created.
    String? dateTime,
    /// The type of notification (e.g., 'order', 'promotion', 'loyalty').
    String? notificationType,
    ///order Id
    int? orderId,
    ///Product id array
    String? entityId,
    /// Whether the notification has been read by the user.
    @Default(false) bool isRead,
  }) = _ListOfNotificationResponse;

  /// Creates a [ListOfNotificationResponse] from a JSON map.
  factory ListOfNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$ListOfNotificationResponseFromJson(json);
}

/// Extension methods for working with lists of notifications.
extension ListOfNotificationResponseListExtension on List<ListOfNotificationResponse> {
  /// Converts a list of [ListOfNotificationResponse] to JSON.
  String toJsonString() => jsonEncode(map((ListOfNotificationResponse x) => x.toJson()).toList());

  /// Creates a list of [ListOfNotificationResponse] from a JSON string.
  static List<ListOfNotificationResponse> fromJsonString(String str) =>
      List<ListOfNotificationResponse>.from(
        (jsonDecode(str) as List<dynamic>).map((dynamic x) => ListOfNotificationResponse.fromJson(x as Map<String, dynamic>)),
      );
}
