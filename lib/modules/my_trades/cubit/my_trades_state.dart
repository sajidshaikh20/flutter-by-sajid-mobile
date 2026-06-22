import '../../../utils/exports.dart';

/// State class for My Trades tab managing filter, search, signals list and standard BaseState properties.
class MyTradesState extends BaseState {
  const MyTradesState({
    this.selectedFilter = SignalFilter.all,
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
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final SignalFilter selectedFilter;
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

  factory MyTradesState.initial() => const MyTradesState();

  bool get isInitialLoading =>
      status == BaseStateStatus.loading && signals.isEmpty && !isLoadingMore;

  MyTradesState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    SignalFilter? selectedFilter,
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
  }) =>
      MyTradesState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        selectedFilter: selectedFilter ?? this.selectedFilter,
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
      );

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
        totalCount,
        activeCount,
        pendingCount,
        closedCount,
        lossesCount,
      ];
}
