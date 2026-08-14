import 'dart:async';
import '../../../utils/exports.dart';
import 'add_trade_state.dart';

class AddTradeCubit extends BaseCubit<AddTradeState> {
  AddTradeCubit({
    required this.repository,
    required AddTradeState initialState,
  }) : super(initialState) {
    unawaited(loadPairs());
    _subscribeLivePrice();
  }

  final TradesRepository repository;
  StreamSubscription<Map<String, dynamic>>? _priceSubscription;
  String? _registeredSymbol;



  void _subscribeLivePrice() {
    unawaited(_priceSubscription?.cancel());
    _priceSubscription = MainConfig.chatSocketConnection.priceStream.listen((Map<String, dynamic> data) {
      if (isClosed) return;
      final String? symbol = data['symbol'] as String?;
      final double? price = double.tryParse(data['price']?.toString() ?? '');
      if (symbol != null && price != null && price > 0) {
        final String pairSym = state.selectedPair?.symbol ?? '';
        if (_isSymbolMatch(symbol, pairSym)) {
          emit(state.copyWith(liveSocketPrice: price));
          if (state.selectedPair != null) {
            final CurrencyPairResponse updated = CurrencyPairResponse(
              id: state.selectedPair!.id,
              symbol: state.selectedPair!.symbol,
              baseCurrency: state.selectedPair!.baseCurrency,
              quoteCurrency: state.selectedPair!.quoteCurrency,
              market: state.selectedPair!.market,
              currentPrice: price,
              pipValue: state.selectedPair!.pipValue,
            );
            emit(state.copyWith(selectedPair: updated));
          }
          if (state.entryController.text.isEmpty || state.isMarketOrder) {
            state.entryController.text = price.toStringAsFixed(getPricePrecision());
          }
        }
      }
    });
  }

  bool _isSymbolMatch(String wsSymbol, String pairSymbol) {
    if (wsSymbol.isEmpty || pairSymbol.isEmpty) return false;
    final String s1 = wsSymbol.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
    final String s2 = pairSymbol.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
    if (s1 == s2) return true;
    if (s1.startsWith(s2) || s2.startsWith(s1)) return true;
    if (s1.contains(s2) || s2.contains(s1)) return true;
    final String baseS1 = s1.replaceAll('USDT', 'USD');
    final String baseS2 = s2.replaceAll('USDT', 'USD');
    return baseS1.startsWith(baseS2) || baseS2.startsWith(baseS1);
  }

  void updateSocketRegistration(String? newSymbol) {
    if (_registeredSymbol != null && _registeredSymbol != newSymbol) {
      unawaited(MainConfig.chatSocketConnection.unregisterSymbol(_registeredSymbol!));
      _registeredSymbol = null;
    }
    if (newSymbol != null && newSymbol.isNotEmpty) {
      _registeredSymbol = newSymbol;
      unawaited(MainConfig.chatSocketConnection.registerSymbol(newSymbol));
    }
  }

  Future<void> loadPairs() async {
    emit(state.copyWith(
      isLoadingPairs: true,
      currencyPairs: <CurrencyPairResponse>[],
      clearSelectedPair: true,
      clearLiveSocketPrice: true,
    ));

    try {
      ResponseHandler<BaseResponse<List<CurrencyPairResponse>>> response =
          await repository.getCurrencyPairs(market: state.selectedMarket);
      if (isClosed) return;
      List<CurrencyPairResponse>? pairs =
          response.getSuccessInstance()?.response.data;

      if (pairs == null || pairs.isEmpty) {
        response = await repository.getCurrencyPairs(
          market: state.selectedMarket.toLowerCase(),
        );
        if (isClosed) return;
        pairs = response.getSuccessInstance()?.response.data;
      }

      if (pairs == null || pairs.isEmpty) {
        response = await repository.getCurrencyPairs(market: '');
        if (isClosed) return;
        pairs = response.getSuccessInstance()?.response.data;
      }

      if (isClosed) return;

      if (pairs != null && pairs.isNotEmpty) {
        emit(state.copyWith(
          currencyPairs: pairs,
          clearSelectedPair: true,
          clearLiveSocketPrice: true,
        ));
        state.entryController.text = '';
        updateSocketRegistration(null);
      } else {
        emit(state.copyWith(
          currencyPairs: const <CurrencyPairResponse>[],
          clearSelectedPair: true,
          clearLiveSocketPrice: true,
        ));
      }
    } on Object catch (e) {
      debugPrint('Failed to load currency pairs in Cubit: $e');
    } finally {
      if (!isClosed) {
        emit(state.copyWith(isLoadingPairs: false));
      }
    }
  }

