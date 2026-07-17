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
    num? priceNum = json['currentPrice'] as num? ??
        json['current_price'] as num? ??
        json['price'] as num? ??
        json['livePrice'] as num? ??
        json['lastPrice'] as num? ??
        json['bid'] as num? ??
        json['rate'] as num?;

    if (priceNum == null) {
      final String? strPrice = json['currentPrice']?.toString() ??
          json['current_price']?.toString() ??
          json['price']?.toString() ??
          json['livePrice']?.toString();
      if (strPrice != null) {
        priceNum = num.tryParse(strPrice);
      }
    }

    return CurrencyPairResponse(
      id: json['id'] as int? ?? 0,
      symbol: json['symbol'] as String? ??
          json['name'] as String? ??
          json['pair'] as String? ??
          json['currencyPairSymbol'] as String? ??
          '',
      baseCurrency: json['baseCurrency'] as String? ??
          json['base_currency'] as String? ??
          '',
      quoteCurrency: json['quoteCurrency'] as String? ??
          json['quote_currency'] as String? ??
          '',
      market: json['market'] as String? ?? '',
      currentPrice: (priceNum ?? 0.0).toDouble(),
      pipValue: json['pipValue'] != null
          ? (json['pipValue'] as num).toDouble()
          : (json['pip_value'] != null ? (json['pip_value'] as num).toDouble() : null),
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
