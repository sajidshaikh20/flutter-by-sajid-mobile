import '../../../utils/exports.dart';

/// Implementation of [ContactUsRepository] for handling contact us requests.
class ContactUsRepositoryImpl extends ContactUsRepository {
  /// Sends a contact us request API call and returns a [ResponseHandler] with
  /// a [ContactUsResponseModel].
  @override
  Future<ResponseHandler<BaseResponse<void>>> contactUsApi({
    required ContactUsRequestModel contactUsRequestModel,
  }) async {
    // Convert contact us request model to JSON
    Map<String, dynamic> mapToSend = contactUsRequestModel.toJson();

    // Make API call and handle response
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.contactUs, // Endpoint for the API call
      apiType: ApiType.post, // HTTP method
      data: mapToSend, // Request body
          showLoader: true
    );

    // Parse the response into a [ContactUsResponseModel] and return
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<void>.fromJson(
          value,
              (_) {}, // No data expected, so return null
        );
      },
    );
  }
}
