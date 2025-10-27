import '../../../utils/exports.dart';
///ChangePasswordRepositoryImpl
class ChangePasswordRepositoryImpl extends ChangePasswordRepository {
  /// Change password API
  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> callChangePasswordApi(
      ChangePasswordRequestModel request) async {
    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.changePassword,
      apiType: ApiType.post,
      data: request.toJson(),
      showLoader: true,
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value){
        final BaseResponse<List<void>> result =
        BaseResponse<List<void>>(
          success: value['success'] == true,
          statusCode: value['status_code'] ?? 0,
          message: value['message'] ?? '',
          totalCount: value['total_count'] as int?,
          error: value['error'] as String?,
        );

        return result;
      }
    );
  }
}
