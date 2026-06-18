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
      publicId: json['publicId'] ?? '',
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
      currencyPair: json['currencyPair'] as Map<String, dynamic>?,
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
}
