import '../../../utils/exports.dart';

/// State class for PIP Calculator screen.
class PipCalculatorState extends BaseState {
  const PipCalculatorState({
    this.selectedCurrencyPair = 'EUR/USD',
    this.selectedAccountCurrency = 'USD',
    this.lotSize = 1.0,
    this.currentPrice = 1.08500,
    this.selectedPipSize = 0.0001,
    this.pipValue = 10.0,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final String selectedCurrencyPair;
  final String selectedAccountCurrency;
  final double lotSize;
  final double currentPrice;
  final double selectedPipSize;
  final double pipValue;

  factory PipCalculatorState.initial() => const PipCalculatorState();

  PipCalculatorState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    String? selectedCurrencyPair,
    String? selectedAccountCurrency,
    double? lotSize,
    double? currentPrice,
    double? selectedPipSize,
    double? pipValue,
  }) =>
      PipCalculatorState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        selectedCurrencyPair: selectedCurrencyPair ?? this.selectedCurrencyPair,
        selectedAccountCurrency: selectedAccountCurrency ?? this.selectedAccountCurrency,
        lotSize: lotSize ?? this.lotSize,
        currentPrice: currentPrice ?? this.currentPrice,
        selectedPipSize: selectedPipSize ?? this.selectedPipSize,
        pipValue: pipValue ?? this.pipValue,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        selectedCurrencyPair,
        selectedAccountCurrency,
        lotSize,
        currentPrice,
        selectedPipSize,
        pipValue,
      ];
}
