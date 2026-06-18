import '../../../utils/exports.dart';

/// Cubit managing Trades page state including search queries and category/status filtering.
class TradesCubit extends BaseCubit<TradesState> {
  final TradesRepository repository;

  TradesCubit({required this.repository}) : super(TradesState.initial()) {
    unawaited(loadTrades());
  }

  Future<void> loadTrades() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final ResponseHandler<BaseResponse<List<TradeResponse>>> response = await repository.getTrades();
    if (response.isSuccess()) {
      final BaseResponse<List<TradeResponse>>? baseResponse = response.getSuccessInstance()?.response;
      final List<TradeResponse> apiTrades = baseResponse?.data ?? <TradeResponse>[];
      
      final List<TradingSignalModel> mappedSignals = apiTrades.map(_mapTradeResponseToSignal).toList();

      emit(state.copyWith(
        signals: mappedSignals,
        status: BaseStateStatus.success,
      ));
    } else {
      final OnFailureResponse<BaseResponse<List<TradeResponse>>>? failure = response.getFailureInstance();
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: failure?.error?.errorMessage ?? 'Failed to load trade signals.',
      ));
    }
  }

  Future<void> takeTrade(String tradePublicId) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final ResponseHandler<BaseResponse<dynamic>> response = await repository.takeTrade(tradePublicId);
    if (response.isSuccess()) {
      emit(state.copyWith(
        status: BaseStateStatus.success,
        msg: 'Trade taken successfully!',
      ));
      await loadTrades();
    } else {
      final OnFailureResponse<BaseResponse<dynamic>>? failure = response.getFailureInstance();
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: failure?.error?.errorMessage ?? 'Failed to take trade.',
      ));
    }
  }

  TradingSignalModel _mapTradeResponseToSignal(TradeResponse t) {
    double entryPrice = 0.0;
    double stopLoss = 0.0;
    double takeProfit = 0.0;

    for (final TradeLevelResponse lvl in t.levels) {
      if (lvl.levelType.toUpperCase() == 'ENTRY') {
        entryPrice = double.tryParse(lvl.entryPoint) ?? 0.0;
        stopLoss = double.tryParse(lvl.stopLoss) ?? 0.0;
        takeProfit = double.tryParse(lvl.takeProfit) ?? 0.0;
      }
    }

    if (entryPrice == 0.0 && t.levels.isNotEmpty) {
      entryPrice = double.tryParse(t.levels.first.entryPoint) ?? 0.0;
      stopLoss = double.tryParse(t.levels.first.stopLoss) ?? 0.0;
      takeProfit = double.tryParse(t.levels.first.takeProfit) ?? 0.0;
    }

    final String pair = t.currencyPair?['symbol'] as String? ?? t.currencyPair?['name'] as String? ?? 'EURUSD';
    final String category = t.market.toUpperCase();
    final String type = t.marketType.toUpperCase();
    final String status = t.status.toUpperCase();

    final List<double> sparklineData = <double>[
      entryPrice * 0.998,
      entryPrice * 0.999,
      entryPrice * 1.001,
      entryPrice * 1.002,
      t.livePrice ?? entryPrice,
    ];

    double progress = 0.5;
    if (takeProfit != entryPrice) {
      final double current = t.livePrice ?? entryPrice;
      progress = ((current - entryPrice) / (takeProfit - entryPrice)).clamp(0.0, 1.0);
    }

    final double pipsVal = (t.livePrice != null) ? (t.livePrice! - entryPrice) * 10000 : 0.0;
    final String pipsStr = '${pipsVal >= 0 ? "+" : ""}${pipsVal.toStringAsFixed(2)} PIPS';

    return TradingSignalModel(
      publicId: t.publicId,
      pair: pair,
      category: category,
      type: type,
      status: status,
      entryPrice: entryPrice,
      stopLoss: stopLoss,
      takeProfit: takeProfit,
      livePrice: t.livePrice ?? entryPrice,
      livePriceChange: t.livePrice != null ? '+${((t.livePrice! - entryPrice) / entryPrice * 100).toStringAsFixed(2)}%' : '0.00%',
      isLivePriceUp: (t.livePrice ?? entryPrice) >= entryPrice,
      pips: pipsStr,
      rr: t.riskRewardRatio,
      progress: progress,
      outcome: t.outcome,
      timeLabel: t.createdAt != null ? _formatTimeLabel(t.createdAt!) : 'Just now',
      sparklineData: sparklineData,
    );
  }

  String _formatTimeLabel(String dateStr) {
    try {
      final DateTime dateTime = DateTime.parse(dateStr);
      final Duration diff = DateTime.now().difference(dateTime);
      if (diff.inMinutes < 60) {
        return '${diff.inMinutes}m ago';
      } else if (diff.inHours < 24) {
        return '${diff.inHours}h ago';
      } else {
        return '${diff.inDays}d ago';
      }
    } on Object catch (_) {
      return 'Just now';
    }
  }

  /// Updates the currently selected filter.
  void selectFilter(SignalFilter filter) {
    emit(state.copyWith(selectedFilter: filter));
  }

  /// Updates the search query text.
  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  /// Clears the current search query.
  void clearSearch() {
    emit(state.copyWith(searchQuery: ''));
  }

  @override
  TradesState getResetErrorState() => state.copyWith(msg: '');

  @override
  TradesState getResetRedirectionState() => state.copyWith();
}
