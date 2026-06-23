import '../../../utils/exports.dart';

class LeaderboardRepositoryImpl extends LeaderboardRepository {
  @override
  Future<ResponseHandler<BaseResponse<List<LeaderboardItemResponse>>>> getLeaderboard({
    int? limit,
    int? offset,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    if (limit != null) {
      params['limit'] = limit;
    }
    if (offset != null) {
      params['offset'] = offset;
    }

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getLeaderboard,
          params: params,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<List<LeaderboardItemResponse>>.fromJson(
          value,
          (Object? json) {
            final List<dynamic> list = json as List<dynamic>? ?? <dynamic>[];
            return list
                .map((dynamic item) => LeaderboardItemResponse.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
      },
    );
  }
}
