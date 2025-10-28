import '../../../utils/exports.dart';

/// Simplified NotificationCubit for base template - UI only, no business logic
class NotificationCubit extends BaseCubit<NotificationState> {
  /// Initializes the cubit and loads notifications asynchronously.
  NotificationCubit({required this.notificationRepository}) : super(NotificationState.initial()) {
    // Business logic commented out for base template
    // displayShimmer();
    // scheduleMicrotask(() async => getNotifications());
  }

  /// The repository used for notification operations.
  final NotificationRepository notificationRepository;

  /// Fetches notifications - commented out for base template
  Future<void> getNotifications() async {
    // Business logic commented out for base template
    // emit(state.copyWith(status: BaseStateStatus.loading));
    // await notificationRepository.getNotificationList(...)
  }

  @override
  /// Resets the error message in the state.
  NotificationState getResetErrorState() => state.copyWith(msg: '');

  @override
  NotificationState getResetRedirectionState() => state.copyWith();
}
