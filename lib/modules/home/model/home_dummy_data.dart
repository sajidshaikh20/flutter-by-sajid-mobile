class HomeRecentTradeModel {
  final String pair;
  final String type; // BUY_MARKET, SELL_MARKET
  final String status; // CLOSED
  final double pnl;

  const HomeRecentTradeModel({
    required this.pair,
    required this.type,
    required this.status,
    required this.pnl,
  });

  bool get isPositivePnL => pnl >= 0;
  bool get isBuy => type.contains('BUY');
}

class HomeMarketInsightModel {
  final String pair;
  final String subtext;
  final String assetType; // GOLD, CRYPTO

  const HomeMarketInsightModel({
    required this.pair,
    required this.subtext,
    required this.assetType,
  });
}

class HomeMarketOverviewModel {
  final String pair;
  final double changePercent;
  final List<double> sparklineData;

  const HomeMarketOverviewModel({
    required this.pair,
    required this.changePercent,
    required this.sparklineData,
  });

  bool get isPositive => changePercent >= 0;
  String get changePercentText => '${isPositive ? '+' : ''}${changePercent.toStringAsFixed(2)}%';
}

class HomeLiveTradeModel {
  final String pair;
  final String type; // BUY_MARKET, SELL_MARKET
  final String category; // CRYPTO, FOREX
  final String status; // ACTIVE
  final double livePrice;
  final double entry;
  final double sl;
  final double tp;

  const HomeLiveTradeModel({
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

class HomeStatCardModel {
  final String title;
  final String value;
  final bool isPositive;

  const HomeStatCardModel({
    required this.title,
    required this.value,
    required this.isPositive,
  });
}

abstract final class HomeMockData {
  static const List<HomeStatCardModel> statCards = <HomeStatCardModel>[
    HomeStatCardModel(title: 'Total Trades', value: '15', isPositive: true),
    HomeStatCardModel(title: 'Active Trades', value: '0', isPositive: true),
    HomeStatCardModel(title: 'Total PnL', value: '₹511', isPositive: true),
    HomeStatCardModel(title: 'Win Rate', value: '40%', isPositive: true),
  ];

  static const List<HomeRecentTradeModel> recentTrades = <HomeRecentTradeModel>[
    HomeRecentTradeModel(pair: 'BTCUSDT', type: 'BUY_MARKET', status: 'CLOSED', pnl: -241.43),
    HomeRecentTradeModel(pair: 'EURUSD', type: 'SELL_MARKET', status: 'CLOSED', pnl: -0.0004),
    HomeRecentTradeModel(pair: 'EURUSD', type: 'SELL_MARKET', status: 'CLOSED', pnl: 0.00014),
    HomeRecentTradeModel(pair: 'EURUSD', type: 'SELL_MARKET', status: 'CLOSED', pnl: -0.00021),
    HomeRecentTradeModel(pair: 'BTCUSDT', type: 'SELL_MARKET', status: 'CLOSED', pnl: -139.00),
  ];

  static const List<HomeMarketInsightModel> marketInsights = <HomeMarketInsightModel>[
    HomeMarketInsightModel(
      pair: 'XAUUSD',
      subtext: 'Gold near resistance zone',
      assetType: 'GOLD',
    ),
    HomeMarketInsightModel(
      pair: 'BTCUSDT',
      subtext: 'High volatility expected',
      assetType: 'CRYPTO',
    ),
  ];

  static const List<HomeMarketOverviewModel> marketOverview = <HomeMarketOverviewModel>[
    HomeMarketOverviewModel(
      pair: 'BTCUSDT',
      changePercent: 2.45,
      sparklineData: <double>[62500, 62800, 62600, 63400, 63200, 64192.36],
    ),
    HomeMarketOverviewModel(
      pair: 'XAUUSD',
      changePercent: -0.82,
      sparklineData: <double>[2350, 2345, 2360, 2330, 2335, 2320],
    ),
    HomeMarketOverviewModel(
      pair: 'EURUSD',
      changePercent: 0.31,
      sparklineData: <double>[1.082, 1.083, 1.081, 1.085, 1.084, 1.087],
    ),
  ];

  static const List<HomeLiveTradeModel> liveTrades = <HomeLiveTradeModel>[
    HomeLiveTradeModel(
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
