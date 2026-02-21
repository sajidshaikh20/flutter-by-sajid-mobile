import '../../../utils/exports.dart';

/// State for the notification screen. No model types — list of maps only.
class NotificationState extends BaseState {
  const NotificationState({
    required super.status,
    super.msg = '',
    super.redirectRoute,
    this.listOfNotificationResponse,
  });

  final List<Map<String, dynamic>>? listOfNotificationResponse;

  NotificationState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    List<Map<String, dynamic>>? listOfNotificationResponse,
  }) =>
      NotificationState(
        status: status ?? this.status,
        redirectRoute: redirectRoute,
        msg: msg,
        listOfNotificationResponse:
            listOfNotificationResponse ?? this.listOfNotificationResponse,
      );

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        listOfNotificationResponse,
      ];

  factory NotificationState.initial() {
    return const NotificationState(
      status: BaseStateStatus.initial,
    );
  }
}
