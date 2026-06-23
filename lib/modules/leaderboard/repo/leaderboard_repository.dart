import '../../../utils/exports.dart';

abstract class LeaderboardRepository extends BaseRepository {
  Future<ResponseHandler<BaseResponse<List<LeaderboardItemResponse>>>> getLeaderboard({
    int? limit,
    int? offset,
  });
}
