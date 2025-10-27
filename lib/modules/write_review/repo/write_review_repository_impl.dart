import '../../../utils/exports.dart';



/// Abstract repository for handling review-related API operations.
///
/// This class extends [BaseRepository] to inherit base networking
/// or repository logic (such as request handling, error handling, etc.).
///
/// Responsibilities:
/// - Defines the contract for saving a review through an API call.
///
/// Methods:
/// - [callSaveReviewAPI]: Sends the review data to the backend to save it.
///
/// Parameters:
/// - [showLoader]: Optional flag to control showing a loading indicator (defaults to `true`).
///
/// Returns:
/// - [Future<ResponseHandler<SaveReview>>]: A response wrapper containing the
///   API result or error details.
class WriteReviewRepositoryImpl extends WriteReviewRepository {
  @override
  Future<ResponseHandler<SaveReview>> callSaveReviewAPI(
      Map<String, dynamic> saveReviewRequestModel, // Added ratings parameter
      {bool showLoader = true}) async {
    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.saveReview,
      apiType: ApiType.post,
      params: saveReviewRequestModel,
      showLoader: showLoader,
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) => SaveReview.fromJson(
          value), // Assuming SaveReview has a fromJson method
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<void>>> rateProducts(RateProductRequestModel rateProductRequestModel) async{
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.rateProducts,
      apiType: ApiType.post,
      showLoader: true,
      data: rateProductRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<void>.fromJson(
          value, (_) {}, // No data expected, so return null
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<void>>> rateOrder(RateOrderRequestModel rateOrderRequestModel) async{
    ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.rateOrder,
      apiType: ApiType.post,
      showLoader: true,
      data: rateOrderRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<void>.fromJson(
          value, (_) {}, // No data expected, so return null
        );
      },
    );
  }
}
