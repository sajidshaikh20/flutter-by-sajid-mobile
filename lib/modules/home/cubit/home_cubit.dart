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
    if (UserProfileService.instance().firstTimeLogin ?? false) {
      unawaited(Future<void>.microtask(() {
        emit(state.copyWith(firstTimeLogin: true));
      }));
    }
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
      ResponseHandler<BaseResponse<HomeDashboardResponse>>? dashboardResponse;
      ResponseHandler<BaseResponse<List<TradeResponse>>>? closedResponse;
      ResponseHandler<BaseResponse<List<TradeResponse>>>? activeResponse;
      ResponseHandler<BaseResponse<ClientProfileResponse>>? profileResponse;

      try {
        dashboardResponse = await repository.getClientDashboard();
      } on Object catch (e) {
        debugPrint('Home statistics failed: $e');
      }

      try {
        closedResponse = await tradesRepository.getTradesByPlan(status: 'CLOSED', limit: 5);
      } on Object catch (e) {
        debugPrint('Closed trades failed: $e');
      }

      try {
        activeResponse = await tradesRepository.getTradesByPlan(status: 'ACTIVE', limit: 5);
      } on Object catch (e) {
        debugPrint('Active trades failed: $e');
      }

      try {
        profileResponse = await ProfileRepositoryImpl().getProfile();
      } on Object catch (e) {
        debugPrint('Profile load failed: $e');
      }

      HomeDashboardResponse? dashboardData;
      List<TradingSignalModel> recentTrades = <TradingSignalModel>[];
      List<TradingSignalModel> liveTrades = <TradingSignalModel>[];

      if (dashboardResponse != null && dashboardResponse.isSuccess()) {
        dashboardData = dashboardResponse.getSuccessInstance()?.response.data;
      }

      if (closedResponse != null && closedResponse.isSuccess()) {
        final List<TradeResponse>? trades = closedResponse.getSuccessInstance()?.response.data;
        if (trades != null) {
          recentTrades = trades.map((TradeResponse t) => t.toTradingSignalModel()).toList();
        }
      }

      if (activeResponse != null && activeResponse.isSuccess()) {
        final List<TradeResponse>? trades = activeResponse.getSuccessInstance()?.response.data;
        if (trades != null) {
          liveTrades = trades.map((TradeResponse t) => t.toTradingSignalModel()).toList();
        }
      }

      final ClientProfileResponse? profileData =
          (profileResponse != null && profileResponse.isSuccess())
              ? profileResponse.getSuccessInstance()?.response.data
              : null;

      if (profileData != null) {
        await UserProfileService.instance().updateUserProfile(
          customerName: profileData.name,
          customerEmail: profileData.email,
          phoneNumber: profileData.phone,
          customerId: profileData.publicId,
          username: profileData.username,
          profilePictureUrl: profileData.profilePictureUrl,
          amountBalance: profileData.amountBalance,
          riskPercentage: profileData.riskPercentage,
          firstTimeLogin: profileData.firstTimeLogin,
        );
      }

      emit(state.copyWith(
        status: BaseStateStatus.success,
        totalTrades: dashboardData?.totalTrades ?? 0,
        winningTrades: dashboardData?.winningTrades ?? 0,
        winRate: dashboardData?.winRate ?? 0,
        profitability: dashboardData?.profitability ?? 0.0,
        recentTrades: recentTrades,
        liveTrades: liveTrades,
        firstTimeLogin: profileData?.firstTimeLogin ?? UserProfileService.instance().firstTimeLogin,
      ));
    } on Object catch (_) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An unexpected error occurred. Please try again.',
        firstTimeLogin: UserProfileService.instance().firstTimeLogin,
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

  void dismissFirstTimeLoginPrompt() {
    unawaited(UserProfileService.instance().updateUserProfile(firstTimeLogin: false));
    emit(state.copyWith(firstTimeLogin: false));
  }
}
