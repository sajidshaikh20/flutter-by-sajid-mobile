class RecentTradeModel {
  final String pair;
  final String type; // BUY_MARKET, SELL_MARKET
  final String status; // CLOSED, etc.
  final double pnl;

  const RecentTradeModel({
    required this.pair,
    required this.type,
    required this.status,
    required this.pnl,
  });

  bool get isPositivePnL => pnl >= 0;
  bool get isBuy => type.contains('BUY');
}

class MarketInsightModel {
  final String pair;
  final String subtext;
  final String assetType; // GOLD, CRYPTO, etc.

  const MarketInsightModel({
    required this.pair,
    required this.subtext,
    required this.assetType,
  });
}

class MarketOverviewModel {
  final String pair;
  final double changePercent;
  final List<double> sparklineData;

  const MarketOverviewModel({
    required this.pair,
    required this.changePercent,
    required this.sparklineData,
  });

  bool get isPositive => changePercent >= 0;
  String get changePercentText => '${isPositive ? '+' : ''}${changePercent.toStringAsFixed(2)}%';
}

class LiveTradeModel {
  final String pair;
  final String type; // BUY_MARKET, SELL_MARKET
  final String category; // CRYPTO, FOREX, etc.
  final String status; // ACTIVE
  final double livePrice;
  final double entry;
  final double sl;
  final double tp;

  const LiveTradeModel({
    required this.pair,
    required this.type,
    required this.category,
    required this.status,
    required this.livePrice,
    required this.entry,
    required this.sl,
    required this.tp,
  });

  bool get isBuy => type.contains('BUY');
}

abstract final class TradesMockData {
  static const List<RecentTradeModel> recentTrades = <RecentTradeModel>[
    RecentTradeModel(pair: 'BTCUSDT', type: 'BUY_MARKET', status: 'CLOSED', pnl: -241.43),
    RecentTradeModel(pair: 'EURUSD', type: 'SELL_MARKET', status: 'CLOSED', pnl: -0.0004),
    RecentTradeModel(pair: 'EURUSD', type: 'SELL_MARKET', status: 'CLOSED', pnl: 0.00014),
    RecentTradeModel(pair: 'EURUSD', type: 'SELL_MARKET', status: 'CLOSED', pnl: -0.00021),
    RecentTradeModel(pair: 'BTCUSDT', type: 'SELL_MARKET', status: 'CLOSED', pnl: -139.00),
  ];

  static const List<MarketInsightModel> marketInsights = <MarketInsightModel>[
    MarketInsightModel(
      pair: 'XAUUSD',
      subtext: 'Gold near resistance zone',
      assetType: 'GOLD',
    ),
    MarketInsightModel(
      pair: 'BTCUSDT',
      subtext: 'High volatility expected',
      assetType: 'CRYPTO',
    ),
  ];

  static const List<MarketOverviewModel> marketOverview = <MarketOverviewModel>[
    MarketOverviewModel(
      pair: 'BTCUSDT',
      changePercent: 2.45,
      sparklineData: <double>[62500, 62800, 62600, 63400, 63200, 64192.36],
    ),
    MarketOverviewModel(
      pair: 'XAUUSD',
      changePercent: -0.82,
      sparklineData: <double>[2350, 2345, 2360, 2330, 2335, 2320],
    ),
    MarketOverviewModel(
      pair: 'EURUSD',
      changePercent: 0.31,
      sparklineData: <double>[1.082, 1.083, 1.081, 1.085, 1.084, 1.087],
    ),
  ];

  static const List<LiveTradeModel> liveTrades = <LiveTradeModel>[
    LiveTradeModel(
      pair: 'BTCUSDT',
      type: 'BUY_MARKET',
      category: 'CRYPTO',
      status: 'ACTIVE',
      livePrice: 64192.36,
      entry: 64191.39,
      sl: 64000,
      tp: 64300,
    ),
  ];
}
