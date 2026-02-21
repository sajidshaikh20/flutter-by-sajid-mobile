import '../../../utils/exports.dart';

/// UI-only NotificationCubit. No repository, no model types.
class NotificationCubit extends BaseCubit<NotificationState> {
  NotificationCubit() : super(NotificationState.initial()) {
    scheduleMicrotask(() => getNotifications());
  }

  Future<void> getNotifications() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(
      status: BaseStateStatus.success,
      listOfNotificationResponse: <Map<String, dynamic>>[],
      msg: '',
    ));
  }

  @override
  NotificationState getResetErrorState() => state.copyWith(msg: '');

  @override
  NotificationState getResetRedirectionState() => state.copyWith();
}
