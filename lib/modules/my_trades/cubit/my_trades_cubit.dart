import '../../../utils/exports.dart';

/// Cubit managing My Trades page state including search queries and category/status filtering.
class MyTradesCubit extends BaseCubit<MyTradesState> {
  MyTradesCubit({required this.repository}) : super(MyTradesState.initial()) {
    unawaited(loadMyTrades(isRefresh: true));
  }

  final TradesRepository repository;

  /// Cancels in-flight requests when filter changes or refresh is triggered.
  int _loadGeneration = 0;

  static const int _pageLimit = 10;

  /// Loads the first page (initial load or filter change).
  Future<void> loadMyTrades({bool isRefresh = false}) async {
    if (isRefresh) {
      _loadGeneration++;
    } else if (state.isInitialLoading || state.isLoadingMore || state.hasReachedMax) {
      return;
    }
    await _fetchTrades(isRefresh: isRefresh || state.signals.isEmpty, isLoadMore: false);
  }

  /// Loads the next page when the user scrolls near the bottom.
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
    final SignalFilter filter = state.selectedFilter;

    if (isLoadMore) {
      emit(state.copyWith(isLoadingMore: true));
    } else {
      emit(state.copyWith(
        status: BaseStateStatus.loading,
        isLoadingMore: false,
        msg: '',
      ));
    }

    final String? statusParam = _statusParamForFilter(filter);

    final List<Future<dynamic>> futures = <Future<dynamic>>[
      repository.getMyTrades(
        status: statusParam,
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
      final int totalCount = baseResponse?.totalCount ?? 0;

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

  String? _statusParamForFilter(SignalFilter filter) {
    switch (filter) {
      case SignalFilter.all:
        return null;
      case SignalFilter.active:
        return 'ACTIVE';
      case SignalFilter.pending:
        return 'PENDING';
      case SignalFilter.closed:
        return 'CLOSED';
      case SignalFilter.cancelled:
        return 'CANCEL';
    }
  }

  /// Updates the currently selected filter and reloads from the first page.
  void selectFilter(SignalFilter filter) {
    if (state.selectedFilter == filter) return;

    _loadGeneration++;
    emit(state.copyWith(
      selectedFilter: filter,
      offset: 0,
      hasReachedMax: false,
      isLoadingMore: false,
      signals: const <TradingSignalModel>[],
      status: BaseStateStatus.loading,
      msg: '',
    ));
    unawaited(_fetchTrades(isRefresh: true, isLoadMore: false));
  }

  /// Updates the search query text.
  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  /// Clears the current search query.
  void clearSearch() {
    emit(state.copyWith(searchQuery: ''));
  }

  @override
  MyTradesState getResetErrorState() => state.copyWith(msg: '');

  @override
  MyTradesState getResetRedirectionState() => state.copyWith();
}
