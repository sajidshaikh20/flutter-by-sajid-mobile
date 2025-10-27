import '../../../utils/exports.dart';

/// `MyAccountRepositoryImpl` is a class that extends `MyAccountRepository` and
/// provides implementations for various user account related API calls.
class MyAccountRepositoryImpl extends MyAccountRepository {
  /// Calls the logout API to log the user out of the application.
  /// Returns a `ResponseHandler` containing a `LogOutResponseModel`.
  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> callLogoutApi() async {
    LogoutRequestModel logoutRequestModel = LogoutRequestModel(
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        customerToken: getIt<UserProfileService>().customerToken);
    DebugLog.instance
        .i('LogoutRequestModel created: ${logoutRequestModel.toJson()}');
    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.logout,
            apiType: ApiType.post,
            data: logoutRequestModel.toJson(),
            showLoader: true);

    return getParsedResponseHandler(
        responseHandler: response,
        parser: (Map<String, dynamic> value) {
          final BaseResponse<List<void>> result =
              BaseResponse<List<void>>(
            success: value['success'] == true || value['status_code'] == 200,
            statusCode: value['status_code'] ?? 0,
            message: value['message'] ?? '',
            totalCount: value['total_count'] as int?,
            error: value['error'] as String?,
          );

          return result;
        });
  }

  /// Calls the delete account API to delete the user's account.
  /// Returns a `ResponseHandler` containing a `LogOutResponseModel`.
  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> callDeleteAccountAPI() async {
    DeleteAccountRequestModel request = DeleteAccountRequestModel(
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        storeId: getIt<CountryService>().store,
        customerToken: getIt<UserProfileService>().customerToken);
    DebugLog.instance
        .i('DeleteAccountRequestModel created: ${request.toJson()}');
    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.deleteAccount,
            apiType: ApiType.post,
            data: request.toJson(),
            showLoader: true);

    return getParsedResponseHandler(
        responseHandler: response,
        parser: (Map<String, dynamic> value) {
          final BaseResponse<List<void>> result =
              BaseResponse<List<void>>(
            success: value['success'] == true || value['status_code'] == 200,
            statusCode: value['status_code'] ?? 0,
            message: value['message'] ?? '',
            totalCount: value['total_count'] as int?,
            error: value['error'] as String?,
          );

          return result;
        });
  }

  /// Calls the account details API to fetch the user's account information.
  /// Returns a `ResponseHandler` containing a `MyAccountInfoModel`.
  @override
  Future<ResponseHandler<MyAccountInfoModel>> callAccountDetails() async {
    AccountDetailsRequest accountDetails = AccountDetailsRequest(
        // storeId: getIt<LanguageService>().storeId,
        websiteId: getIt<CountryService>().websiteId,
        customerToken: getIt<UserProfileService>().customerToken,
        etag: "");

    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.getAccountInfo, params: accountDetails.toJson());

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) => MyAccountInfoModel.fromJson(
        value,
      ),
    );
  }

  /// Calls the CMS API to fetch CMS content.
  /// Requires a `CmsRequestModel` to specify the content to fetch.
  /// Returns a `ResponseHandler` containing a `CmsResponseModel`.
  @override
  Future<ResponseHandler<CmsResponseModel>> callCMSApi(
      {required CmsRequestModel cmsRequestModel}) async {
    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.cmsAccountApi, params: cmsRequestModel.toJson());

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) => CmsResponseModel.fromJson(
        value,
      ),
    );
  }

  ///getLoyaltyPoints
  @override
  Future<ResponseHandler<BaseResponse<List<LoyaltyPointsResponseModel>>>>
      getLoyaltyPoints(
    LoyaltyPointsRequestModel request,
  ) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.loyaltyPoints,
      apiType: ApiType.post,
      data: request.toJson(),

    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        final List<LoyaltyPointsResponseModel> loyaltyPointsData =
            (value['data'] as List<dynamic>? ?? <dynamic>[])
                .whereType<Map<String, dynamic>>()
                .map((Map<String, dynamic> item) =>
                    LoyaltyPointsResponseModel.fromJson(item))
                .toList();

        return BaseResponse<List<LoyaltyPointsResponseModel>>(
          success: value['success'] == true || value['status_code'] == 200,
          statusCode: value['status_code'] ?? 0,
          message: value['message'] ?? '',
          data: loyaltyPointsData,
          totalCount: value['total_count'] as int?,
          error: value['error'] as String?,
        );
      },
    );
  }
}
