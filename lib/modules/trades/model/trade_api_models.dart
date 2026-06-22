import 'trades_dummy_data.dart';

class TradeLevelResponse {
  final String levelType;
  final String entryPoint;
  final String stopLoss;
  final String takeProfit;
  final int level;

  TradeLevelResponse({
    required this.levelType,
    required this.entryPoint,
    required this.stopLoss,
    required this.takeProfit,
    required this.level,
  });

  factory TradeLevelResponse.fromJson(Map<String, dynamic> json) {
    return TradeLevelResponse(
      levelType: json['levelType'] ?? '',
      entryPoint: json['entryPoint']?.toString() ?? '',
      stopLoss: json['stopLoss']?.toString() ?? '',
      takeProfit: json['takeProfit']?.toString() ?? '',
      level: json['level'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'levelType': levelType,
      'entryPoint': entryPoint,
      'stopLoss': stopLoss,
      'takeProfit': takeProfit,
      'level': level,
    };
  }
}

class TradeResponse {
  final String publicId;
  final String market;
  final String marketType;
  final String status;
  final String riskRewardRatio;
  final String note;
  final String tradingViewUrl;
  final List<TradeLevelResponse> levels;
  final double? exitPrice;
  final double? livePrice;
  final String? createdAt;
  final String? outcome;
  final Map<String, dynamic>? currencyPair;

  TradeResponse({
    required this.publicId,
    required this.market,
    required this.marketType,
    required this.status,
    required this.riskRewardRatio,
    required this.note,
    required this.tradingViewUrl,
    required this.levels,
    this.exitPrice,
    this.livePrice,
    this.createdAt,
    this.outcome,
    this.currencyPair,
  });

  factory TradeResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> levelsList = json['levels'] as List<dynamic>? ?? <dynamic>[];
    return TradeResponse(
      publicId: json['tradePublicId'] ?? json['publicId'] ?? '',
      market: json['market'] ?? '',
      marketType: json['marketType'] ?? '',
      status: json['status'] ?? 'ACTIVE',
      riskRewardRatio: json['riskRewardRatio'] ?? '1:2',
      note: json['note'] ?? '',
      tradingViewUrl: json['tradingViewUrl'] ?? '',
      levels: levelsList.map((dynamic l) => TradeLevelResponse.fromJson(l as Map<String, dynamic>)).toList(),
      exitPrice: json['exitPrice'] != null ? double.tryParse(json['exitPrice'].toString()) : null,
      livePrice: json['livePrice'] != null ? double.tryParse(json['livePrice'].toString()) : null,
      createdAt: json['createdAt']?.toString(),
      outcome: json['outcome']?.toString(),
      currencyPair: json['currencyPair'] is Map<String, dynamic>
          ? json['currencyPair'] as Map<String, dynamic>
          : (json['currencyPairSymbol'] != null
              ? <String, dynamic>{'symbol': json['currencyPairSymbol']}
              : null),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'publicId': publicId,
      'market': market,
      'marketType': marketType,
      'status': status,
      'riskRewardRatio': riskRewardRatio,
      'note': note,
      'tradingViewUrl': tradingViewUrl,
      'levels': levels.map((TradeLevelResponse l) => l.toJson()).toList(),
      'exitPrice': exitPrice,
      'livePrice': livePrice,
      'createdAt': createdAt,
      'outcome': outcome,
      'currencyPair': currencyPair,
    };
  }

  /// Maps API trade response to UI [TradingSignalModel].
  TradingSignalModel toTradingSignalModel({bool isTaken = false}) {
    double entryPrice = 0.0;
    double stopLoss = 0.0;
    double takeProfit = 0.0;

    for (final TradeLevelResponse lvl in levels) {
      if (lvl.levelType.toUpperCase() == 'ENTRY') {
        entryPrice = double.tryParse(lvl.entryPoint) ?? 0.0;
        stopLoss = double.tryParse(lvl.stopLoss) ?? 0.0;
      } else if (lvl.levelType.toUpperCase() == 'TAKE_PROFIT') {
        takeProfit = double.tryParse(lvl.takeProfit) ?? 0.0;
      }
    }

    if (entryPrice == 0.0 && levels.isNotEmpty) {
      entryPrice = double.tryParse(levels.first.entryPoint) ?? 0.0;
      stopLoss = double.tryParse(levels.first.stopLoss) ?? 0.0;
      takeProfit = double.tryParse(levels.first.takeProfit) ?? 0.0;
    }

    final String pair =
        currencyPair?['symbol'] as String? ?? currencyPair?['name'] as String? ?? 'EURUSD';
    final String normalizedStatus =
        status.toUpperCase() == 'CANCEL' ? 'CANCELLED' : status.toUpperCase();

    final List<double> sparklineData = <double>[
      entryPrice * 0.998,
      entryPrice * 0.999,
      entryPrice * 1.001,
      entryPrice * 1.002,
      livePrice ?? entryPrice,
    ];

    double progress = 0.5;
    if (takeProfit != entryPrice) {
      final double current = livePrice ?? entryPrice;
      progress = ((current - entryPrice) / (takeProfit - entryPrice)).clamp(0.0, 1.0);
    }

    final double pipsVal = livePrice != null ? (livePrice! - entryPrice) * 10000 : 0.0;
    final String pipsStr = '${pipsVal >= 0 ? '+' : ''}${pipsVal.toStringAsFixed(2)} PIPS';

    return TradingSignalModel(
      publicId: publicId,
      pair: pair,
      category: market.toUpperCase(),
      type: marketType.toUpperCase(),
      status: normalizedStatus,
      entryPrice: entryPrice,
      stopLoss: stopLoss,
      takeProfit: takeProfit,
      livePrice: livePrice ?? entryPrice,
      livePriceChange: livePrice != null
          ? '+${((livePrice! - entryPrice) / entryPrice * 100).toStringAsFixed(2)}%'
          : '0.00%',
      isLivePriceUp: (livePrice ?? entryPrice) >= entryPrice,
      pips: pipsStr,
      rr: riskRewardRatio,
      progress: progress,
      outcome: outcome,
      timeLabel: createdAt != null ? _formatTradeTimeLabel(createdAt!) : 'Just now',
      sparklineData: sparklineData,
      tradingViewUrl: tradingViewUrl,
      isTaken: isTaken,
    );
  }
}

String _formatTradeTimeLabel(String dateStr) {
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
