class HomeDashboardResponse {
  final int totalTrades;
  final int winningTrades;
  final double winRate;
  final double profitability;

  HomeDashboardResponse({
    required this.totalTrades,
    required this.winningTrades,
    required this.winRate,
    required this.profitability,
  });

  factory HomeDashboardResponse.fromJson(Map<String, dynamic> json) {
    return HomeDashboardResponse(
      totalTrades: json['totalTrades'] as int? ?? json['total_trades'] as int? ?? 0,
      winningTrades: json['winningTrades'] as int? ?? json['winning_trades'] as int? ?? 0,
      winRate: (json['winRate'] as num? ?? json['win_rate'] as num? ?? 0.0).toDouble(),
      profitability: (json['profitability'] as num? ?? json['profitability'] as num? ?? 0.0).toDouble(),
    );
  }
}