import '../../../utils/exports.dart';

class ResultCubit extends BaseCubit<ResultState> {
  ResultCubit() : super(ResultState.initial()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    emit(state.copyWith(
      resultItems: _getMockResults(),
      status: BaseStateStatus.success,
    ));
  }

  /// Simulated pull-to-refresh
  Future<void> refreshResults() async {
    emit(state.copyWith(shimmerLoading: true));
    await Future<void>.delayed(const Duration(milliseconds: 800));
    emit(state.copyWith(
      shimmerLoading: false,
      resultItems: _getMockResults(),
    ));
  }

  List<TradeResultModel> _getMockResults() {
    return const <TradeResultModel>[
      TradeResultModel(
        id: 'res_1',
        pair: 'EUR/USD',
        imageUrl: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?auto=format&fit=crop&w=600&q=80',
        amount: '+\$450.00',
        timestamp: '15 Jun 2026, 10:30 AM',
        isProfit: true,
        pips: 45,
        description: 'Double bottom breakout on the 1-hour chart. Entry triggered after solid candle close confirmation above resistance.',
      ),
      TradeResultModel(
        id: 'res_2',
        pair: 'BTC/USDT',
        imageUrl: 'https://images.unsplash.com/photo-1590283603385-17ffb3a7f29f?auto=format&fit=crop&w=600&q=80',
        amount: '+\$1,250.00',
        timestamp: '14 Jun 2026, 09:15 PM',
        isProfit: true,
        pips: 120,
        description: 'Bullish pennant breakout on 15-minute timeframe. Strong volume supported the move, pushing price straight to TP2.',
      ),
      TradeResultModel(
        id: 'res_3',
        pair: 'GBP/JPY',
        imageUrl: 'https://images.unsplash.com/photo-1642390091310-20edf2f24eab?auto=format&fit=crop&w=600&q=80',
        amount: '-\$180.00',
        timestamp: '13 Jun 2026, 02:45 PM',
        isProfit: false,
        pips: 25,
        description: 'Fakeout above resistance. Price retraced rapidly triggering stop loss before resuming the original upward trend.',
      ),
      TradeResultModel(
        id: 'res_4',
        pair: 'Gold (XAU/USD)',
        imageUrl: 'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?auto=format&fit=crop&w=600&q=80',
        amount: '+\$890.00',
        timestamp: '12 Jun 2026, 04:10 PM',
        isProfit: true,
        pips: 80,
        description: 'Short position taken at the double top pattern near historical supply zone. Retest confirmed sell momentum.',
      ),
      TradeResultModel(
        id: 'res_5',
        pair: 'AUD/USD',
        imageUrl: 'https://images.unsplash.com/photo-1618044733300-9472054094ee?auto=format&fit=crop&w=600&q=80',
        amount: '+\$240.00',
        timestamp: '11 Jun 2026, 11:20 AM',
        isProfit: true,
        pips: 30,
        description: 'Rebound from 200 EMA dynamic support on Daily chart. Bullish engulfing candlestick pattern confirmed entry.',
      ),
      TradeResultModel(
        id: 'res_6',
        pair: 'USDCAD',
        imageUrl: 'https://images.unsplash.com/photo-1591696205602-2f950c417cb9?auto=format&fit=crop&w=600&q=80',
        amount: '-\$110.00',
        timestamp: '10 Jun 2026, 08:30 AM',
        isProfit: false,
        pips: 15,
        description: 'Attempted counter-trend scalp trade. Market volatility spiked during news release, hitting tight stop loss.',
      ),
    ];
  }

  @override
  ResultState getResetErrorState() => state.copyWith(msg: '');

  @override
  ResultState getResetRedirectionState() => state.copyWith();
}
