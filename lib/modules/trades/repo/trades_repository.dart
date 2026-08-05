import '../../../utils/exports.dart';

/// Repository for the Trades (Trading Signals) module (`/trade/my-trades-by-plan`).
abstract class TradesRepository extends BaseRepository {
  /// Plan-based trade signals shown on the Trades tab.
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getTradesByPlan({
    String? status,
    int? limit,
    int? offset,
    String? fromDate,
    String? toDate,
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

  /// Get details of a single trade by public ID
  Future<ResponseHandler<BaseResponse<TradeResponse>>> getTradeDetails(String tradePublicId);

  /// Get currency pairs by market type
  Future<ResponseHandler<BaseResponse<List<CurrencyPairResponse>>>> getCurrencyPairs({
    required String market,
  });

  /// Create a new trade
  Future<ResponseHandler<BaseResponse<dynamic>>> createTrade(CreateSignalRequest request);
}

