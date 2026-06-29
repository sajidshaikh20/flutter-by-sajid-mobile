import '../../../utils/exports.dart';

class TradeResultModel extends Equatable {
  const TradeResultModel({
    required this.id,
    required this.pair,
    required this.imageUrl,
    required this.amount,
    required this.timestamp,
    required this.isProfit,
    required this.pips,
    required this.description,
  });

  final String id;
  final String pair;
  final String imageUrl;
  final String amount;
  final String timestamp;
  final bool isProfit;
  final int pips;
  final String description;

  factory TradeResultModel.fromJson(Map<String, dynamic> json) {
    // 1. Get raw image url
    String rawImageUrl = json['tradingViewImageUrl']?.toString() ?? json['imageUrl']?.toString() ?? json['image_url']?.toString() ?? '';

    // 2. Format the profitLoss/amount
    final num profitLoss = json['profitLoss'] as num? ?? json['profit_loss'] as num? ?? 0.0;
    final bool isProfit = (json['outcome']?.toString().toUpperCase() == 'PROFIT') || 
                          (json['isProfit'] as bool? ?? json['is_profit'] as bool? ?? profitLoss > 0.0);
    final String sign = isProfit ? '+' : '';
    final String amountStr = '$sign\$${profitLoss.abs().toStringAsFixed(2)}';

    // 3. Format timestamp / closedAt
    String dateStr = json['closedAt']?.toString() ?? json['timestamp']?.toString() ?? json['created_at']?.toString() ?? '';
    if (dateStr.isNotEmpty) {
      try {
        final DateTime parsedDate = DateTime.parse(dateStr);
        dateStr = DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
      } on Object catch (_) {
        // Fallback to raw string if parsing fails
      }
    }

    final double pipsVal = (json['pipsGained'] as num? ?? json['pips'] as num? ?? 0.0).toDouble();

    return TradeResultModel(
      id: json['tradePublicId']?.toString() ?? json['id']?.toString() ?? '',
      pair: json['symbol']?.toString() ?? json['pair']?.toString() ?? '',
      imageUrl: rawImageUrl,
      amount: amountStr,
      timestamp: dateStr,
      isProfit: isProfit,
      pips: pipsVal.abs().toInt(),
      description: json['note']?.toString() ?? json['description']?.toString() ?? '',
    );
  }
  @override
  List<Object?> get props => <Object?>[
        id,
        pair,
        imageUrl,
        amount,
        timestamp,
        isProfit,
        pips,
        description,
      ];
}
