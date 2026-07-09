import '../../../utils/exports.dart';

/// Home state for client dashboard home screen.
class HomeState extends BaseState {
  const HomeState({
    this.isBalanceVisible = true,
    this.isPostpaidVisible = false,
    this.selectedServiceTab = ServiceCategoryTab.bankingServices,
    this.totalTrades = 0,
    this.winningTrades = 0,
    this.winRate = 0.0,
    this.profitability = 0.0,
    this.recentTrades = const <TradingSignalModel>[],
    this.liveTrades = const <TradingSignalModel>[],
    this.firstTimeLogin,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  factory HomeState.initial() => const HomeState();

  /// Whether the available balance is visible (default: true).
  final bool isBalanceVisible;

  /// Whether the Postpaid wallet balance is visible (default: false).
  final bool isPostpaidVisible;

  /// Currently selected All Services tab.
  final ServiceCategoryTab selectedServiceTab;

  final int totalTrades;
  final int winningTrades;
  final double winRate;
  final double profitability;
  final List<TradingSignalModel> recentTrades;
  final List<TradingSignalModel> liveTrades;
  final bool? firstTimeLogin;

  HomeState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    bool? isBalanceVisible,
    bool? isPostpaidVisible,
    ServiceCategoryTab? selectedServiceTab,
    int? totalTrades,
    int? winningTrades,
    double? winRate,
    double? profitability,
    List<TradingSignalModel>? recentTrades,
    List<TradingSignalModel>? liveTrades,
    bool? firstTimeLogin,
  }) =>
      HomeState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
        isPostpaidVisible: isPostpaidVisible ?? this.isPostpaidVisible,
        selectedServiceTab: selectedServiceTab ?? this.selectedServiceTab,
        totalTrades: totalTrades ?? this.totalTrades,
        winningTrades: winningTrades ?? this.winningTrades,
        winRate: winRate ?? this.winRate,
        profitability: profitability ?? this.profitability,
        recentTrades: recentTrades ?? this.recentTrades,
        liveTrades: liveTrades ?? this.liveTrades,
        firstTimeLogin: firstTimeLogin ?? this.firstTimeLogin,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        isBalanceVisible,
        isPostpaidVisible,
        selectedServiceTab,
        totalTrades,
        winningTrades,
        winRate,
        profitability,
        recentTrades,
        liveTrades,
        firstTimeLogin,
      ];
}
