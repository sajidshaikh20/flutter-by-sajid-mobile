class TradingSignalModel {
  final String publicId;
  final String pair;
  final String category; // CRYPTO, FOREX
  final String type; // BUY MARKET, BUY LIMIT, etc.
  final String status; // ACTIVE, PENDING, CLOSED, CANCELLED
  final double entryPrice;
  final double? entryPriceTwo;
  final double stopLoss;
  final double takeProfit;
  final double? takeProfitOne;
  final double? takeProfitTwo;
  final double? takeProfitThree;
  final double? livePrice;
  final String? livePriceChange; // e.g., "+1.36 (+0.21%)"
  final bool? isLivePriceUp; // true if positive green, false if negative red
  final String pips; // e.g. "+113.11 PIPS"
  final String rr; // e.g. "1:2"
  final double? progress; // 0.0 to 1.0 (relative position of live price between entry and take profit)
  final String? outcome; // WIN, LOSS
  final String? createdAt;
  final String timeLabel; // e.g. "Just now", "2h ago"
  final List<double> sparklineData;
  final String? tradingViewUrl;
  final bool isTaken;
  final String? traderName;
  final double? riskAmount;
  final double? lotSize;
  final double? resultInPips;
  final double? slPips;
  final double? tpPips;
  final int? clientTradeId;
  final String? takenAt;
  final String? clientTradeStatus;

  const TradingSignalModel({
    this.publicId = '',
    required this.pair,
    required this.category,
    required this.type,
    required this.status,
    required this.entryPrice,
    this.entryPriceTwo,
    required this.stopLoss,
    required this.takeProfit,
    this.takeProfitOne,
    this.takeProfitTwo,
    this.takeProfitThree,
    this.livePrice,
    this.livePriceChange,
    this.isLivePriceUp,
    required this.pips,
    required this.rr,
    this.progress,
    this.outcome,
    this.createdAt,
    required this.timeLabel,
    required this.sparklineData,
    this.tradingViewUrl,
    this.isTaken = false,
    this.traderName,
    this.riskAmount,
    this.lotSize,
    this.resultInPips,
    this.slPips,
    this.tpPips,
    this.clientTradeId,
    this.takenAt,
    this.clientTradeStatus,
  });

  TradingSignalModel copyWith({
    String? publicId,
    String? pair,
    String? category,
    String? type,
    String? status,
    double? entryPrice,
    double? entryPriceTwo,
    double? stopLoss,
    double? takeProfit,
    double? takeProfitOne,
    double? takeProfitTwo,
    double? takeProfitThree,
    double? livePrice,
    String? livePriceChange,
    bool? isLivePriceUp,
    String? pips,
    String? rr,
    double? progress,
    String? outcome,
    String? createdAt,
    String? timeLabel,
    List<double>? sparklineData,
    String? tradingViewUrl,
    bool? isTaken,
    String? traderName,
    double? riskAmount,
    double? lotSize,
    double? resultInPips,
    double? slPips,
    double? tpPips,
    int? clientTradeId,
    String? takenAt,
    String? clientTradeStatus,
  }) {
    return TradingSignalModel(
      publicId: publicId ?? this.publicId,
      pair: pair ?? this.pair,
      category: category ?? this.category,
      type: type ?? this.type,
      status: status ?? this.status,
      entryPrice: entryPrice ?? this.entryPrice,
      entryPriceTwo: entryPriceTwo ?? this.entryPriceTwo,
      stopLoss: stopLoss ?? this.stopLoss,
      takeProfit: takeProfit ?? this.takeProfit,
      takeProfitOne: takeProfitOne ?? this.takeProfitOne,
      takeProfitTwo: takeProfitTwo ?? this.takeProfitTwo,
      takeProfitThree: takeProfitThree ?? this.takeProfitThree,
      livePrice: livePrice ?? this.livePrice,
      livePriceChange: livePriceChange ?? this.livePriceChange,
      isLivePriceUp: isLivePriceUp ?? this.isLivePriceUp,
      pips: pips ?? this.pips,
      rr: rr ?? this.rr,
      progress: progress ?? this.progress,
      outcome: outcome ?? this.outcome,
      createdAt: createdAt ?? this.createdAt,
      timeLabel: timeLabel ?? this.timeLabel,
      sparklineData: sparklineData ?? this.sparklineData,
      tradingViewUrl: tradingViewUrl ?? this.tradingViewUrl,
      isTaken: isTaken ?? this.isTaken,
      traderName: traderName ?? this.traderName,
      riskAmount: riskAmount ?? this.riskAmount,
      lotSize: lotSize ?? this.lotSize,
      resultInPips: resultInPips ?? this.resultInPips,
      slPips: slPips ?? this.slPips,
      tpPips: tpPips ?? this.tpPips,
      clientTradeId: clientTradeId ?? this.clientTradeId,
      takenAt: takenAt ?? this.takenAt,
      clientTradeStatus: clientTradeStatus ?? this.clientTradeStatus,
    );
  }

  bool get isBuy => type.toUpperCase().contains('BUY');
  bool get isClosed =>
      status.toUpperCase() == 'CLOSED' ||
      clientTradeStatus?.toUpperCase() == 'CLOSED' ||
      outcome?.toUpperCase() == 'WIN' ||
      outcome?.toUpperCase() == 'LOSS';
  bool get isCancelled =>
      status.toUpperCase() == 'CANCELLED' ||
      status.toUpperCase() == 'CANCEL' ||
      clientTradeStatus?.toUpperCase() == 'CANCELLED' ||
      clientTradeStatus?.toUpperCase() == 'CANCEL';
  bool get isActive =>
      !isClosed &&
      !isCancelled &&
      (status.toUpperCase() == 'ACTIVE' || status.toUpperCase() == 'OPEN');
  bool get isPending =>
      !isClosed &&
      !isCancelled &&
      status.toUpperCase() == 'PENDING';
}
