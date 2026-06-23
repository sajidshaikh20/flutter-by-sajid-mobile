import '../../../utils/exports.dart';

/// Cubit managing My Trades page — uses `/client/my-trades` API only.
class MyTradesCubit extends BaseCubit<MyTradesState> {
  MyTradesCubit({required this.repository}) : super(MyTradesState.initial()) {
    unawaited(loadMyTrades(isRefresh: true));
  }

  final MyTradesRepository repository;

  int _loadGeneration = 0;

  static const int _pageLimit = 10;

  Future<void> loadMyTrades({bool isRefresh = false}) async {
    if (isRefresh) {
      _loadGeneration++;
    } else if (state.isInitialLoading || state.isLoadingMore || state.hasReachedMax) {
      return;
    }
    await _fetchTrades(isRefresh: isRefresh || state.signals.isEmpty, isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore ||
        state.hasReachedMax ||
        state.isInitialLoading ||
        state.status == BaseStateStatus.loading) {
      return;
    }
    await _fetchTrades(isRefresh: false, isLoadMore: true);
  }

  Future<void> _fetchTrades({required bool isRefresh, required bool isLoadMore}) async {
    final int generation = _loadGeneration;
    final int currentOffset = isRefresh ? 0 : state.offset;

    if (isLoadMore) {
      emit(state.copyWith(isLoadingMore: true));
    } else {
      emit(state.copyWith(
        status: BaseStateStatus.loading,
        isLoadingMore: false,
        msg: '',
        signals: isRefresh ? <TradingSignalModel>[] : null,
      ));
    }

    final List<Future<dynamic>> futures = <Future<dynamic>>[
      repository.getMyTrades(
        status: _mapFilterToStatus(state.selectedFilter),
        limit: _pageLimit,
        offset: currentOffset,
      ),
    ];

    final bool needCounts = currentOffset == 0;
    if (needCounts) {
      futures.add(repository.getMyTrades());
    }

    final List<dynamic> responses = await Future.wait<dynamic>(futures);

    if (generation != _loadGeneration) return;

    final ResponseHandler<BaseResponse<List<TradeResponse>>> response =
        responses[0] as ResponseHandler<BaseResponse<List<TradeResponse>>>;

    int activeCount = state.activeCount;
    int pendingCount = state.pendingCount;
    int closedCount = state.closedCount;
    int lossesCount = state.lossesCount;

    if (needCounts && responses.length > 1) {
      final ResponseHandler<BaseResponse<List<TradeResponse>>> allTradesResponse =
          responses[1] as ResponseHandler<BaseResponse<List<TradeResponse>>>;
      if (allTradesResponse.isSuccess()) {
        final List<TradeResponse> allApiTrades =
            allTradesResponse.getSuccessInstance()?.response.data ?? <TradeResponse>[];
        activeCount =
            allApiTrades.where((TradeResponse t) => t.status.toUpperCase() == 'ACTIVE').length;
        pendingCount =
            allApiTrades.where((TradeResponse t) => t.status.toUpperCase() == 'PENDING').length;
        closedCount =
            allApiTrades.where((TradeResponse t) => t.status.toUpperCase() == 'CLOSED').length;
        lossesCount = allApiTrades
            .where((TradeResponse t) =>
                t.status.toUpperCase() == 'CLOSED' && t.outcome?.toUpperCase() == 'LOSS')
            .length;
      }
    }

    if (response.isSuccess()) {
      final BaseResponse<List<TradeResponse>>? baseResponse =
          response.getSuccessInstance()?.response;
      final List<TradeResponse> apiTrades = baseResponse?.data ?? <TradeResponse>[];
      final int totalCount = baseResponse?.totalCount ?? apiTrades.length;

      final List<TradingSignalModel> newMappedSignals = apiTrades
          .map((TradeResponse t) => t.toTradingSignalModel(isTaken: true))
          .toList();

      final List<TradingSignalModel> updatedSignals = isRefresh || currentOffset == 0
          ? newMappedSignals
          : <TradingSignalModel>[...state.signals, ...newMappedSignals];

      emit(state.copyWith(
        signals: updatedSignals,
        status: BaseStateStatus.success,
        isLoadingMore: false,
        offset: currentOffset + apiTrades.length,
        hasReachedMax: updatedSignals.length >= totalCount || apiTrades.length < _pageLimit,
        totalCount: totalCount,
        activeCount: activeCount,
        pendingCount: pendingCount,
        closedCount: closedCount,
        lossesCount: lossesCount,
      ));
    } else {
      final OnFailureResponse<BaseResponse<List<TradeResponse>>>? failure =
          response.getFailureInstance();
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        isLoadingMore: false,
        msg: failure?.error?.errorMessage ?? 'Failed to load user trades.',
      ));
    }
  }

  void selectFilter(SignalFilter filter) {
    if (state.selectedFilter == filter) return;
    emit(state.copyWith(selectedFilter: filter));
    unawaited(loadMyTrades(isRefresh: true));
  }

  String? _mapFilterToStatus(SignalFilter filter) {
    switch (filter) {
      case SignalFilter.active:
        return 'ACTIVE';
      case SignalFilter.pending:
        return 'PENDING';
      case SignalFilter.closed:
        return 'CLOSED';
      case SignalFilter.cancelled:
        return 'CANCEL';
      case SignalFilter.all:
        return null;
    }
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void clearSearch() {
    emit(state.copyWith(searchQuery: ''));
  }

  @override
  MyTradesState getResetErrorState() => state.copyWith(msg: '');

  @override
  MyTradesState getResetRedirectionState() => state.copyWith();
}
