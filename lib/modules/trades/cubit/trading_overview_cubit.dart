import '../../../utils/exports.dart';

/// Cubit managing Trading Overview page live updates and state calculations.
class TradingOverviewCubit extends BaseCubit<TradingOverviewState> {
  TradingOverviewCubit({
    required this.signal,
    required this.repository,
  }) : super(TradingOverviewState.initial(signal)) {
    unawaited(_initCubit());
  }

  final TradingSignalModel signal;
  final TradesRepository repository;

  StreamSubscription<Map<String, dynamic>>? _priceSubscription;
  StreamSubscription<Map<String, dynamic>>? _tradeSubscription;

  Future<void> _initCubit() async {
    await loadTradeDetails();
    _subscribeToSocketUpdates();
  }

  Future<void> loadTradeDetails() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final ResponseHandler<BaseResponse<TradeResponse>> response =
        await repository.getTradeDetails(signal.publicId);

    if (response.isSuccess()) {
      final BaseResponse<TradeResponse>? baseResponse = response.getSuccessInstance()?.response;
      final TradeResponse? data = baseResponse?.data;
      if (data != null) {
        final TradingSignalModel updatedSignal = data.toTradingSignalModel(
          isTaken: state.isTaken,
        );
        emit(state.copyWith(
          status: BaseStateStatus.success,
          signal: updatedSignal,
          livePrice: updatedSignal.livePrice ?? updatedSignal.entryPrice,
        ));
        _updatePriceAndProgress(updatedSignal.livePrice ?? updatedSignal.entryPrice);
      } else {
        emit(state.copyWith(status: BaseStateStatus.success));
      }
    } else {
      final OnFailureResponse<BaseResponse<TradeResponse>>? failure =
          response.getFailureInstance();
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: failure?.error?.errorMessage ?? 'Failed to load trade details.',
      ));
    }
  }

  Future<void> takeTrade(String tradePublicId) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final ResponseHandler<BaseResponse<dynamic>> response = await repository.takeTrade(tradePublicId);
    if (response.isSuccess()) {
      emit(state.copyWith(
        status: BaseStateStatus.success,
        isTaken: true,
        signal: state.signal.copyWith(isTaken: true),
        msg: 'Trade taken successfully!',
      ));
    } else {
      final OnFailureResponse<BaseResponse<dynamic>>? failure = response.getFailureInstance();
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: failure?.error?.errorMessage ?? 'Failed to take trade.',
      ));
    }
  }

  void _subscribeToSocketUpdates() {
    // Register the symbol to receive price updates only if trade is ACTIVE or PENDING
    final String initialStatus = state.signal.status.toUpperCase();
    final bool isLive = initialStatus == 'ACTIVE' || initialStatus == 'PENDING';
    if (isLive) {
      unawaited(MainConfig.chatSocketConnection.registerSymbol(signal.pair));
    }

    // Listen for live price updates
    _priceSubscription = MainConfig.chatSocketConnection.priceStream.listen((Map<String, dynamic> data) {
      final String? tradePublicId = data['tradePublicId'] as String?;
      final String? tradeStatus = data['tradeStatus'] as String?;
      
      // If this price update contains status for our trade, we update the status
      if (tradePublicId != null && tradePublicId == signal.publicId && tradeStatus != null) {
        final String normalizedStatus = tradeStatus.toUpperCase();
        final String currentStatus = state.signal.status.toUpperCase();
        if (normalizedStatus != currentStatus) {
          final String finalStatus = (normalizedStatus == 'CANCEL' || normalizedStatus == 'CANCELLED')
              ? 'CANCELLED'
              : normalizedStatus;

          final TradingSignalModel updatedSignal = state.signal.copyWith(
            status: finalStatus,
            outcome: data['outcome'] as String? ?? state.signal.outcome,
          );

          emit(state.copyWith(
            signal: updatedSignal,
          ));

          // If the trade is no longer active or pending, unregister the symbol immediately
          if (finalStatus != 'ACTIVE' && finalStatus != 'PENDING') {
            unawaited(MainConfig.chatSocketConnection.unregisterSymbol(signal.pair));
          }
        }
      }

      final String currentStatus = state.signal.status.toUpperCase();
      if (currentStatus != 'ACTIVE' && currentStatus != 'PENDING') return;
      final String? symbol = data['symbol'] as String?;
      if (symbol != null) {
        final String s1 = symbol.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
        final String s2 = signal.pair.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
        if (s1 == s2 || s1.startsWith(s2) || s2.startsWith(s1) || s1.contains(s2) || s2.contains(s1)) {
          final double? price = double.tryParse(data['price']?.toString() ?? '');
          if (price != null) {
            _updatePriceAndProgress(price);
          }
        }
      }
    });

    // Listen for trade status updates
    _tradeSubscription = MainConfig.chatSocketConnection.tradeStream.listen((Map<String, dynamic> data) {
      final String? tradePublicId = data['tradePublicId'] as String?;
      if (tradePublicId != null && tradePublicId == signal.publicId) {
        final String? status = data['status'] as String?;
        final String? outcome = data['outcome'] as String?;
        final double? exitPrice = double.tryParse(data['exitPrice']?.toString() ?? '');
        
        // Update the signal state
        final TradingSignalModel updatedSignal = state.signal.copyWith(
          status: status ?? state.signal.status,
          outcome: outcome ?? state.signal.outcome,
          livePrice: exitPrice ?? state.livePrice,
        );

        emit(state.copyWith(
          signal: updatedSignal,
        ));

        _updatePriceAndProgress(exitPrice ?? state.livePrice);

        // If the trade is no longer active or pending, unregister the symbol immediately
        final String finalStatus = (status ?? state.signal.status).toUpperCase();
        if (finalStatus != 'ACTIVE' && finalStatus != 'PENDING') {
          unawaited(MainConfig.chatSocketConnection.unregisterSymbol(signal.pair));
        }
      }
    });
  }

  void _updatePriceAndProgress(double newPrice) {
    // Calculate progress mapping
    // SL = 0.0, Entry = 0.5, TP = 1.0
    double progress = 0.5;
    final double sl = state.signal.stopLoss;
    final double entry = state.signal.entryPrice;
    final double tp = state.signal.takeProfit;

    if (newPrice == entry) {
      progress = 0.5;
    } else if (tp > entry) {
      // Buy Signal: tp > entry > sl
      if (newPrice >= tp) {
        progress = 1.0;
      } else if (newPrice <= sl) {
        progress = 0.0;
      } else if (newPrice > entry) {
        progress = 0.5 + 0.5 * ((newPrice - entry) / (tp - entry));
      } else {
        progress = 0.5 * ((newPrice - sl) / (entry - sl));
      }
    } else {
      // Sell Signal: sl > entry > tp
      if (newPrice <= tp) {
        progress = 1.0;
      } else if (newPrice >= sl) {
        progress = 0.0;
      } else if (newPrice < entry) {
        progress = 0.5 + 0.5 * ((entry - newPrice) / (entry - tp));
      } else {
        progress = 0.5 * ((sl - newPrice) / (sl - entry));
      }
    }

    // Double check clamp bounds to prevent rendering overflow
    progress = progress.clamp(0.0, 1.0);

    emit(state.copyWith(
      livePrice: newPrice,
      progress: progress,
    ));
  }

  @override
  Future<void> close() {
    unawaited(_priceSubscription?.cancel());
    unawaited(_tradeSubscription?.cancel());
    unawaited(MainConfig.chatSocketConnection.unregisterSymbol(signal.pair));
    return super.close();
  }

  @override
  TradingOverviewState getResetErrorState() => state.copyWith(msg: '');

  @override
  TradingOverviewState getResetRedirectionState() => state.copyWith();
}
