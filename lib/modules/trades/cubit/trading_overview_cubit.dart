import '../../../utils/exports.dart';

/// Cubit managing Trading Overview page live updates and state calculations.
class TradingOverviewCubit extends BaseCubit<TradingOverviewState> {
  TradingOverviewCubit({
    required this.signal,
    required this.repository,
  }) : super(TradingOverviewState.initial(signal.livePrice ?? signal.entryPrice)) {
    _startSimulation();
  }

  final TradingSignalModel signal;
  final TradesRepository repository;
  Timer? _timer;

  Future<void> takeTrade(String tradePublicId) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final ResponseHandler<BaseResponse<dynamic>> response = await repository.takeTrade(tradePublicId);
    if (response.isSuccess()) {
      emit(state.copyWith(
        status: BaseStateStatus.success,
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
  final Random _random = Random();

  void _startSimulation() {
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (Timer timer) {
      _simulateUpdate();
    });
  }

  void _simulateUpdate() {
    final double currentPrice = state.livePrice;
    // Fluctuate price slightly by up to 0.03%
    final double changePercent = (_random.nextDouble() - 0.5) * 0.0006;
    final double newPrice = currentPrice * (1 + changePercent);

    // Calculate progress mapping
    // SL = 0.0, Entry = 0.5, TP = 1.0
    double progress = 0.5;
    final double sl = signal.stopLoss;
    final double entry = signal.entryPrice;
    final double tp = signal.takeProfit;

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
    _timer?.cancel();
    return super.close();
  }

  @override
  TradingOverviewState getResetErrorState() => state.copyWith(msg: '');

  @override
  TradingOverviewState getResetRedirectionState() => state.copyWith();
}
