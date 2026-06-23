import '../../../utils/exports.dart';

class LeaderboardState extends BaseState {
  const LeaderboardState({
    this.searchQuery = '',
    this.activeType = 'Traders', // 'Traders' or 'Clients'
    this.activeTimeframe = 'Weekly', // 'Daily', 'Weekly', 'Monthly', 'All Time'
    this.sortBy = 'Win Rate', // 'Win Rate', 'Trades', 'PnL'
    this.leaderboardItems = const <LeaderboardItemModel>[],
    this.shimmerLoading = false,
    this.offset = 0,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.totalCount = 0,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final String searchQuery;
  final String activeType;
  final String activeTimeframe;
  final String sortBy;
  final List<LeaderboardItemModel> leaderboardItems;
  final bool shimmerLoading;
  final int offset;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int totalCount;

  bool get showLoadMoreIndicator => isLoadingMore && !hasReachedMax && !shimmerLoading;

  factory LeaderboardState.initial() => const LeaderboardState();

  List<LeaderboardItemModel> get filteredItems {
    // 1. Filter by activeType ('Traders' -> 'TRADER', 'Clients' -> 'CLIENT')
    final String requiredType = activeType == 'Traders' ? 'TRADER' : 'CLIENT';
    List<LeaderboardItemModel> items = leaderboardItems.where((LeaderboardItemModel item) => item.type == requiredType).toList();

    // 2. Filter by searchQuery (matches name or username case-insensitive)
    if (searchQuery.isNotEmpty) {
      final String query = searchQuery.toLowerCase();
      items = items.where((LeaderboardItemModel item) => item.name.toLowerCase().contains(query)).toList();
    }

    // 3. Sort by criteria
    if (sortBy == 'Win Rate') {
      items.sort((LeaderboardItemModel a, LeaderboardItemModel b) => b.winRate.compareTo(a.winRate));
    } else if (sortBy == 'Trades') {
      items.sort((LeaderboardItemModel a, LeaderboardItemModel b) => b.tradesCount.compareTo(a.tradesCount));
    } else if (sortBy == 'PnL') {
      items.sort((LeaderboardItemModel a, LeaderboardItemModel b) => b.pnl.compareTo(a.pnl));
    }

    return items;
  }

  LeaderboardState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    String? searchQuery,
    String? activeType,
    String? activeTimeframe,
    String? sortBy,
    List<LeaderboardItemModel>? leaderboardItems,
    bool? shimmerLoading,
    int? offset,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? totalCount,
  }) =>
      LeaderboardState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        searchQuery: searchQuery ?? this.searchQuery,
        activeType: activeType ?? this.activeType,
        activeTimeframe: activeTimeframe ?? this.activeTimeframe,
        sortBy: sortBy ?? this.sortBy,
        leaderboardItems: leaderboardItems ?? this.leaderboardItems,
        shimmerLoading: shimmerLoading ?? this.shimmerLoading,
        offset: offset ?? this.offset,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        totalCount: totalCount ?? this.totalCount,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        searchQuery,
        activeType,
        activeTimeframe,
        sortBy,
        leaderboardItems,
        shimmerLoading,
        offset,
        hasReachedMax,
        isLoadingMore,
        totalCount,
      ];
}
