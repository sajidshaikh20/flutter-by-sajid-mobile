import '../../../utils/exports.dart';

/// State class for PIP / Position Size Calculator screen.
class PipCalculatorState extends BaseState {
  const PipCalculatorState({
    this.activeTab = 'position',
    this.selectedCurrencyName = 'EUR/USD',
    this.selectedCurrencyValue = 10.0,
    this.balance,
    this.riskPercentage,
    this.stopLoss,
    this.positionSize,
    this.lotSize = 0.01,
    this.pipValue,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final String activeTab;
  final String selectedCurrencyName;
  final double selectedCurrencyValue;
  final double? balance;
  final double? riskPercentage;
  final double? stopLoss;
  final double? positionSize;
  final double? lotSize;
  final double? pipValue;

  factory PipCalculatorState.initial() => const PipCalculatorState();

  PipCalculatorState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    String? activeTab,
    String? selectedCurrencyName,
    double? selectedCurrencyValue,
    double? balance,
    double? riskPercentage,
    double? stopLoss,
    double? positionSize,
    double? lotSize,
    double? pipValue,
    bool clearPositionSize = false,
    bool clearPipValue = false,
  }) =>
      PipCalculatorState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        activeTab: activeTab ?? this.activeTab,
        selectedCurrencyName: selectedCurrencyName ?? this.selectedCurrencyName,
        selectedCurrencyValue: selectedCurrencyValue ?? this.selectedCurrencyValue,
        balance: balance ?? this.balance,
        riskPercentage: riskPercentage ?? this.riskPercentage,
        stopLoss: stopLoss ?? this.stopLoss,
        positionSize: clearPositionSize ? null : (positionSize ?? this.positionSize),
        lotSize: lotSize ?? this.lotSize,
        pipValue: clearPipValue ? null : (pipValue ?? this.pipValue),
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        activeTab,
        selectedCurrencyName,
        selectedCurrencyValue,
        balance,
        riskPercentage,
        stopLoss,
        positionSize,
        lotSize,
        pipValue,
      ];
}

