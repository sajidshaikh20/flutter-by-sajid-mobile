import '../../../utils/exports.dart';

/// Repository for the My Trades module (`/client/my-trades`).
abstract class MyTradesRepository extends BaseRepository {
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getMyTrades({
    String? status,
    int? limit,
    int? offset,
  });
}
