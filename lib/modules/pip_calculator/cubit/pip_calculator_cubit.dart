import '../../../utils/exports.dart';

/// Cubit managing Pip and Position Size Calculator page state and calculation logic.
class PipCalculatorCubit extends BaseCubit<PipCalculatorState> {
  PipCalculatorCubit() : super(PipCalculatorState.initial());

  static const List<Map<String, dynamic>> currencyPairs = <Map<String, dynamic>>[
    <String, dynamic>{'name': 'EUR/USD', 'value': 10.0},
    <String, dynamic>{'name': 'GBP/USD', 'value': 10.0},
    <String, dynamic>{'name': 'USD/CHF', 'value': 10.0},
    <String, dynamic>{'name': 'AUD/USD', 'value': 10.0},
    <String, dynamic>{'name': 'NZD/USD', 'value': 10.0},
    <String, dynamic>{'name': 'USD/CAD', 'value': 10.0},
    <String, dynamic>{'name': 'USD/JPY', 'value': 100.0},
    <String, dynamic>{'name': 'EUR/JPY', 'value': 100.0},
    <String, dynamic>{'name': 'GBP/JPY', 'value': 100.0},
    <String, dynamic>{'name': 'AUD/JPY', 'value': 100.0},
    <String, dynamic>{'name': 'NZD/JPY', 'value': 100.0},
    <String, dynamic>{'name': 'CAD/JPY', 'value': 100.0},
    <String, dynamic>{'name': 'CHF/JPY', 'value': 100.0},
    <String, dynamic>{'name': 'EUR/GBP', 'value': 100.0},
    <String, dynamic>{'name': 'EUR/AUD', 'value': 100.0},
    <String, dynamic>{'name': 'GBP/AUD', 'value': 100.0},
    <String, dynamic>{'name': 'GBP/CAD', 'value': 100.0},
    <String, dynamic>{'name': 'USD/ZAR', 'value': 100.0},
    <String, dynamic>{'name': 'USD/SGD', 'value': 100.0},
    <String, dynamic>{'name': 'USD/HKD', 'value': 100.0},
    <String, dynamic>{'name': 'EUR/NZD', 'value': 100.0},
    <String, dynamic>{'name': 'USD/MXN', 'value': 100.0},
    <String, dynamic>{'name': 'USD/INR', 'value': 100.0},
    <String, dynamic>{'name': 'USD/CNH', 'value': 100.0},
    <String, dynamic>{'name': 'BTC/USD', 'value': 1.0},
    <String, dynamic>{'name': 'ETH/USD', 'value': 10.0},
    <String, dynamic>{'name': 'USOIL', 'value': 100.0},
  ];

  /// Switches between calculator tabs and resets results.
  void updateActiveTab(String tab) {
    emit(state.copyWith(
      activeTab: tab,
      clearPositionSize: true,
      clearPipValue: true,
    ));
  }

  /// Sets selected currency pair and recalculates/resets results.
  void selectCurrencyPair(String name, double value) {
    emit(state.copyWith(
      selectedCurrencyName: name,
      selectedCurrencyValue: value,
      clearPositionSize: true,
      clearPipValue: true,
    ));
  }

  /// Updates account balance.
  void updateBalance(double? val) {
    emit(state.copyWith(
      balance: val,
      clearPositionSize: true,
    ));
  }

  /// Updates risk percentage.
  void updateRiskPercentage(double? val) {
    emit(state.copyWith(
      riskPercentage: val,
      clearPositionSize: true,
    ));
  }

  /// Updates stop loss.
  void updateStopLoss(double? val) {
    emit(state.copyWith(
      stopLoss: val,
      clearPositionSize: true,
    ));
  }

  /// Updates lot size.
  void updateLotSize(double? val) {
    emit(state.copyWith(
      lotSize: val,
      clearPipValue: true,
    ));
  }

  /// Calculates position size in lots:
  /// positionSize = riskAmount / (stopLoss * currencyValue)
  void calculatePositionSize() {
    final double? balance = state.balance;
    final double? riskPercentage = state.riskPercentage;
    final double? stopLoss = state.stopLoss;
    final double currencyValue = state.selectedCurrencyValue;

    if (balance == null || riskPercentage == null || stopLoss == null || stopLoss == 0) {
      emit(state.copyWith(clearPositionSize: true));
      return;
    }

    final double riskAmount = balance * (riskPercentage / 100.0);
    final double positionSizeResult = riskAmount / (stopLoss * currencyValue);
    emit(state.copyWith(positionSize: positionSizeResult));
  }

  /// Calculates pip value:
  /// pipValue = lotSize * currencyValue
  void calculatePipValue() {
    final double? lotSize = state.lotSize;
    final double currencyValue = state.selectedCurrencyValue;

    if (lotSize == null) {
      emit(state.copyWith(clearPipValue: true));
      return;
    }

    final double pipValueResult = lotSize * currencyValue;
    emit(state.copyWith(pipValue: pipValueResult));
  }

  @override
  PipCalculatorState getResetErrorState() => state.copyWith(msg: '');

  @override
  PipCalculatorState getResetRedirectionState() => state.copyWith();
}

