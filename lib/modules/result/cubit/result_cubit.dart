import '../../../utils/exports.dart';

class ResultCubit extends BaseCubit<ResultState> {
  ResultCubit({required this.repository}) : super(ResultState.initial()) {
    unawaited(loadResults());
  }

  final ResultRepository repository;

  Future<void> loadResults({bool showShimmer = true}) async {
    if (showShimmer) {
      emit(state.copyWith(shimmerLoading: true));
    }

    try {
      final ResponseHandler<BaseResponse<List<TradeResultModel>>> response =
          await repository.getTradeResults(limit: 10, offset: 0);

      if (response.isSuccess()) {
        final BaseResponse<List<TradeResultModel>>? baseResponse =
            response.getSuccessInstance()?.response;
        if (baseResponse != null && baseResponse.success) {
          emit(state.copyWith(
            shimmerLoading: false,
            resultItems: baseResponse.data ?? <TradeResultModel>[],
            status: BaseStateStatus.success,
          ));
        } else {
          final String? errorMsg = baseResponse?.message;
          emit(state.copyWith(
            shimmerLoading: false,
            status: BaseStateStatus.failure,
            msg: (errorMsg != null && errorMsg.isNotEmpty)
                ? errorMsg
                : 'Failed to load results.',
          ));
        }
      } else {
        final OnFailureResponse<BaseResponse<List<TradeResultModel>>>? failure =
            response.getFailureInstance();
        final String? errorMsg = failure?.error?.errorMessage;
        emit(state.copyWith(
          shimmerLoading: false,
          status: BaseStateStatus.failure,
          msg: (errorMsg != null && errorMsg.isNotEmpty)
              ? errorMsg
              : 'Failed to load results. Please try again.',
        ));
      }
    } on Object catch (_) {
      emit(state.copyWith(
        shimmerLoading: false,
        status: BaseStateStatus.failure,
        msg: 'An unexpected error occurred. Please try again.',
      ));
    }
  }

  /// Pull-to-refresh
  Future<void> refreshResults() async {
    await loadResults(showShimmer: false);
  }

  @override
  ResultState getResetErrorState() => state.copyWith(msg: '');

  @override
  ResultState getResetRedirectionState() => state.copyWith();
}
