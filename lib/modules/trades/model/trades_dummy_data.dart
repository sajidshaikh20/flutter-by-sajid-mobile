class TradingSignalModel {
  final String pair;
  final String category; // CRYPTO, FOREX
  final String type; // BUY MARKET, BUY LIMIT, etc.
  final String status; // ACTIVE, PENDING, CLOSED, CANCELLED
  final double entryPrice;
  final double stopLoss;
  final double takeProfit;
  final double? livePrice;
  final String? livePriceChange; // e.g., "+1.36 (+0.21%)"
  final bool? isLivePriceUp; // true if positive green, false if negative red
  final String pips; // e.g. "+113.11 PIPS"
  final String rr; // e.g. "1:2"
  final double? progress; // 0.0 to 1.0 (relative position of live price between entry and take profit)
  final String? outcome; // WIN, LOSS
  final String timeLabel; // e.g. "Just now", "2h ago"
  final List<double> sparklineData;

  const TradingSignalModel({
    required this.pair,
    required this.category,
    required this.type,
    required this.status,
    required this.entryPrice,
    required this.stopLoss,
    required this.takeProfit,
    this.livePrice,
    this.livePriceChange,
    this.isLivePriceUp,
    required this.pips,
    required this.rr,
    this.progress,
    this.outcome,
    required this.timeLabel,
    required this.sparklineData,
  });

  bool get isBuy => type.contains('BUY');
  bool get isActive => status == 'ACTIVE';
  bool get isPending => status == 'PENDING';
  bool get isClosed => status == 'CLOSED';
  bool get isCancelled => status == 'CANCELLED';
}

abstract final class TradingSignalsMockData {
  static const List<TradingSignalModel> signals = <TradingSignalModel>[
    TradingSignalModel(
      pair: 'BTCUSD',
      category: 'CRYPTO',
      type: 'BUY MARKET',
      status: 'ACTIVE',
      entryPrice: 64191.39,
      stopLoss: 64000,
      takeProfit: 64300,
      livePrice: 64192.36,
      livePriceChange: '+1.36 (+0.21%)',
      isLivePriceUp: true,
      pips: '+113.11 PIPS',
      rr: '1:2',
      progress: 0.65,
      timeLabel: 'Just now',
      sparklineData: <double>[64050, 64100, 64080, 64150, 64130, 64192.36],
    ),
    TradingSignalModel(
      pair: 'EURUSD',
      category: 'FOREX',
      type: 'BUY MARKET',
      status: 'CLOSED',
      entryPrice: 1.16083,
      stopLoss: 1.14000,
      takeProfit: 1.18000,
      pips: '+91.7 PIPS',
      rr: '0.92',
      outcome: 'WIN',
      timeLabel: '2h ago',
      sparklineData: <double>[1.155, 1.158, 1.157, 1.162, 1.165, 1.172],
    ),
    TradingSignalModel(
      pair: 'BTCUSDT',
      category: 'CRYPTO',
      type: 'BUY MARKET',
      status: 'CLOSED',
      entryPrice: 64164,
      stopLoss: 64000,
      takeProfit: 64500,
      pips: '-241.43 PIPS',
      rr: '1:3',
      outcome: 'LOSS',
      timeLabel: '5h ago',
      sparklineData: <double>[64250, 64200, 64300, 64150, 64050, 63922.57],
    ),
    TradingSignalModel(
      pair: 'ETHUSD',
      category: 'CRYPTO',
      type: 'BUY LIMIT',
      status: 'PENDING',
      entryPrice: 3450.00,
      stopLoss: 3350,
      takeProfit: 3650,
      pips: '0.00 PIPS',
      rr: '1:2',
      timeLabel: '10m ago',
      sparklineData: <double>[3470, 3465, 3460, 3458, 3455, 3452],
    ),
    TradingSignalModel(
      pair: 'SOLUSD',
      category: 'CRYPTO',
      type: 'SELL LIMIT',
      status: 'CANCELLED',
      entryPrice: 150.00,
      stopLoss: 155,
      takeProfit: 140,
      pips: '0.00 PIPS',
      rr: '1:2',
      timeLabel: '1d ago',
      sparklineData: <double>[148, 149, 151, 150, 152, 150],
    ),
    TradingSignalModel(
      pair: 'GBPUSD',
      category: 'FOREX',
      type: 'SELL MARKET',
      status: 'ACTIVE',
      entryPrice: 1.27250,
      stopLoss: 1.28000,
      takeProfit: 1.26000,
      livePrice: 1.27180,
      livePriceChange: '+0.0007 (+0.05%)',
      isLivePriceUp: true,
      pips: '+7.00 PIPS',
      rr: '1:1.6',
      progress: 0.40,
      timeLabel: '15m ago',
      sparklineData: <double>[1.274, 1.273, 1.2735, 1.272, 1.2718],
    ),
    TradingSignalModel(
      pair: 'XAUUSD',
      category: 'GOLD',
      type: 'BUY MARKET',
      status: 'ACTIVE',
      entryPrice: 2335.50,
      stopLoss: 2320,
      takeProfit: 2365,
      livePrice: 2332.10,
      livePriceChange: '-3.40 (-0.15%)',
      isLivePriceUp: false,
      pips: '-34.00 PIPS',
      rr: '1:2',
      progress: 0.15,
      timeLabel: '30m ago',
      sparklineData: <double>[2336, 2338, 2334, 2332.1],
    ),
    TradingSignalModel(
      pair: 'USDJPY',
      category: 'FOREX',
      type: 'SELL MARKET',
      status: 'PENDING',
      entryPrice: 156.40,
      stopLoss: 157.00,
      takeProfit: 155.00,
      pips: '0.00 PIPS',
      rr: '1:2.3',
      timeLabel: '1h ago',
      sparklineData: <double>[156.2, 156.3, 156.25, 156.35, 156.4],
    ),
  ];
}
