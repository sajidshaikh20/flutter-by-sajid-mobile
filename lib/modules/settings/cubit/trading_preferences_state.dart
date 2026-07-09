import '../../../utils/exports.dart';

class TradingPreferencesState extends BaseState {
  const TradingPreferencesState({
    this.amountBalance = 1000.0,
    this.riskPercentage = 1.0,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  factory TradingPreferencesState.initial() => const TradingPreferencesState();

  final double amountBalance;
  final double riskPercentage;

  TradingPreferencesState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    double? amountBalance,
    double? riskPercentage,
  }) =>
      TradingPreferencesState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        amountBalance: amountBalance ?? this.amountBalance,
        riskPercentage: riskPercentage ?? this.riskPercentage,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        amountBalance,
        riskPercentage,
      ];
}
