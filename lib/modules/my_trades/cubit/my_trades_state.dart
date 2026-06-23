import '../../../utils/exports.dart';

/// State class for My Trades tab managing filter, search, signals list and standard BaseState properties.
class MyTradesState extends BaseState {
  const MyTradesState({
    this.selectedFilters = const <SignalFilter>{SignalFilter.all},
    this.searchQuery = '',
    this.signals = const <TradingSignalModel>[],
    this.offset = 0,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.totalCount = 0,
    this.activeCount = 0,
    this.pendingCount = 0,
    this.closedCount = 0,
    this.lossesCount = 0,
    this.cachedSignals = const <TradingSignalModel>[],
    this.cachedOffset = 0,
    this.cachedHasReachedMax = false,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final Set<SignalFilter> selectedFilters;
  final String searchQuery;
  final List<TradingSignalModel> signals;
  final int offset;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int totalCount;
  final int activeCount;
  final int pendingCount;
  final int closedCount;
  final int lossesCount;

  // Cached standard state properties to restore instantly when clearSearch is clicked
  final List<TradingSignalModel> cachedSignals;
  final int cachedOffset;
  final bool cachedHasReachedMax;

  factory MyTradesState.initial() => const MyTradesState();

  bool get isInitialLoading =>
      status == BaseStateStatus.loading && signals.isEmpty && !isLoadingMore;

  bool get showLoadMoreIndicator => isLoadingMore && signals.isNotEmpty;

  bool get showEmptyState =>
      !isInitialLoading && filteredSignals.isEmpty && status != BaseStateStatus.loading;

  /// Trades visible for the current status filter and search query.
  List<TradingSignalModel> get filteredSignals => signals.where((TradingSignalModel signal) {
        if (!_matchesStatusFilter(signal)) return false;
        return true;
      }).toList();

  bool _matchesStatusFilter(TradingSignalModel signal) {
    if (selectedFilters.contains(SignalFilter.all)) return true;
    for (final SignalFilter filter in selectedFilters) {
      if (filter == SignalFilter.active && signal.isActive) return true;
      if (filter == SignalFilter.pending && signal.isPending) return true;
      if (filter == SignalFilter.closed && signal.isClosed) return true;
      if (filter == SignalFilter.cancelled && signal.isCancelled) return true;
    }
    return false;
  }

  MyTradesState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    Set<SignalFilter>? selectedFilters,
    String? searchQuery,
    List<TradingSignalModel>? signals,
    int? offset,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? totalCount,
    int? activeCount,
    int? pendingCount,
    int? closedCount,
    int? lossesCount,
    List<TradingSignalModel>? cachedSignals,
    int? cachedOffset,
    bool? cachedHasReachedMax,
  }) =>
      MyTradesState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        selectedFilters: selectedFilters ?? this.selectedFilters,
        searchQuery: searchQuery ?? this.searchQuery,
        signals: signals ?? this.signals,
        offset: offset ?? this.offset,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        totalCount: totalCount ?? this.totalCount,
        activeCount: activeCount ?? this.activeCount,
        pendingCount: pendingCount ?? this.pendingCount,
        closedCount: closedCount ?? this.closedCount,
        lossesCount: lossesCount ?? this.lossesCount,
        cachedSignals: cachedSignals ?? this.cachedSignals,
        cachedOffset: cachedOffset ?? this.cachedOffset,
        cachedHasReachedMax: cachedHasReachedMax ?? this.cachedHasReachedMax,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        selectedFilters,
        searchQuery,
        signals,
        offset,
        hasReachedMax,
        isLoadingMore,
        totalCount,
        activeCount,
        pendingCount,
        closedCount,
        lossesCount,
        cachedSignals,
        cachedOffset,
        cachedHasReachedMax,
      ];
}
