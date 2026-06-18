class LeaderboardItemResponse {
  final int rank;
  final String name;
  final double winRate;
  final String status;
  final String type;
  final double pnl;
  final int tradesCount;
  final String? avatarUrl;

  LeaderboardItemResponse({
    required this.rank,
    required this.name,
    required this.winRate,
    required this.status,
    required this.type,
    required this.pnl,
    required this.tradesCount,
    this.avatarUrl,
  });

  factory LeaderboardItemResponse.fromJson(Map<String, dynamic> json) {
    return LeaderboardItemResponse(
      rank: json['rank'] ?? 0,
      name: json['name'] ?? '',
      winRate: json['winRate'] != null ? double.parse(json['winRate'].toString()) : 0.0,
      status: json['status'] ?? 'INACTIVE',
      type: json['type'] ?? 'CLIENT',
      pnl: json['pnl'] != null ? double.parse(json['pnl'].toString()) : 0.0,
      tradesCount: json['tradesCount'] ?? 0,
      avatarUrl: json['avatarUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'rank': rank,
      'name': name,
      'winRate': winRate,
      'status': status,
      'type': type,
      'pnl': pnl,
      'tradesCount': tradesCount,
      'avatarUrl': avatarUrl,
    };
  }
}
