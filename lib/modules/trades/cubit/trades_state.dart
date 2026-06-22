import '../../../utils/exports.dart';

enum SignalFilter { all, active, pending, closed, cancelled }

/// State class for Trades tab managing filter, search, signals list and standard BaseState properties.
class TradesState extends BaseState {
  const TradesState({
    this.selectedFilter = SignalFilter.all,
    this.searchQuery = '',
    this.signals = const <TradingSignalModel>[],
    this.offset = 0,
    this.hasReachedMax = false,
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
  final int totalCount;
  final int activeCount;
  final int pendingCount;
  final int closedCount;
  final int lossesCount;

  factory TradesState.initial() => const TradesState();

  TradesState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    SignalFilter? selectedFilter,
    String? searchQuery,
    List<TradingSignalModel>? signals,
    int? offset,
    bool? hasReachedMax,
    int? totalCount,
    int? activeCount,
    int? pendingCount,
    int? closedCount,
    int? lossesCount,
  }) =>
      TradesState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        selectedFilter: selectedFilter ?? this.selectedFilter,
        searchQuery: searchQuery ?? this.searchQuery,
        signals: signals ?? this.signals,
        offset: offset ?? this.offset,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
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
        totalCount,
        activeCount,
        pendingCount,
        closedCount,
        lossesCount,
      ];
}
