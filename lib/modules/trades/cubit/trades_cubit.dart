import '../../../utils/exports.dart';

/// Cubit managing Trades (Trading Signals) tab — uses `/trade/my-trades-by-plan` API.
class TradesCubit extends BaseCubit<TradesState> {
  TradesCubit({required this.repository}) : super(TradesState.initial()) {
    unawaited(loadTrades(isRefresh: true));
  }

  final TradesRepository repository;

  Timer? _searchDebounce;

  int _loadGeneration = 0;

  static const int _pageLimit = 10;

  Future<void> loadTrades({bool isRefresh = false}) async {
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

    final bool isSearch = state.searchQuery.trim().isNotEmpty;
    final List<Future<dynamic>> futures = <Future<dynamic>>[];

    if (isSearch) {
      futures.add(repository.searchTrades(keyword: state.searchQuery.trim()));
    } else {
      futures.add(repository.getTradesByPlan(
        status: _mapFiltersToStatus(state.selectedFilters),
        limit: _pageLimit,
        offset: currentOffset,
        fromDate: state.fromDate,
        toDate: state.toDate,
      ));

      final bool needCounts = currentOffset == 0;
      if (needCounts) {
        futures.add(repository.getTradesByPlan(
          fromDate: state.fromDate,
          toDate: state.toDate,
        ));
      }
    }

    final List<dynamic> responses = await Future.wait<dynamic>(futures);

    if (generation != _loadGeneration) return;

    if (isSearch) {
      final ResponseHandler<BaseResponse<List<TradeResponse>>> response =
          responses[0] as ResponseHandler<BaseResponse<List<TradeResponse>>>;

      if (response.isSuccess()) {
        final BaseResponse<List<TradeResponse>>? baseResponse =
            response.getSuccessInstance()?.response;
        final List<TradeResponse> apiTrades = baseResponse?.data ?? <TradeResponse>[];
        final int totalCount = baseResponse?.totalCount ?? apiTrades.length;

        final List<TradingSignalModel> newMappedSignals = apiTrades
            .map((TradeResponse t) => t.toTradingSignalModel())
            .toList();

        emit(state.copyWith(
          signals: newMappedSignals,
          status: BaseStateStatus.success,
          isLoadingMore: false,
          offset: apiTrades.length,
          hasReachedMax: true,
          totalCount: totalCount,
        ));
      } else {
        final OnFailureResponse<BaseResponse<List<TradeResponse>>>? failure =
            response.getFailureInstance();
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          isLoadingMore: false,
          msg: failure?.error?.errorMessage ?? 'Failed to load trade signals.',
        ));
      }
      return;
    }

    final ResponseHandler<BaseResponse<List<TradeResponse>>> response =
        responses[0] as ResponseHandler<BaseResponse<List<TradeResponse>>>;

    int activeCount = state.activeCount;
    int pendingCount = state.pendingCount;
    int closedCount = state.closedCount;
    int lossesCount = state.lossesCount;

    final bool needCounts = currentOffset == 0;
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
          .map((TradeResponse t) => t.toTradingSignalModel())
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
        msg: failure?.error?.errorMessage ?? 'Failed to load trade signals.',
      ));
    }
  }

  Future<void> takeTrade(String tradePublicId) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final ResponseHandler<BaseResponse<dynamic>> response = await repository.takeTrade(tradePublicId);
    if (response.isSuccess()) {
      emit(state.copyWith(
        status: BaseStateStatus.success,
        msg: 'Trade taken successfully!',
      ));
      await loadTrades(isRefresh: true);
    } else {
      final OnFailureResponse<BaseResponse<dynamic>>? failure = response.getFailureInstance();
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: failure?.error?.errorMessage ?? 'Failed to take trade.',
      ));
    }
  }

  void selectFilter(SignalFilter filter) {
    final Set<SignalFilter> current = Set<SignalFilter>.from(state.selectedFilters);
    if (filter == SignalFilter.all) {
      current
        ..clear()
        ..add(SignalFilter.all);
    } else {
      current.remove(SignalFilter.all);
      if (current.contains(filter)) {
        current.remove(filter);
      } else {
        current.add(filter);
      }
      if (current.isEmpty) {
        current.add(SignalFilter.all);
      }
    }
    emit(state.copyWith(selectedFilters: current));
    unawaited(loadTrades(isRefresh: true));
  }

  String? _mapFiltersToStatus(Set<SignalFilter> filters) {
    if (filters.contains(SignalFilter.all)) return null;
    final List<String> mapped = <String>[];
    for (final SignalFilter filter in filters) {
      switch (filter) {
        case SignalFilter.active:
          mapped.add('ACTIVE');
        case SignalFilter.pending:
          mapped.add('PENDING');
        case SignalFilter.closed:
          mapped.add('CLOSED');
        case SignalFilter.cancelled:
          mapped.add('CANCEL');
        default:
          break;
      }
    }
    return mapped.isEmpty ? null : mapped.join(',');
  }

  void updateSearchQuery(String query) {
    final String trimmed = query.trim();
    final String oldQuery = state.searchQuery.trim();

    if (trimmed.isEmpty) {
      _searchDebounce?.cancel();
      if (state.cachedSignals.isNotEmpty) {
        emit(state.copyWith(
          searchQuery: '',
          signals: state.cachedSignals,
          offset: state.cachedOffset,
          hasReachedMax: state.cachedHasReachedMax,
          cachedSignals: const <TradingSignalModel>[],
        ));
      } else {
        emit(state.copyWith(searchQuery: ''));
        unawaited(loadTrades(isRefresh: true));
      }
      return;
    }

    if (oldQuery.isEmpty) {
      emit(state.copyWith(
        searchQuery: query,
        cachedSignals: state.signals,
        cachedOffset: state.offset,
        cachedHasReachedMax: state.hasReachedMax,
      ));
    } else {
      emit(state.copyWith(searchQuery: query));
    }

    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      unawaited(loadTrades(isRefresh: true));
    });
  }

  void clearSearch() {
    _searchDebounce?.cancel();
    if (state.cachedSignals.isNotEmpty) {
      emit(state.copyWith(
        searchQuery: '',
        signals: state.cachedSignals,
        offset: state.cachedOffset,
        hasReachedMax: state.cachedHasReachedMax,
        cachedSignals: const <TradingSignalModel>[],
      ));
    } else {
      emit(state.copyWith(searchQuery: ''));
      unawaited(loadTrades(isRefresh: true));
    }
  }

  void updateDateRange(String? fromDate, String? toDate) {
    emit(state.copyWith(
      fromDate: fromDate,
      toDate: toDate,
      clearDates: fromDate == null && toDate == null,
    ));
    unawaited(loadTrades(isRefresh: true));
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  @override
  TradesState getResetErrorState() => state.copyWith(msg: '');

  @override
  TradesState getResetRedirectionState() => state.copyWith();
}
