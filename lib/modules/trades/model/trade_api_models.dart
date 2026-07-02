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
  final String? traderName;
  final double? riskAmount;
  final double? lotSize;
  final double? resultInPips;

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
    this.traderName,
    this.riskAmount,
    this.lotSize,
    this.resultInPips,
  });

  factory TradeResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> source = _mergeTradeJson(json);
    final List<dynamic> levelsList = source['levels'] as List<dynamic>? ??
        source['tradeLevels'] as List<dynamic>? ??
        <dynamic>[];

    return TradeResponse(
      publicId: source['tradePublicId'] ?? source['publicId'] ?? '',
      market: source['market']?.toString() ?? '',
      marketType: source['marketType']?.toString() ?? '',
      status: _normalizeTradeStatus(source['tradeStatus'] ?? source['status']),
      riskRewardRatio: source['riskRewardRatio']?.toString() ?? '1:2',
      note: source['note']?.toString() ?? '',
      tradingViewUrl: source['tradingViewUrl']?.toString() ?? '',
      levels: levelsList
          .map((dynamic l) => TradeLevelResponse.fromJson(l as Map<String, dynamic>))
          .toList(),
      exitPrice: source['exitPrice'] != null
          ? double.tryParse(source['exitPrice'].toString())
          : null,
      livePrice: source['livePrice'] != null
          ? double.tryParse(source['livePrice'].toString())
          : null,
      createdAt: source['createdAt']?.toString(),
      outcome: source['outcome']?.toString(),
      currencyPair: source['currencyPair'] is Map<String, dynamic>
          ? source['currencyPair'] as Map<String, dynamic>
          : (source['currencyPairSymbol'] != null
              ? <String, dynamic>{'symbol': source['currencyPairSymbol']}
              : null),
      traderName: source['traderName']?.toString(),
      riskAmount: source['riskAmount'] != null
          ? double.tryParse(source['riskAmount'].toString())
          : null,
      lotSize: source['lotSize'] != null
          ? double.tryParse(source['lotSize'].toString())
          : null,
      resultInPips: source['resultInPips'] != null
          ? double.tryParse(source['resultInPips'].toString())
          : null,
    );
  }

  static Map<String, dynamic> _mergeTradeJson(Map<String, dynamic> json) {
    if (json['trade'] is Map<String, dynamic>) {
      return <String, dynamic>{
        ...json['trade'] as Map<String, dynamic>,
        ...json,
      };
    }
    return json;
  }

  static String _normalizeTradeStatus(Object? rawStatus) {
    final String status = rawStatus?.toString().toUpperCase() ?? 'ACTIVE';
    if (status == 'CANCEL' || status == 'CANCELLED') {
      return 'CANCELLED';
    }
    return status;
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
      'traderName': traderName,
      'riskAmount': riskAmount,
      'lotSize': lotSize,
      'resultInPips': resultInPips,
    };
  }

  /// Maps API trade response to UI [TradingSignalModel].
  TradingSignalModel toTradingSignalModel({bool isTaken = false}) {
    double entryPrice = 0.0;
    double? entryPriceTwo;
    double stopLoss = 0.0;
    double takeProfit = 0.0;
    double? takeProfitOne;
    double? takeProfitTwo;
    double? takeProfitThree;

    final List<TradeLevelResponse> entryLevels = levels
        .where((TradeLevelResponse lvl) => lvl.levelType.toUpperCase() == 'ENTRY')
        .toList();

    if (entryLevels.isNotEmpty) {
      entryPrice = double.tryParse(entryLevels[0].entryPoint) ?? 0.0;
      stopLoss = double.tryParse(entryLevels[0].stopLoss) ?? 0.0;
      takeProfitOne = double.tryParse(entryLevels[0].takeProfit);
      if (entryLevels.length > 1) {
        entryPriceTwo = double.tryParse(entryLevels[1].entryPoint);
      }
    }

    final List<TradeLevelResponse> tpLevels = levels
        .where((TradeLevelResponse lvl) => lvl.levelType.toUpperCase() == 'TAKE_PROFIT')
        .toList();

    for (final TradeLevelResponse lvl in tpLevels) {
      if (lvl.level == 1) {
        takeProfitOne = double.tryParse(lvl.takeProfit);
      } else if (lvl.level == 2) {
        takeProfitTwo = double.tryParse(lvl.takeProfit);
      } else if (lvl.level == 3) {
        takeProfitThree = double.tryParse(lvl.takeProfit);
      }
    }

    if (tpLevels.isNotEmpty) {
      final List<TradeLevelResponse> sortedTps = List<TradeLevelResponse>.from(tpLevels)
        ..sort((TradeLevelResponse a, TradeLevelResponse b) => a.level.compareTo(b.level));
      takeProfit = double.tryParse(sortedTps.last.takeProfit) ?? takeProfitOne ?? 0.0;
    } else {
      takeProfit = takeProfitOne ?? 0.0;
    }

    if (entryPrice == 0.0 && levels.isNotEmpty) {
      entryPrice = double.tryParse(levels.first.entryPoint) ?? 0.0;
      stopLoss = double.tryParse(levels.first.stopLoss) ?? 0.0;
      takeProfit = double.tryParse(levels.first.takeProfit) ?? 0.0;
    }

    final String pair =
        currencyPair?['symbol'] as String? ?? currencyPair?['name'] as String? ?? 'EURUSD';
    final String normalizedStatus = _normalizeTradeStatus(status);

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
      entryPriceTwo: entryPriceTwo,
      stopLoss: stopLoss,
      takeProfit: takeProfit,
      takeProfitOne: takeProfitOne,
      takeProfitTwo: takeProfitTwo,
      takeProfitThree: takeProfitThree,
      livePrice: (normalizedStatus == 'CLOSED' ? (exitPrice ?? livePrice) : livePrice) ?? entryPrice,
      livePriceChange: livePrice != null
          ? '+${((livePrice! - entryPrice) / entryPrice * 100).toStringAsFixed(2)}%'
          : '0.00%',
      isLivePriceUp: (livePrice ?? entryPrice) >= entryPrice,
      pips: pipsStr,
      rr: riskRewardRatio,
      progress: progress,
      outcome: outcome,
      createdAt: createdAt,
      timeLabel: createdAt != null ? _formatTradeTimeLabel(createdAt!) : 'Just now',
      sparklineData: sparklineData,
      tradingViewUrl: tradingViewUrl,
      isTaken: isTaken,
      traderName: traderName,
      riskAmount: riskAmount,
      lotSize: lotSize,
      resultInPips: resultInPips,
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
