class CreateSignalLevel {
  final String levelType;
  final double entryPoint;
  final double stopLoss;
  final double takeProfit;
  final int level;
  final double entryPips;
  final double slPips;
  final double tpPips;

  const CreateSignalLevel({
    required this.levelType,
    required this.entryPoint,
    required this.stopLoss,
    required this.takeProfit,
    required this.level,
    required this.entryPips,
    required this.slPips,
    required this.tpPips,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'levelType': levelType,
      'entryPoint': entryPoint,
      'stopLoss': stopLoss,
      'takeProfit': takeProfit,
      'level': level,
      'entryPips': entryPips,
      'slPips': slPips,
      'tpPips': tpPips,
    };
  }
}

class CreateSignalRequest {
  final String market;
  final String marketType;
  final int? currencyPairId;
  final String note;
  final String tradingViewUrl;
  final String riskRewardRatio;
  final double slPips;
  final double tpPips;
  final List<CreateSignalLevel> levels;

  const CreateSignalRequest({
    required this.market,
    required this.marketType,
    this.currencyPairId,
    required this.note,
    required this.tradingViewUrl,
    required this.riskRewardRatio,
    required this.slPips,
    required this.tpPips,
    required this.levels,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'market': market,
      'marketType': marketType,
      'currencyPairId': currencyPairId,
      'note': note,
      'tradingViewUrl': tradingViewUrl,
      'riskRewardRatio': riskRewardRatio,
      'slPips': slPips,
      'tpPips': tpPips,
      'levels': levels.map((CreateSignalLevel l) => l.toMap()).toList(),
    };
  }
}
