import '../../../utils/exports.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<ResponseHandler<BaseResponse<HomeDashboardResponse>>> getClientDashboard() async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.clientDashboard,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<HomeDashboardResponse>.fromJson(
          value,
          (Object? json) =>
              HomeDashboardResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }
}
