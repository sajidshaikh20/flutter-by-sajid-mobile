part of 'notification_setting_cubit.dart';

/// Abstract base class for notification setting states.
@immutable
abstract class NotificationSettingState {}

/// Initial state for notification settings with current values and status.
class NotificationSettingInitial extends NotificationSettingState {
  /// Whether order status notifications are enabled.
  final bool orderStatuses;

  /// Whether loyalty points notifications are enabled.
  final bool loyaltyPoints;

  /// Whether promotion offers notifications are enabled.
  final bool promotionOffers;

  /// Current state status.
  final BaseStateStatus status;

  /// Optional status message.
  final String? message;

  /// Creates an instance of [NotificationSettingInitial].
  NotificationSettingInitial({
    this.orderStatuses = true,
    this.loyaltyPoints = true,
    this.promotionOffers = true,
    this.status = BaseStateStatus.initial,
    this.message,
  });

  /// Creates a copy of this [NotificationSettingInitial] with optional new values.
  NotificationSettingInitial copyWith({
    bool? orderStatuses,
    bool? loyaltyPoints,
    bool? promotionOffers,
    BaseStateStatus? status,
    String? message,
  }) {
    return NotificationSettingInitial(
      orderStatuses: orderStatuses ?? this.orderStatuses,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      promotionOffers: promotionOffers ?? this.promotionOffers,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}