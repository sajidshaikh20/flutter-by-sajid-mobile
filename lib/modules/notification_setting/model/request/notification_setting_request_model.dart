import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_setting_request_model.freezed.dart';
part 'notification_setting_request_model.g.dart';

/// Request model for notification settings.
@freezed
class NotificationSettingRequestModel with _$NotificationSettingRequestModel {
  /// Creates a [NotificationSettingRequestModel] instance.
  const factory NotificationSettingRequestModel({
    /// The language ID for localization.
    int? languageId,
    /// The platform identifier (e.g., 'android', 'ios', 'web').
    String? platform,
    /// The app version.
    String? version,
    /// The customer authentication token.
    String? customerToken,
    /// Whether to receive order status notifications.
    bool? orderStatus,
    /// Whether to receive loyalty points notifications.
    bool? loyalityPoints,
    /// Whether to receive promotion and offers notifications.
    bool? promotionOffers,
  }) = _NotificationSettingRequestModel;

  /// Creates a [NotificationSettingRequestModel] from a JSON map.
  factory NotificationSettingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingRequestModelFromJson(json);
}
