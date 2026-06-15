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
