import '../../../utils/exports.dart';

class MyFollowingCubit extends BaseCubit<MyFollowingState> {
  MyFollowingCubit({required this.repository}) : super(MyFollowingState.initial()) {
    unawaited(fetchWishlist(isRefresh: true));
  }

  final MyFollowingRepository repository;
  int _loadGeneration = 0;
  static const int _pageLimit = 10;

  Future<void> fetchWishlist({bool isRefresh = false}) async {
    if (isRefresh) {
      _loadGeneration++;
    } else if (state.isInitialLoading || state.isLoadingMore || state.hasReachedMax) {
      return;
    }
    await _getTrades(isRefresh: isRefresh || state.signals.isEmpty, isLoadMore: false);
  }

  Future<void> loadWishlistTrades({bool isRefresh = false}) => fetchWishlist(isRefresh: isRefresh);

  Future<void> loadMore() async {
    if (state.isLoadingMore ||
        state.hasReachedMax ||
        state.isInitialLoading ||
        state.status == BaseStateStatus.loading) {
      return;
    }
    await _getTrades(isRefresh: false, isLoadMore: true);
  }

  Future<void> _getTrades({required bool isRefresh, required bool isLoadMore}) async {
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

    final ResponseHandler<BaseResponse<List<TradeResponse>>> response =
        await repository.getWishlistTrades(
      status: _mapFilterToStatus(state.selectedFilter),
      limit: _pageLimit,
      offset: currentOffset,
      fromDate: state.fromDate,
      toDate: state.toDate,
    );

    if (generation != _loadGeneration) return;

    if (response.isSuccess()) {
      final BaseResponse<List<TradeResponse>>? baseResponse =
          response.getSuccessInstance()?.response;
      final List<TradeResponse> apiTrades = baseResponse?.data ?? <TradeResponse>[];
      final int totalCount = baseResponse?.totalCount ?? apiTrades.length;

      final List<TradingSignalModel> newMapped = apiTrades
          .map((TradeResponse t) => t.toTradingSignalModel(isTaken: true))
          .toList();

      final List<TradingSignalModel> updated = isRefresh || currentOffset == 0
          ? newMapped
          : <TradingSignalModel>[...state.signals, ...newMapped];

      emit(state.copyWith(
        signals: updated,
        status: BaseStateStatus.success,
        isLoadingMore: false,
        offset: currentOffset + apiTrades.length,
        hasReachedMax: updated.length >= totalCount || apiTrades.length < _pageLimit,
      ));
    } else {
      final OnFailureResponse<BaseResponse<List<TradeResponse>>>? failure =
          response.getFailureInstance();
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        isLoadingMore: false,
        msg: failure?.error?.errorMessage ?? 'Failed to load wishlist trades.',
      ));
    }
  }

  void selectFilter(MyFollowingFilter filter) {
    if (state.selectedFilter == filter) return;
    emit(state.copyWith(
      selectedFilter: filter,
      offset: 0,
      hasReachedMax: false,
    ));
    unawaited(fetchWishlist(isRefresh: true));
  }

  String? _mapFilterToStatus(MyFollowingFilter filter) {
    switch (filter) {
      case MyFollowingFilter.active:
        return 'ACTIVE';
      case MyFollowingFilter.pending:
        return 'PENDING';
      case MyFollowingFilter.closed:
        return 'CLOSED';
      case MyFollowingFilter.cancelled:
        return 'CANCEL';
      case MyFollowingFilter.all:
        return null;
    }
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void clearSearch() {
    emit(state.copyWith(searchQuery: ''));
  }

  void updateDateRange(String? fromDate, String? toDate) {
    emit(state.copyWith(
      fromDate: fromDate,
      toDate: toDate,
      clearDates: fromDate == null && toDate == null,
    ));
    unawaited(fetchWishlist(isRefresh: true));
  }

  @override
  MyFollowingState getResetErrorState() => state.copyWith(msg: '');

  @override
  MyFollowingState getResetRedirectionState() => state.copyWith();
}
