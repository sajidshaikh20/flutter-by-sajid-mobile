import '../../../utils/exports.dart';

/// Cubit managing Trades page state including search queries and category/status filtering.
class TradesCubit extends BaseCubit<TradesState> {
  final TradesRepository repository;

  TradesCubit({required this.repository}) : super(TradesState.initial()) {
    unawaited(loadTrades());
  }

  Future<void> loadTrades({bool isRefresh = false}) async {
    //if (state.status == BaseStateStatus.loading) return;

    int currentOffset = isRefresh ? 0 : state.offset;
    if (!isRefresh && state.hasReachedMax) return;

    emit(state.copyWith(status: BaseStateStatus.loading));

    String? statusParam;
    switch (state.selectedFilter) {
      case SignalFilter.all:
        statusParam = null;
      case SignalFilter.active:
        statusParam = 'ACTIVE';
      case SignalFilter.pending:
        statusParam = 'PENDING';
      case SignalFilter.closed:
        statusParam = 'CLOSED';
      case SignalFilter.cancelled:
        statusParam = 'CANCEL';
    }

    const int limit = 10;

    final List<Future<dynamic>> futures = <Future<dynamic>>[
      repository.getTrades(status: statusParam, limit: limit, offset: currentOffset),
      repository.getMyTrades(),
    ];

    final bool needCounts = currentOffset == 0;
    if (needCounts) {
      futures.add(repository.getTrades());
    }

    final List<dynamic> responses = await Future.wait<dynamic>(futures);

    final ResponseHandler<BaseResponse<List<TradeResponse>>> response =
        responses[0] as ResponseHandler<BaseResponse<List<TradeResponse>>>;
    final ResponseHandler<BaseResponse<List<TradeResponse>>> myResponse =
        responses[1] as ResponseHandler<BaseResponse<List<TradeResponse>>>;

    int activeCount = state.activeCount;
    int pendingCount = state.pendingCount;
    int closedCount = state.closedCount;
    int lossesCount = state.lossesCount;

    if (needCounts && responses.length > 2) {
      final ResponseHandler<BaseResponse<List<TradeResponse>>> allTradesResponse =
          responses[2] as ResponseHandler<BaseResponse<List<TradeResponse>>>;
      if (allTradesResponse.isSuccess()) {
        final List<TradeResponse> allApiTrades =
            allTradesResponse.getSuccessInstance()?.response.data ?? <TradeResponse>[];
        activeCount = allApiTrades.where((TradeResponse t) => t.status.toUpperCase() == 'ACTIVE').length;
        pendingCount = allApiTrades.where((TradeResponse t) => t.status.toUpperCase() == 'PENDING').length;
        closedCount = allApiTrades.where((TradeResponse t) => t.status.toUpperCase() == 'CLOSED').length;
        lossesCount = allApiTrades.where((TradeResponse t) => t.status.toUpperCase() == 'CLOSED' && t.outcome?.toUpperCase() == 'LOSS').length;
      }
    }

    if (response.isSuccess()) {
      final BaseResponse<List<TradeResponse>>? baseResponse = response.getSuccessInstance()?.response;
      final List<TradeResponse> apiTrades = baseResponse?.data ?? <TradeResponse>[];
      final int totalCount = baseResponse?.totalCount ?? 0;

      final List<TradeResponse> myTrades = myResponse.isSuccess()
          ? (myResponse.getSuccessInstance()?.response.data ?? <TradeResponse>[])
          : <TradeResponse>[];

      final Set<String> takenIds = myTrades.map((TradeResponse t) => t.publicId).toSet();

      final List<TradingSignalModel> newMappedSignals = apiTrades.map((TradeResponse t) {
        final TradingSignalModel signal = _mapTradeResponseToSignal(t);
        return signal.copyWith(isTaken: takenIds.contains(t.publicId));
      }).toList();

      final List<TradingSignalModel> updatedSignals = isRefresh || currentOffset == 0
          ? newMappedSignals
          : <TradingSignalModel>[...state.signals, ...newMappedSignals];

      emit(state.copyWith(
        signals: updatedSignals,
        status: BaseStateStatus.success,
        offset: currentOffset + apiTrades.length,
        hasReachedMax: updatedSignals.length >= totalCount || apiTrades.length < limit,
        totalCount: totalCount,
        activeCount: activeCount,
        pendingCount: pendingCount,
        closedCount: closedCount,
        lossesCount: lossesCount,
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
      await loadTrades(isRefresh: true);
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
      } else if (lvl.levelType.toUpperCase() == 'TAKE_PROFIT') {
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
    final String status = t.status.toUpperCase() == 'CANCEL' ? 'CANCELLED' : t.status.toUpperCase();

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
      tradingViewUrl: t.tradingViewUrl,
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
    emit(state.copyWith(
      selectedFilter: filter,
      offset: 0,
      hasReachedMax: false,
      signals: const <TradingSignalModel>[],
    ));
    unawaited(loadTrades(isRefresh: true));
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
