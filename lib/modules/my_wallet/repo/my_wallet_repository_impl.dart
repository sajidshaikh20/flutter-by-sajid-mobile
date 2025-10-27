import '../../../utils/exports.dart';

/// Implementation of the [MyWalletRepository] for fetching wallet data.
class MyWalletRepositoryImpl extends MyWalletRepository {
  @override
  Future<ResponseHandler<MyWalletResponse>> getMyWalletData({
    required MyWalletRequest myWalletRequest,
  }) async {
    Map<String, dynamic> mapToSend = myWalletRequest.toJson();

    // Sending API request and handling response.
    ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.myWallet,
      params: mapToSend,
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: MyWalletResponse.fromJson,
    );
  }
}
