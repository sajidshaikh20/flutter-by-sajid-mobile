import '../../../utils/exports.dart';

class LeaderboardItemModel extends Equatable {
  const LeaderboardItemModel({
    required this.rank,
    required this.name,
    required this.winRate,
    required this.status,
    required this.type,
    this.avatarUrl,
    required this.pnl,
    required this.tradesCount,
  });

  final int rank;
  final String name;
  final double winRate;
  final String status; // 'ACTIVE' or 'INACTIVE'
  final String type;   // 'TRADER' or 'CLIENT'
  final String? avatarUrl;
  final double pnl;
  final int tradesCount;

  @override
  List<Object?> get props => <Object?>[
        rank,
        name,
        winRate,
        status,
        type,
        avatarUrl,
        pnl,
        tradesCount,
      ];
}
