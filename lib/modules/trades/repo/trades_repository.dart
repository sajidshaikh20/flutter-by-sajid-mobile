import '../../../utils/exports.dart';

/// Repository for the Trades (Trading Signals) module (`/trade/my-trades-by-plan`).
abstract class TradesRepository extends BaseRepository {
  /// Plan-based trade signals shown on the Trades tab.
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getTradesByPlan({
    String? status,
    int? limit,
    int? offset,
  });

  /// Client's taken trades — used on Trades tab to mark signals as already taken.
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getClientMyTrades({
    int? limit,
    int? offset,
  });

  Future<ResponseHandler<BaseResponse<dynamic>>> takeTrade(String tradePublicId);

  /// Search trade signals by keyword
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> searchTrades({
    required String keyword,
  });
}
