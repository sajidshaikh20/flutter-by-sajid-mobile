import '../../../utils/exports.dart';

abstract class LeaderboardRepository extends BaseRepository {
  Future<ResponseHandler<BaseResponse<List<LeaderboardItemResponse>>>> getLeaderboard({
    int? limit,
    int? offset,
    String? period,
    String? fromDate,
    String? toDate,
  });

  Future<ResponseHandler<BaseResponse<dynamic>>> followTrader(String traderPublicId);
  Future<ResponseHandler<BaseResponse<dynamic>>> unfollowTrader(String traderPublicId);
}
