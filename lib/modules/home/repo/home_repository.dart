import '../../../utils/exports.dart';

abstract class HomeRepository extends BaseRepository {
  HomeRepository();

  Future<ResponseHandler<BaseResponse<HomeDashboardResponse>>> getClientDashboard();
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getRecentTrades({int? limit});
}