  void updateMarket(String market) {
    emit(state.copyWith(selectedMarket: market));
    unawaited(loadPairs());
  }

  void updateSelectedPair(CurrencyPairResponse pair) {
    emit(state.copyWith(
      selectedPair: pair,
      clearLiveSocketPrice: true,
    ));
    state.entryController.text = getLivePrice().toStringAsFixed(getPricePrecision());
    updateSocketRegistration(pair.symbol);
  }

  void updateTradeType(String type) {
    emit(state.copyWith(selectedTradeType: type));
    if (state.isMarketOrder) {
      final double price = getLivePrice();
      state.entryController.text = price > 0 ? price.toStringAsFixed(getPricePrecision()) : '';
    }
  }

  void updatePairSearchQuery(String query) {
    emit(state.copyWith(pairSearchQuery: query));
  }

  void toggleSlInPips() {
    emit(state.copyWith(isSlInPips: !state.isSlInPips));
  }

  void toggleTp1InPips() {
    emit(state.copyWith(isTp1InPips: !state.isTp1InPips));
  }

  double getPipSize() {
    if (state.selectedPair != null &&
        state.selectedPair!.pipValue != null &&
        state.selectedPair!.pipValue! > 0) {
      return state.selectedPair!.pipValue!;
    }
    return 0.0001;
  }

  int getPricePrecision() {
    final double pipSize = getPipSize();
    final List<String> parts = pipSize.toString().split('.');
    if (parts.length > 1) {
      return parts[1].length;
    }
    return 4;
  }

  double getLivePrice() {
    if (state.liveSocketPrice != null && state.liveSocketPrice! > 0) {
      return state.liveSocketPrice!;
    }
    if (state.selectedPair != null && state.selectedPair!.currentPrice > 0) {
      return state.selectedPair!.currentPrice;
    }
    return 0;
  }

  double priceToPips(double price, double reference) {
    final double pipSize = getPipSize();
    if (pipSize == 0) return 0.0;
    return double.parse(
      ((price - reference).abs() / pipSize).toStringAsFixed(2),
    );
  }

  double pipsToPrice(double pips, double reference, bool isAbove) {
    final double pipSize = getPipSize();
    final double diff = pips * pipSize;
    final double value = isAbove ? (reference + diff) : (reference - diff);
    return double.parse(value.toStringAsFixed(getPricePrecision()));
  }

  double getCalculatedEntry() {
    final double? val = double.tryParse(state.entryController.text);
    if (val != null && val > 0) return val;
    return getLivePrice();
  }

  double? getEffectiveSL(double entry) {
    if (state.slController.text.trim().isEmpty) return null;
    final double? inputVal = double.tryParse(state.slController.text.trim());
    if (inputVal == null) return null;

    final bool isBuy = state.selectedTradeType.startsWith('BUY');
    if (state.isSlInPips) {
      return pipsToPrice(inputVal, entry, !isBuy);
    } else {
      return inputVal;
    }
  }

  double? getEffectiveTP1(double entry) {
    if (state.tp1Controller.text.trim().isEmpty) return null;
    final double? inputVal = double.tryParse(state.tp1Controller.text.trim());
    if (inputVal == null) return null;

    final bool isBuy = state.selectedTradeType.startsWith('BUY');
    if (state.isTp1InPips) {
      return pipsToPrice(inputVal, entry, isBuy);
    } else {
      return inputVal;
    }
  }

