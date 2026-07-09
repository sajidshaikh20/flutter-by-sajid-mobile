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
    final String publicId = json['publicId']?.toString() ?? '';
    final String inferredType = publicId.startsWith('TD') ? 'TRADER' : 'CLIENT';
    return LeaderboardItemResponse(
      rank: json['rank'] ?? 0,
      name: json['name'] ?? '',
      winRate: json['winRate'] != null ? double.parse(json['winRate'].toString()) : 0.0,
      status: json['accountStatus'] ?? json['status'] ?? 'INACTIVE',
      type: json['type'] ?? inferredType,
      pnl: json['netPoints'] != null ? double.parse(json['netPoints'].toString()) : (json['pnl'] != null ? double.parse(json['pnl'].toString()) : 0.0),
      tradesCount: json['totalTrades'] ?? json['tradesCount'] ?? 0,
      avatarUrl: json['profilePictureUrl']?.toString() ?? json['avatarUrl']?.toString(),
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
