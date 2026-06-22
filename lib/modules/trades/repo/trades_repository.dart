import '../../../utils/exports.dart';

abstract class TradesRepository extends BaseRepository {
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getTrades({
    String? status,
    int? limit,
    int? offset,
  });
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getMyTrades({
    String? status,
    int? limit,
    int? offset,
  });

  Future<ResponseHandler<BaseResponse<dynamic>>> takeTrade(String tradePublicId);
}
