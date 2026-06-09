import '../../../utils/exports.dart';

/// Cubit managing Pip Calculator page state and calculation logic.
class PipCalculatorCubit extends BaseCubit<PipCalculatorState> {
  PipCalculatorCubit() : super(PipCalculatorState.initial()) {
    calculate();
  }

  /// Updates selected currency pair and auto-sets default current price and pip size.
  void updateCurrencyPair(String pair) {
    double defaultPrice = 1.08500;
    double defaultPipSize = 0.0001;

    switch (pair) {
      case 'EUR/USD':
        defaultPrice = 1.08500;
        defaultPipSize = 0.0001;
      case 'GBP/USD':
        defaultPrice = 1.27200;
        defaultPipSize = 0.0001;
      case 'USD/JPY':
        defaultPrice = 156.50;
        defaultPipSize = 0.01;
      case 'AUD/USD':
        defaultPrice = 0.66500;
        defaultPipSize = 0.0001;
      case 'USD/CAD':
        defaultPrice = 1.36500;
        defaultPipSize = 0.0001;
      case 'USD/CHF':
        defaultPrice = 0.89500;
        defaultPipSize = 0.0001;
      case 'NZD/USD':
        defaultPrice = 0.61200;
        defaultPipSize = 0.0001;
      case 'EUR/GBP':
        defaultPrice = 0.85200;
        defaultPipSize = 0.0001;
    }

    emit(state.copyWith(
      selectedCurrencyPair: pair,
      currentPrice: defaultPrice,
      selectedPipSize: defaultPipSize,
    ));
    calculate();
  }

  /// Updates selected account currency.
  void updateAccountCurrency(String currency) {
    emit(state.copyWith(selectedAccountCurrency: currency));
    calculate();
  }

  /// Updates lot size.
  void updateLotSize(double size) {
    emit(state.copyWith(lotSize: size));
    calculate();
  }

  /// Updates current price.
  void updateCurrentPrice(double price) {
    emit(state.copyWith(currentPrice: price));
    calculate();
  }

  /// Updates pip size.
  void updatePipSize(double pipSize) {
    emit(state.copyWith(selectedPipSize: pipSize));
    calculate();
  }

  /// Calculates pip value based on inputs.
  void calculate() {
    final String pair = state.selectedCurrencyPair;
    final List<String> parts = pair.split('/');
    if (parts.length != 2) return;

    final String base = parts[0];
    final String quote = parts[1];
    final String acc = state.selectedAccountCurrency;
    final double lotSize = state.lotSize;
    final double currentPrice = state.currentPrice;
    final double pipSize = state.selectedPipSize;

    // Lot size in units (standard forex lot is 100,000 units)
    final double units = lotSize * 100000;

    // Pip value in Quote Currency (YYY)
    final double pipValQuote = pipSize * units;

    // Convert to Account Currency (ACC)
    double conversionRate = 1.0;
    if (quote == acc) {
      conversionRate = 1.0;
    } else if (base == acc) {
      conversionRate = 1.0 / (currentPrice > 0 ? currentPrice : 1.0);
    } else {
      conversionRate = _getRateToUsd(quote) / _getRateToUsd(acc);
    }

    final double pipValAcc = pipValQuote * conversionRate;

    emit(state.copyWith(pipValue: pipValAcc));
  }

  double _getRateToUsd(String currency) {
    switch (currency) {
      case 'USD':
        return 1.0;
      case 'EUR':
        return 1.0850;
      case 'GBP':
        return 1.2720;
      case 'JPY':
        return 1.0 / 156.50;
      case 'AUD':
        return 0.6650;
      case 'CAD':
        return 1.0 / 1.3650;
      case 'CHF':
        return 1.0 / 0.8950;
      case 'NZD':
        return 0.6120;
      default:
        return 1.0;
    }
  }

  @override
  PipCalculatorState getResetErrorState() => state.copyWith(msg: '');

  @override
  PipCalculatorState getResetRedirectionState() => state.copyWith();
}
