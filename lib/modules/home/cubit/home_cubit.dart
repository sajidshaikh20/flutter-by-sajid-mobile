import '../../../utils/exports.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit({
    required this.repository,
    required this.tradesRepository,
  }) : super(HomeState.initial());

  final HomeRepository repository;
  final TradesRepository tradesRepository;

  void initData() {
    unawaited(fetchDashboardData());
  }

  void initializeSegmentIndex() {}

  void refreshHomeData() {
    unawaited(fetchDashboardData(showLoading: false));
  }

  Future<void> fetchDashboardData({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(status: BaseStateStatus.loading));
    }

    try {
      final List<dynamic> results = await Future.wait<dynamic>(<Future<dynamic>>[
        repository.getClientDashboard(),
        tradesRepository.getTradesByPlan(status: 'CLOSED', limit: 5),
        tradesRepository.getTradesByPlan(status: 'ACTIVE', limit: 5),
      ]);

      final ResponseHandler<BaseResponse<HomeDashboardResponse>> dashboardResponse =
          results[0] as ResponseHandler<BaseResponse<HomeDashboardResponse>>;
      final ResponseHandler<BaseResponse<List<TradeResponse>>> closedResponse =
          results[1] as ResponseHandler<BaseResponse<List<TradeResponse>>>;
      final ResponseHandler<BaseResponse<List<TradeResponse>>> activeResponse =
          results[2] as ResponseHandler<BaseResponse<List<TradeResponse>>>;

      HomeDashboardResponse? dashboardData;
      List<TradingSignalModel> recentTrades = <TradingSignalModel>[];
      List<TradingSignalModel> liveTrades = <TradingSignalModel>[];

      if (dashboardResponse.isSuccess()) {
        dashboardData = dashboardResponse.getSuccessInstance()?.response.data;
      }

      if (closedResponse.isSuccess()) {
        final List<TradeResponse>? trades = closedResponse.getSuccessInstance()?.response.data;
        if (trades != null) {
          recentTrades = trades.map((TradeResponse t) => t.toTradingSignalModel()).toList();
        }
      }

      if (activeResponse.isSuccess()) {
        final List<TradeResponse>? trades = activeResponse.getSuccessInstance()?.response.data;
        if (trades != null) {
          liveTrades = trades.map((TradeResponse t) => t.toTradingSignalModel()).toList();
        }
      }

      if (dashboardData != null) {
        emit(state.copyWith(
          status: BaseStateStatus.success,
          totalTrades: dashboardData.totalTrades,
          winningTrades: dashboardData.winningTrades,
          winRate: dashboardData.winRate,
          profitability: dashboardData.profitability,
          recentTrades: recentTrades,
          liveTrades: liveTrades,
        ));
      } else {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: 'Failed to load dashboard statistics.',
        ));
      }
    } on Object catch (_) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An unexpected error occurred. Please try again.',
      ));
    }
  }

  /// Selects the given All Services tab.
  void selectServiceTab(ServiceCategoryTab tab) {
    emit(state.copyWith(selectedServiceTab: tab));
  }

  /// Toggles the visibility of the available balance.
  void toggleBalanceVisibility() {
    emit(state.copyWith(isBalanceVisible: !state.isBalanceVisible));
  }

  /// Toggles the visibility of the Postpaid wallet balance.
  void togglePostpaidVisibility() {
    emit(state.copyWith(isPostpaidVisible: !state.isPostpaidVisible));
  }

  @override
  HomeState getResetErrorState() => state.copyWith(msg: '');

  @override
  HomeState getResetRedirectionState() => state.copyWith();
}
