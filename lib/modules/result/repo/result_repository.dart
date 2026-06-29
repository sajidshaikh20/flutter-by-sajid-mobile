import '../../../utils/exports.dart';

abstract class ResultRepository extends BaseRepository {
  ResultRepository();

  Future<ResponseHandler<BaseResponse<List<TradeResultModel>>>> getTradeResults({
    int? limit,
    int? offset,
  });
}
