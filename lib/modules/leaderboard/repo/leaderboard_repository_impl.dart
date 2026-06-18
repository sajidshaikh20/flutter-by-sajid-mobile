import '../../../utils/exports.dart';

class LeaderboardRepositoryImpl extends LeaderboardRepository {
  @override
  Future<ResponseHandler<BaseResponse<List<LeaderboardItemResponse>>>> getLeaderboard() async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getLeaderboard,
          showLoader: false,
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
