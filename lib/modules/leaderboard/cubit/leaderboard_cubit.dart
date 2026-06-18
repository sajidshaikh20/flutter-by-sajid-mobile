import '../../../utils/exports.dart';

class LeaderboardCubit extends BaseCubit<LeaderboardState> {
  final LeaderboardRepository repository;

  LeaderboardCubit({required this.repository}) : super(LeaderboardState.initial()) {
    unawaited(loadLeaderboard());
  }

  Future<void> loadLeaderboard() async {
    emit(state.copyWith(shimmerLoading: true));
    final ResponseHandler<BaseResponse<List<LeaderboardItemResponse>>> response = await repository.getLeaderboard();
    if (response.isSuccess()) {
      final BaseResponse<List<LeaderboardItemResponse>>? baseResponse = response.getSuccessInstance()?.response;
      final List<LeaderboardItemResponse> items = baseResponse?.data ?? <LeaderboardItemResponse>[];

      if (items.isNotEmpty) {
        // Sort items by winRate descending to make sure they are in order
        final List<LeaderboardItemResponse> sortedItems = List<LeaderboardItemResponse>.from(items)
          ..sort((LeaderboardItemResponse a, LeaderboardItemResponse b) => b.winRate.compareTo(a.winRate));

        final List<LeaderboardItemModel> mappedItems = <LeaderboardItemModel>[];
        for (int i = 0; i < sortedItems.length; i++) {
          final LeaderboardItemResponse e = sortedItems[i];
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
          isMockData: false,
        ));
      } else {
        _loadMockData();
      }
    } else {
      DebugLog.instance.w('Leaderboard API failed, falling back to mock data.');
      _loadMockData();
    }
  }

  void _loadMockData() {
    emit(state.copyWith(
      leaderboardItems: _getMockData(state.activeTimeframe),
      shimmerLoading: false,
      status: BaseStateStatus.success,
      isMockData: true,
    ));
  }

  /// Simulated pull-to-refresh action
  Future<void> refreshLeaderboard() async {
    await loadLeaderboard();
  }

  /// Updates the text search query
  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  /// Switches between Traders and Clients
  void updateTypeTab(String type) {
    emit(state.copyWith(activeType: type));
  }

  /// Updates the selected timeframe (Daily, Weekly, Monthly, All Time)
  /// and updates values slightly to simulate dynamic data.
  void updateTimeframe(String timeframe) {
    emit(state.copyWith(
      activeTimeframe: timeframe,
      leaderboardItems: state.isMockData ? _getMockData(timeframe) : state.leaderboardItems,
    ));
  }

  /// Updates sorting category (Win Rate, Trades, PnL)
  void updateSortBy(String sortBy) {
    emit(state.copyWith(sortBy: sortBy));
  }

  /// Generates clean mock records for demonstration
  List<LeaderboardItemModel> _getMockData(String timeframe) {
    final double scale = switch (timeframe) {
      'Daily' => 0.2,
      'Weekly' => 0.5,
      'Monthly' => 0.8,
      'All Time' || _ => 1.0,
    };

    return <LeaderboardItemModel>[
      LeaderboardItemModel(
        rank: 1,
        name: 'Olivia Carter',
        winRate: 100.0,
        status: 'INACTIVE',
        type: 'TRADER',
        pnl: 15420.0 * scale,
        tradesCount: (85 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 2,
        name: 'Ryan Mitchell',
        winRate: 100.0,
        status: 'INACTIVE',
        type: 'TRADER',
        pnl: 12150.0 * scale,
        tradesCount: (62 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 3,
        name: 'Thomas Wilson',
        winRate: 100.0,
        status: 'INACTIVE',
        type: 'TRADER',
        pnl: 9480.0 * scale,
        tradesCount: (50 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 4,
        name: 'DIVYANSH RAJA',
        winRate: 83.33,
        status: 'INACTIVE',
        type: 'TRADER',
        pnl: 5200.0 * scale,
        tradesCount: (24 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 5,
        name: 'Demo User',
        winRate: 70.0,
        status: 'INACTIVE',
        type: 'TRADER',
        pnl: 3100.0 * scale,
        tradesCount: (10 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 6,
        name: 'Sajid Shaikh',
        winRate: 91.50,
        status: 'ACTIVE',
        type: 'TRADER',
        pnl: 24500.0 * scale,
        tradesCount: (112 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 7,
        name: 'Aarav Mehta',
        winRate: 64.20,
        status: 'ACTIVE',
        type: 'TRADER',
        pnl: 1800.0 * scale,
        tradesCount: (42 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 8,
        name: 'Sophia Williams',
        winRate: 59.00,
        status: 'ACTIVE',
        type: 'TRADER',
        pnl: 1200.0 * scale,
        tradesCount: (35 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 1,
        name: 'Liam Neeson',
        winRate: 95.80,
        status: 'ACTIVE',
        type: 'CLIENT',
        pnl: 18500.0 * scale,
        tradesCount: (95 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 2,
        name: 'Emma Watson',
        winRate: 92.40,
        status: 'INACTIVE',
        type: 'CLIENT',
        pnl: 14200.0 * scale,
        tradesCount: (70 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 3,
        name: 'Noah Miller',
        winRate: 88.00,
        status: 'ACTIVE',
        type: 'CLIENT',
        pnl: 10100.0 * scale,
        tradesCount: (58 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 4,
        name: 'Sophia Loren',
        winRate: 76.50,
        status: 'ACTIVE',
        type: 'CLIENT',
        pnl: 6500.0 * scale,
        tradesCount: (38 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 5,
        name: 'Zayn Malik',
        winRate: 68.90,
        status: 'INACTIVE',
        type: 'CLIENT',
        pnl: 4800.0 * scale,
        tradesCount: (22 * scale).round(),
      ),
      LeaderboardItemModel(
        rank: 6,
        name: 'Chris Pratt',
        winRate: 62.00,
        status: 'ACTIVE',
        type: 'CLIENT',
        pnl: 2500.0 * scale,
        tradesCount: (18 * scale).round(),
      ),
    ];
  }

  @override
  LeaderboardState getResetErrorState() => state.copyWith(msg: '');

  @override
  LeaderboardState getResetRedirectionState() => state.copyWith();
}
