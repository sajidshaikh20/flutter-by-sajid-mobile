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
    required this.publicId,
    this.isFollowing = false,
  });

  final int rank;
  final String name;
  final double winRate;
  final String status; // 'ACTIVE' or 'INACTIVE'
  final String type;   // 'TRADER' or 'CLIENT'
  final String? avatarUrl;
  final double pnl;
  final int tradesCount;
  final String publicId;
  final bool isFollowing;

  LeaderboardItemModel copyWith({
    int? rank,
    String? name,
    double? winRate,
    String? status,
    String? type,
    String? avatarUrl,
    double? pnl,
    int? tradesCount,
    String? publicId,
    bool? isFollowing,
  }) =>
      LeaderboardItemModel(
        rank: rank ?? this.rank,
        name: name ?? this.name,
        winRate: winRate ?? this.winRate,
        status: status ?? this.status,
        type: type ?? this.type,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        pnl: pnl ?? this.pnl,
        tradesCount: tradesCount ?? this.tradesCount,
        publicId: publicId ?? this.publicId,
        isFollowing: isFollowing ?? this.isFollowing,
      );

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
        publicId,
        isFollowing,
      ];
}
