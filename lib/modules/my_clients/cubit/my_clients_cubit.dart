import '../../../utils/exports.dart';
import '../model/trade_with_clients_model.dart';
import '../repo/my_clients_repository.dart';
import 'my_clients_state.dart';

class MyClientsCubit extends BaseCubit<MyClientsState> {
  MyClientsCubit({required this.repository}) : super(MyClientsState.initial()) {
    unawaited(loadMyClients());
  }

  final MyClientsRepository repository;

  static const int _pageLimit = 10;

  Future<void> loadMyClients({bool isRefresh = false}) async {
    emit(state.copyWith(
      status: BaseStateStatus.loading,
      offset: 0,
      hasReachedMax: false,
      isLoadingMore: false,
      totalCount: 0,
    ));

    final ResponseHandler<BaseResponse<List<TradeWithClientsModel>>> response =
        await repository.getMyClients(
      limit: _pageLimit,
      offset: 0,
    );

    if (response.isSuccess()) {
      final BaseResponse<List<TradeWithClientsModel>>? baseResponse =
          response.getSuccessInstance()?.response;
      final List<TradeWithClientsModel> data = baseResponse?.data ?? <TradeWithClientsModel>[];
      final int totalCount = baseResponse?.totalCount ?? data.length;

      emit(state.copyWith(
        status: BaseStateStatus.success,
        trades: data,
        offset: data.length,
        totalCount: totalCount,
        hasReachedMax: data.length < _pageLimit || data.length >= totalCount,
      ));
    } else {
      final OnFailureResponse<BaseResponse<List<TradeWithClientsModel>>>? failure =
          response.getFailureInstance();
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: failure?.error?.errorMessage ?? 'Failed to load clients list.',
        hasReachedMax: true,
      ));
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.hasReachedMax || state.status == BaseStateStatus.loading) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final int currentOffset = state.offset;
    final ResponseHandler<BaseResponse<List<TradeWithClientsModel>>> response =
        await repository.getMyClients(
      limit: _pageLimit,
      offset: currentOffset,
    );

    if (response.isSuccess()) {
      final BaseResponse<List<TradeWithClientsModel>>? baseResponse =
          response.getSuccessInstance()?.response;
      final List<TradeWithClientsModel> data = baseResponse?.data ?? <TradeWithClientsModel>[];
      final int totalCount = baseResponse?.totalCount ?? state.totalCount;

      final List<TradeWithClientsModel> updatedTrades = List<TradeWithClientsModel>.from(state.trades)
        ..addAll(data);

      emit(state.copyWith(
        status: BaseStateStatus.success,
        trades: updatedTrades,
        offset: currentOffset + data.length,
        isLoadingMore: false,
        totalCount: totalCount,
        hasReachedMax: data.length < _pageLimit || updatedTrades.length >= totalCount,
      ));
    } else {
      final OnFailureResponse<BaseResponse<List<TradeWithClientsModel>>>? failure =
          response.getFailureInstance();
      emit(state.copyWith(
        isLoadingMore: false,
        status: BaseStateStatus.failure,
        msg: failure?.error?.errorMessage ?? 'Failed to load more clients.',
      ));
    }
  }

  @override
  MyClientsState getResetErrorState() => state.copyWith(msg: '');

  @override
  MyClientsState getResetRedirectionState() => state.copyWith();
}
