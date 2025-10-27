import '../../../utils/exports.dart';

/// Orchestrates loading and state updates for the rewards history view.
class ViewRewardHistoryCubit extends Cubit<ViewRewardHistoryState> {
  /// Creates a new instance of [ViewRewardHistoryCubit].
  ViewRewardHistoryCubit({
    required this.referEarnRepositoryImpl,
    required ViewRewardHistoryState initialState,
  }) : super(initialState);

  /// The repository implementation for handling reward history operations.
  final ViewRewardHistoryRepositoryImpl referEarnRepositoryImpl;

  /// Calls the repository to fetch the rewards history list and points.
  Future<void> _callReferEarnApi() async {
    await referEarnRepositoryImpl
        .getRewardsList(ViewRewardHistoryRequest(
      customerToken: getIt<UserProfileService>().customerToken,
      websiteId: getIt<CountryService>().websiteId,
    ))
        .then(
      (ResponseHandler<ViewRewardHistoryResponse> value) {
        if (value.isSuccess()) {
          ViewRewardHistoryResponse? response = value.getSuccessInstance()?.response;
          if (response?.success ?? false) {
            emit(state.copyWith(
                status: BaseStateStatus.success,
                count: value.getSuccessInstance()?.response.customerPoints));
          }
        }
        if (value.isFailure()) {
          emit(state.copyWith(
              status: BaseStateStatus.failure,
              errorMessage: value.getFailureInstance()?.error?.errorMessage ?? ""));
        }
      },
    );
  }

  /// Kicks off initial loading for the screen.
  void init() {
    scheduleMicrotask(
          () async => _callReferEarnApi(),
    );
  }
}
