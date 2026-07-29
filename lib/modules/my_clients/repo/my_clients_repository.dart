import '../../../utils/exports.dart';


abstract class MyClientsRepository extends BaseRepository {
  Future<ResponseHandler<BaseResponse<List<TradeWithClientsModel>>>> getMyClients({
    int? limit,
    int? offset,
  });
}
