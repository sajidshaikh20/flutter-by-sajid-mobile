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
    final String inferredType = (publicId.startsWith('TD') || publicId.startsWith('MENTOR') || publicId.startsWith('USBD') || publicId.isNotEmpty)
        ? 'TRADER'
        : 'TRADER';

    double parseDouble(dynamic val) {
      if (val == null) return 0.0;
      return double.tryParse(val.toString()) ?? 0.0;
    }

    int parseInt(dynamic val) {
      if (val == null) return 0;
      if (val is int) return val;
      return int.tryParse(val.toString()) ?? 0;
    }

    return LeaderboardItemResponse(
      rank: parseInt(json['rank']),
      name: json['name']?.toString() ?? '',
      winRate: parseDouble(json['winRate']),
      status: json['accountStatus']?.toString() ?? json['status']?.toString() ?? 'ACTIVE',
      type: json['type']?.toString() ?? inferredType,
      pnl: json['netPoints'] != null ? parseDouble(json['netPoints']) : parseDouble(json['pnl']),
      tradesCount: json['totalTrades'] != null ? parseInt(json['totalTrades']) : parseInt(json['tradesCount']),
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
