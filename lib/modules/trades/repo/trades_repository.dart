import '../../../utils/exports.dart';

abstract class TradesRepository extends BaseRepository {
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getTrades();
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getMyTrades();
  Future<ResponseHandler<BaseResponse<dynamic>>> takeTrade(String tradePublicId);
}