  Map<String, dynamic>? calculateTradeRR() {
    final double entry = getCalculatedEntry();
    final double? sl = getEffectiveSL(entry);
    final double? tp = getEffectiveTP1(entry);

    if (sl == null || tp == null) return null;

    final bool isBuy = state.selectedTradeType.startsWith('BUY');

    if (isBuy) {
      if (sl >= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Stop Loss must be below Entry price',
          'rr': 0.0,
        };
      }
      if (tp <= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Take Profit must be above Entry price',
          'rr': 0.0,
        };
      }
    } else {
      if (sl <= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Stop Loss must be above Entry price',
          'rr': 0.0,
        };
      }
      if (tp >= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Take Profit must be below Entry price',
          'rr': 0.0,
        };
      }
    }

    final double risk = (entry - sl).abs();
    final double reward = (tp - entry).abs();

    if (risk == 0) {
      return <String, dynamic>{
        'valid': false,
        'reason': 'Risk cannot be zero',
        'rr': 0.0,
      };
    }

    final double rr = double.parse((reward / risk).toStringAsFixed(2));
    return <String, dynamic>{'valid': true, 'reason': '', 'rr': rr};
  }

  Future<void> submitTrade() async {
    if (state.selectedPair == null) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Please select a currency pair.',
      ));
      return;
    }
    if (state.liveSocketPrice == null || state.liveSocketPrice! <= 0) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Waiting for live price update. Please wait.',
      ));
      return;
    }

    final Map<String, dynamic>? calculation = calculateTradeRR();
    if (calculation == null || calculation['valid'] == false) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: (calculation?['reason'] as String?) ??
            'Invalid Risk-Reward calculations. Please enter valid SL and TP.',
      ));
      return;
    }

    emit(state.copyWith(isSubmitting: true, status: BaseStateStatus.loading));

    try {
      final double entry = getCalculatedEntry();
      final double sl = getEffectiveSL(entry)!;
      final double tp1 = getEffectiveTP1(entry)!;

      final double slPips = priceToPips(sl, entry);
      final double tp1Pips = priceToPips(tp1, entry);

      final double? tp2Val = double.tryParse(state.tp2Controller.text.trim());
      final double? tp2Pips = (tp2Val != null && tp2Val > 0) ? priceToPips(tp2Val, entry) : null;

      final double? tp3Val = double.tryParse(state.tp3Controller.text.trim());
      final double? tp3Pips = (tp3Val != null && tp3Val > 0) ? priceToPips(tp3Val, entry) : null;

      final bool isRrValid = calculation != null && calculation['valid'] == true;
      final double rrVal = isRrValid ? (calculation['rr'] as double) : 2.0;

      final CreateSignalRequest request = CreateSignalMapper.toRequest(
        market: state.selectedMarket.toUpperCase(),
        marketType: state.selectedTradeType,
        currencyPairId: state.selectedPair?.id,
        note: state.commentController.text.trim(),
        tradingViewUrl: state.tradingViewUrlController.text.trim(),
        rrVal: rrVal,
        entry: entry,
        sl: sl,
        tp1: tp1,
        slPips: slPips,
        tp1Pips: tp1Pips,
        tp2Val: tp2Val,
        tp2Pips: tp2Pips,
        tp3Val: tp3Val,
        tp3Pips: tp3Pips,
      );

      final ResponseHandler<BaseResponse<dynamic>> response =
          await repository.createTrade(request);

      if (response.isSuccess()) {
        emit(state.copyWith(
          status: BaseStateStatus.success,
          msg: 'Trade created successfully!',
        ));
      } else {
        final OnFailureResponse<BaseResponse<dynamic>>? failure =
            response.getFailureInstance();
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: failure?.error?.errorMessage ?? 'Failed to create trade signal.',
        ));
      }
    } on Object catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Exception occurred: $e',
      ));
    } finally {
      emit(state.copyWith(isSubmitting: false));
    }
  }

  @override
  Future<void> close() async {
    await _priceSubscription?.cancel();
    if (_registeredSymbol != null) {
      await MainConfig.chatSocketConnection.unregisterSymbol(_registeredSymbol!);
    }
    await super.close();
  }

  @override
  AddTradeState getResetErrorState() => state.copyWith(msg: '');

  @override
  AddTradeState getResetRedirectionState() => state.copyWith();
}
