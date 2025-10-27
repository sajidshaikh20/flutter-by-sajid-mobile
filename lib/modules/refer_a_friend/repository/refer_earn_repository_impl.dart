import '../../../utils/exports.dart';

/// Implementation of the refer and earn repository.
class ReferEarnRepositoryImpl extends ReferEarnRepository {
  @override
  Future<ResponseHandler<ReferEarnResponse>> getReferEarnApiCall(
      String websiteId,/* String storeId, */String customerToken) async {
    Map<String, dynamic> param = <String, dynamic>{};
    // param[APIConstant.storeId] = storeId;
    param[APIConstant.websiteId] = websiteId;
    param[APIConstant.customerToken] = customerToken;

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig.apiClient
        .handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.referFriendApi,
            params: param);

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) => ReferEarnResponse.fromJson(
        value,
      ),
    );
  }
}
