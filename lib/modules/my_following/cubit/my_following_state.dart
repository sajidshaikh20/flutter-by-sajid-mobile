import '../../../utils/exports.dart';

enum MyFollowingFilter { all, active, pending, closed, cancelled }

class MyFollowingState extends BaseState {
  const MyFollowingState({
    this.selectedFilter = MyFollowingFilter.all,
    this.searchQuery = '',
    this.signals = const <TradingSignalModel>[],
    this.offset = 0,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.fromDate,
    this.toDate,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final MyFollowingFilter selectedFilter;
  final String searchQuery;
  final List<TradingSignalModel> signals;
  final int offset;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? fromDate;
  final String? toDate;

  factory MyFollowingState.initial() => const MyFollowingState();

  bool get isInitialLoading =>
      status == BaseStateStatus.loading && signals.isEmpty && !isLoadingMore;

  bool get showLoadMoreIndicator => isLoadingMore && signals.isNotEmpty;

  bool get showEmptyState =>
      !isInitialLoading && filteredSignals.isEmpty && status != BaseStateStatus.loading;

  /// Signals filtered by tab selection and search query.
  List<TradingSignalModel> get filteredSignals {
    final String q = searchQuery.trim().toLowerCase();
    return signals.where((TradingSignalModel signal) {
      if (q.isNotEmpty) {
        final bool matchesPair = signal.pair.toLowerCase().contains(q);
        if (!matchesPair) return false;
      }
      if (selectedFilter == MyFollowingFilter.all) return true;
      if (selectedFilter == MyFollowingFilter.active && signal.isActive) return true;
      if (selectedFilter == MyFollowingFilter.pending && signal.isPending) return true;
      if (selectedFilter == MyFollowingFilter.closed && signal.isClosed) return true;
      if (selectedFilter == MyFollowingFilter.cancelled && signal.isCancelled) return true;
      return false;
    }).toList();
  }

  MyFollowingState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo<dynamic>? redirectRoute,
    MyFollowingFilter? selectedFilter,
    String? searchQuery,
    List<TradingSignalModel>? signals,
    int? offset,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? fromDate,
    String? toDate,
    bool clearDates = false,
  }) {
    return MyFollowingState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      signals: signals ?? this.signals,
      offset: offset ?? this.offset,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      fromDate: clearDates ? null : (fromDate ?? this.fromDate),
      toDate: clearDates ? null : (toDate ?? this.toDate),
      status: status ?? this.status,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute ?? this.redirectRoute,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        selectedFilter,
        searchQuery,
        signals,
        offset,
        hasReachedMax,
        isLoadingMore,
        fromDate,
        toDate,
      ];
}
