import '../../../utils/exports.dart';

class LeaderboardCubit extends BaseCubit<LeaderboardState> {
  final LeaderboardRepository repository;

  LeaderboardCubit({required this.repository}) : super(LeaderboardState.initial()) {
    unawaited(loadLeaderboard());
  }

  static const int _pageLimit = 10;

  String _mapTimeframeToPeriod(String tf) {
    switch (tf) {
      case 'Weekly':
        return 'WEEKLY';
      case 'Monthly':
        return 'MONTHLY';
      case 'Custom':
        return 'CUSTOM';
      default:
        return 'WEEKLY';
    }
  }

  Future<void> loadLeaderboard({bool isRefresh = false}) async {
    emit(state.copyWith(
      shimmerLoading: !isRefresh,
      status: BaseStateStatus.initial,
      offset: 0,
      hasReachedMax: false,
      isLoadingMore: false,
      totalCount: 0,
    ));

    final ResponseHandler<BaseResponse<List<LeaderboardItemResponse>>> response = await repository.getLeaderboard(
      limit: _pageLimit,
      offset: 0,
      period: _mapTimeframeToPeriod(state.activeTimeframe),
      fromDate: state.fromDate,
      toDate: state.toDate,
    );

    if (response.isSuccess()) {
      final BaseResponse<List<LeaderboardItemResponse>>? baseResponse = response.getSuccessInstance()?.response;
      final List<LeaderboardItemResponse> items = baseResponse?.data ?? <LeaderboardItemResponse>[];
      final int totalCount = baseResponse?.totalCount ?? items.length;

      final List<LeaderboardItemModel> mappedItems = <LeaderboardItemModel>[];
      for (int i = 0; i < items.length; i++) {
        final LeaderboardItemResponse e = items[i];
        mappedItems.add(LeaderboardItemModel(
          rank: e.rank != 0 ? e.rank : i + 1,
          name: e.name,
          winRate: e.winRate,
          status: e.status,
          type: e.type,
          pnl: e.pnl,
          tradesCount: e.tradesCount,
          avatarUrl: e.avatarUrl,
        ));
      }

      emit(state.copyWith(
        leaderboardItems: mappedItems,
        shimmerLoading: false,
        status: BaseStateStatus.success,
        offset: mappedItems.length,
        totalCount: totalCount,
        hasReachedMax: mappedItems.length < _pageLimit || mappedItems.length >= totalCount,
      ));
    } else {
      DebugLog.instance.w('Leaderboard API failed.');
      emit(state.copyWith(
        leaderboardItems: const <LeaderboardItemModel>[],
        shimmerLoading: false,
        status: BaseStateStatus.failure,
        hasReachedMax: true,
      ));
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.hasReachedMax || state.shimmerLoading) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final int currentOffset = state.offset;
    final ResponseHandler<BaseResponse<List<LeaderboardItemResponse>>> response = await repository.getLeaderboard(
      limit: _pageLimit,
      offset: currentOffset,
      period: _mapTimeframeToPeriod(state.activeTimeframe),
      fromDate: state.fromDate,
      toDate: state.toDate,
    );

    if (response.isSuccess()) {
      final BaseResponse<List<LeaderboardItemResponse>>? baseResponse = response.getSuccessInstance()?.response;
      final List<LeaderboardItemResponse> items = baseResponse?.data ?? <LeaderboardItemResponse>[];
      final int totalCount = baseResponse?.totalCount ?? state.totalCount;

      final List<LeaderboardItemModel> mappedItems = <LeaderboardItemModel>[];
      for (int i = 0; i < items.length; i++) {
        final LeaderboardItemResponse e = items[i];
        mappedItems.add(LeaderboardItemModel(
          rank: e.rank != 0 ? e.rank : currentOffset + i + 1,
          name: e.name,
          winRate: e.winRate,
          status: e.status,
          type: e.type,
          pnl: e.pnl,
          tradesCount: e.tradesCount,
          avatarUrl: e.avatarUrl,
        ));
      }

      final List<LeaderboardItemModel> updatedItems = List<LeaderboardItemModel>.from(state.leaderboardItems)
        ..addAll(mappedItems);

      emit(state.copyWith(
        leaderboardItems: updatedItems,
        isLoadingMore: false,
        status: BaseStateStatus.success,
        offset: currentOffset + mappedItems.length,
        totalCount: totalCount,
        hasReachedMax: mappedItems.length < _pageLimit || updatedItems.length >= totalCount,
      ));
    } else {
      DebugLog.instance.e('Leaderboard loadMore API failed.');
      emit(state.copyWith(
        isLoadingMore: false,
        status: BaseStateStatus.failure,
      ));
    }
  }

  /// Simulated pull-to-refresh action
  Future<void> refreshLeaderboard() async {
    await loadLeaderboard(isRefresh: true);
  }

  /// Updates the text search query
  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  /// Updates custom date range
  void updateDateRange(String? fromDate, String? toDate) {
    emit(state.copyWith(
      fromDate: fromDate,
      toDate: toDate,
      clearDates: fromDate == null && toDate == null,
    ));
    unawaited(loadLeaderboard(isRefresh: true));
  }

  /// Switches between Traders and Clients
  void updateTypeTab(String type) {
    emit(state.copyWith(activeType: type));
  }

  /// Updates the selected timeframe (Daily, Weekly, Monthly, All Time)
  void updateTimeframe(String timeframe) {
    emit(state.copyWith(
      activeTimeframe: timeframe,
      clearDates: timeframe != 'Custom',
    ));
    if (timeframe != 'Custom') {
      unawaited(loadLeaderboard(isRefresh: true));
    }
  }

  /// Updates sorting category (Win Rate, Trades, PnL)
  void updateSortBy(String sortBy) {
    emit(state.copyWith(sortBy: sortBy));
  }

  @override
  LeaderboardState getResetErrorState() => state.copyWith(msg: '');

  @override
  LeaderboardState getResetRedirectionState() => state.copyWith();
}
