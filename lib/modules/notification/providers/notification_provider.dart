import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/notification_state.dart';
import '../repo/notification_repository.dart';

/// Notifier for managing notification state (Riverpod version).
class NotificationNotifier extends StateNotifier<NotificationState> {
  /// Creates a [NotificationNotifier] instance.
  NotificationNotifier({required this.notificationRepository})
      : super(NotificationState.initial()) {
    // Business logic commented out for base template
    // displayShimmer();
    // scheduleMicrotask(() async => getNotifications());
  }

  /// The repository used for notification operations.
  final NotificationRepository notificationRepository;

  /// Fetches notifications - commented out for base template
  Future<void> getNotifications() async {
    // Business logic commented out for base template
    // state = state.copyWith(status: BaseStateStatus.loading);
    // await notificationRepository.getNotificationList(...)
  }
}

/// Provider for NotificationRepository.
final Provider<NotificationRepository> notificationRepositoryProvider =
    Provider<NotificationRepository>((ProviderRef<NotificationRepository> ref) {
  return NotificationRepositoryImpl();
});

/// Provider for NotificationNotifier.
final AutoDisposeStateNotifierProvider<NotificationNotifier, NotificationState> notificationNotifierProvider =
    StateNotifierProvider.autoDispose<NotificationNotifier, NotificationState>(
  (AutoDisposeStateNotifierProviderRef<NotificationNotifier, NotificationState> ref) {
    final NotificationRepository repository = ref.watch(notificationRepositoryProvider);
    return NotificationNotifier(notificationRepository: repository);
  },
);

