import '../../../../utils/exports.dart';

part 'notification_setting_state.dart';

/// Cubit that manages notification settings state and operations.
class NotificationSettingCubit extends Cubit<NotificationSettingState> {
  /// Creates a notification setting cubit.
  ///
  /// [repository] The repository for notification setting operations.
  /// [initialOrderStatus] Initial value for order status notifications.
  /// [initialLoyaltyPoints] Initial value for loyalty points notifications.
  /// [initialPromotionOffers] Initial value for promotion offers notifications.
  NotificationSettingCubit({
    required NotificationSettingRepository repository,
    bool? initialOrderStatus,
    bool? initialLoyaltyPoints,
    bool? initialPromotionOffers,
  })  : _repository = repository,
        super(NotificationSettingInitial(
          orderStatuses: initialOrderStatus ?? true,
          loyaltyPoints: initialLoyaltyPoints ?? true,
          promotionOffers: initialPromotionOffers ?? true,
        )) {
    DebugLog.instance.i('NotificationSettingCubit: Initialized with values:');
    DebugLog.instance.i('  - initialOrderStatus: $initialOrderStatus (final: ${initialOrderStatus ?? true})');
    DebugLog.instance.i('  - initialLoyaltyPoints: $initialLoyaltyPoints (final: ${initialLoyaltyPoints ?? true})');
    DebugLog.instance.i('  - initialPromotionOffers: $initialPromotionOffers (final: ${initialPromotionOffers ?? true})');
  }

  final NotificationSettingRepository _repository;

  /// Toggle order status notifications
  void toggleOrderStatuses({required bool value}) {
    final NotificationSettingInitial currentState =
        state as NotificationSettingInitial;
    emit(currentState.copyWith(orderStatuses: value));

    // Call API to update notification settings
    unawaited(_callNotificationSettingAPI());
  }

  /// Toggle loyalty points notifications
  void toggleLoyaltyPoints({required bool value}) {
    final NotificationSettingInitial currentState =
        state as NotificationSettingInitial;
    emit(currentState.copyWith(loyaltyPoints: value));

    // Call API to update notification settings
    unawaited(_callNotificationSettingAPI());
  }

  /// Toggle promotion offers notifications
  void togglePromotionOffers({required bool value}) {
    final NotificationSettingInitial currentState =
        state as NotificationSettingInitial;
    emit(currentState.copyWith(promotionOffers: value));

    // Call API to update notification settings
    unawaited(_callNotificationSettingAPI());
  }

  /// Call API to update notification settings
  Future<void> _callNotificationSettingAPI() async {
    try {
      final NotificationSettingInitial currentState =
          state as NotificationSettingInitial;

      // Emit loading state
      emit(NotificationSettingInitial(
        status: BaseStateStatus.loading,
        orderStatuses: currentState.orderStatuses,
        loyaltyPoints: currentState.loyaltyPoints,
        promotionOffers: currentState.promotionOffers,
      ));

      // Call the API with NotificationSettingRequestModel
      final ResponseHandler<BaseResponse<dynamic>> response =
          await _repository.callNotificationSetting(
        requestModel: NotificationSettingRequestModel(
          languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
          platform: getPlatformName(),
          version: getIt<MainConfig>().packageInfo.version,
          customerToken: getIt<UserProfileService>().customerToken,
          orderStatus: currentState.orderStatuses,
          loyalityPoints: currentState.loyaltyPoints,
          promotionOffers: currentState.promotionOffers,
        ),
      );

      if (response.isSuccess()) {
        final BaseResponse<dynamic>? apiResponse =
            response.getSuccessInstance()?.response;

        if (apiResponse?.success ?? false) {
          // API call successful
          emit(NotificationSettingInitial(
              orderStatuses: currentState.orderStatuses,
              loyaltyPoints: currentState.loyaltyPoints,
              promotionOffers: currentState.promotionOffers,
              message: apiResponse?.message ?? '',
              status: BaseStateStatus.success));
        } else {
          // API returned success=false
          emit(NotificationSettingInitial(
              orderStatuses: currentState.orderStatuses,
              loyaltyPoints: currentState.loyaltyPoints,
              promotionOffers: currentState.promotionOffers,
              message: apiResponse?.error ?? '',
              status: BaseStateStatus.failure));
        }
      } else {
        // API call failed
        final OnFailureResponse<BaseResponse<dynamic>>? error =
            response.getFailureInstance();
        emit(NotificationSettingInitial(
            orderStatuses: currentState.orderStatuses,
            loyaltyPoints: currentState.loyaltyPoints,
            promotionOffers: currentState.promotionOffers,
            message: error?.error?.errorMessage ?? '',
            status: BaseStateStatus.failure));

        // Reset to initial state after error
        Future<void>.delayed(const Duration(seconds: Dimens.duration2), () {
          emit(currentState.copyWith(
            status: BaseStateStatus.failure,
            message: error?.error?.errorMessage ?? '',
          ));
        });
      }
    } on Exception catch (e) {
      DebugLog.instance.e('$e');
      final NotificationSettingInitial currentState =
          state as NotificationSettingInitial;
      emit(NotificationSettingInitial(
        orderStatuses: currentState.orderStatuses,
        loyaltyPoints: currentState.loyaltyPoints,
        promotionOffers: currentState.promotionOffers,
        status: BaseStateStatus.failure,
      ));
    }
  }

  /// Clear any status messages
  void clearMessage() {
    final NotificationSettingInitial currentState =
        state as NotificationSettingInitial;
    emit(currentState.copyWith(
      status: BaseStateStatus.initial,
    ));
  }
}
