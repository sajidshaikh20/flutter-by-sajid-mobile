import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_request_model.freezed.dart';
part 'notification_request_model.g.dart';

/// Request model for notification operations.
@freezed
class NotificationRequestModel with _$NotificationRequestModel {
  /// Creates a [NotificationRequestModel] instance.
  const factory NotificationRequestModel({
    /// The language ID for localization.
    int? languageId,
    /// The customer authentication token.
    String? customerToken,
    /// The platform identifier (e.g., 'android', 'ios', 'web').
    String? platform,
    /// The app version.
    String? version,
    /// Device identifier for tracking and analytics.
    String? deviceId,
  }) = _NotificationRequestModel;

  /// Creates a [NotificationRequestModel] from a JSON map.
  factory NotificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestModelFromJson(json);
}


