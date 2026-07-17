class CurrencyPairResponse {
  final int id;
  final String symbol;
  final String baseCurrency;
  final String quoteCurrency;
  final String market;
  final double currentPrice;
  final double? pipValue;

  CurrencyPairResponse({
    required this.id,
    required this.symbol,
    required this.baseCurrency,
    required this.quoteCurrency,
    required this.market,
    required this.currentPrice,
    this.pipValue,
  });

  factory CurrencyPairResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyPairResponse(
      id: json['id'] as int? ?? 0,
      symbol: json['symbol'] as String? ?? '',
      baseCurrency: json['baseCurrency'] as String? ?? '',
      quoteCurrency: json['quoteCurrency'] as String? ?? '',
      market: json['market'] as String? ?? '',
      currentPrice: (json['currentPrice'] as num? ?? 0.0).toDouble(),
      pipValue: json['pipValue'] != null ? (json['pipValue'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'symbol': symbol,
      'market': market,
      'currentPrice': currentPrice,
      'pipValue': pipValue,
    };
  }
}
