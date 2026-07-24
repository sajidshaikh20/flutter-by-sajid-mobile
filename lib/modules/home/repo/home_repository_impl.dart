import '../../../utils/exports.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<ResponseHandler<BaseResponse<HomeDashboardResponse>>> getClientDashboard() async {
    final String role = UserProfileService.instance().roleName.toUpperCase();
    final String endpoint = (role == 'TRADER' || role == 'MENTOR')
        ? Apis.traderDashboard
        : Apis.clientDashboard;

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: endpoint,
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
