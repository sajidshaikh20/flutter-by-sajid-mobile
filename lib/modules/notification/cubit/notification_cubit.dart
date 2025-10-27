import '../../../utils/exports.dart';

/// Manages notification state and handles loading notifications
/// from a local JSON file.
class NotificationCubit extends BaseCubit<NotificationState> {


  /// Initializes the cubit and loads notifications asynchronously.
  NotificationCubit({required this.notificationRepository}) : super(NotificationState.initial()) {
    // Initialize the mixin's dependency here.
    displayShimmer();
    scheduleMicrotask(() async => getNotifications());
  }

  /// The repository used for notification operations.
  final NotificationRepository notificationRepository;


  /// Fetches notifications by calling `_loadNotifications()`.
  Future<void> getNotifications() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await notificationRepository
        .getNotificationList(
      NotificationRequestModel(
        customerToken: getIt<UserProfileService>().customerToken,
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        deviceId: getDeviceId()
      ),
    )
        .then(
            (ResponseHandler<BaseResponse<List<ListOfNotificationResponse>>> value) {
          if (value.isSuccess()) {
            final BaseResponse<List<ListOfNotificationResponse>>? notificationResponse =
                value.getSuccessInstance()?.response;
            emit(
              state.copyWith(
                status: BaseStateStatus.success,
                listOfNotificationResponse: notificationResponse?.data ?? <ListOfNotificationResponse>[],
              ),
            );
          } else if (value.isFailure()) {
            emit(
              state.copyWith(
                msg: value.getFailureInstance()?.error?.errorMessage ?? '',
                status: BaseStateStatus.failure,
              ),
            );
          }
        });
  }

  @override
  /// Resets the error message in the state.
  NotificationState getResetErrorState() => state.copyWith(msg: '');

  @override
  /// Resets the redirection state without modifying any fields.
  NotificationState getResetRedirectionState() => state.copyWith();

  /// Displays a shimmer effect by emitting loading state and then success after a delay.
  void displayShimmer(){
    emit(state.copyWith(status: BaseStateStatus.loading));
    unawaited(Future<void>.delayed(const Duration(seconds: Dimens.duration3), () {
      if (!isClosed)
      {
        emit(state.copyWith(status: BaseStateStatus.success));
      }

    }));
  }

  /// Calls the API to mark notifications as read.
  ///
  /// [notificationIds] List of notification IDs to mark as read.
  Future<void> callNotificationReadAPI(List<int>? notificationIds) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.loading,
      ),
    );
    //  Call the API
    final ResponseHandler<BaseResponse<dynamic>> response =
    await notificationRepository.readNotification(notificationIds);

    if (response.isSuccess()) {
      final bool isSuccess =
          response.getSuccessInstance()?.response.success ?? false;

      if (isSuccess) {
        emit(
          state.copyWith(
            status: BaseStateStatus.success,
            ),
        );
        await getNotifications();
      } else {
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
           ),
        );
      }
    } else if (response.isFailure()) {
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
         ),
      );
    }
  }
}
