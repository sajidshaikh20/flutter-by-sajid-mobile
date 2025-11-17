import '../../../../utils/exports.dart';

/// Represents the state for notifications, extending `BaseState`.
class NotificationState extends BaseState {
  /// Creates a `NotificationState` with an optional
  /// `listOfNotificationResponse`.
  const NotificationState({
    required super.status,
    super.msg = '',
    super.redirectRoute,
    this.listOfNotificationResponse,
  });

  /// Holds the notification response data.
  final List<ListOfNotificationResponse>? listOfNotificationResponse;

  /// Returns a new instance of `NotificationState`
  /// with updated properties.
  NotificationState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    List<ListOfNotificationResponse>? listOfNotificationResponse,
  }) =>
      NotificationState(
        status: status ?? this.status,
        redirectRoute: redirectRoute,
        msg: msg,
        listOfNotificationResponse:
        listOfNotificationResponse ?? this.listOfNotificationResponse,
      );

  @override
  /// Properties used for state comparison.
  List<Object?> get props => <Object?>[
    ...super.props,
    listOfNotificationResponse,
  ];

  /// Creates an initial state instance.
  factory NotificationState.initial() {
    return const NotificationState(
      status: BaseStateStatus.initial,
    );
  }
}
