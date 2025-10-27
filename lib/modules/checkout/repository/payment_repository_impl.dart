import '../../../utils/exports.dart';

/// Repository implementation for handling payment-related API calls.
/// Includes methods for review payment and proceeding to checkout.
class PaymentRepositoryImpl extends PaymentRepository {
  /// Fetches the review payment details from the server.
  /// Returns a `ResponseHandler` with the parsed `ReviewPaymentResponseModel`.
  @override
  Future<ResponseHandler<ReviewPaymentResponseModel>?> getReviewPaymentApi({
    required ReviewPaymentRequestModel reviewPaymentRequestModel,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      apiType: ApiType.post,
      endUrl: Apis.reviewAndPayment,
      params: reviewPaymentRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: ReviewPaymentResponseModel.fromJson,
    );
  }

  /// Initiates the process to proceed to checkout by placing the order.
  /// Returns a `ResponseHandler` with the parsed `PlaceOrderResponseModel`.
  @override
  Future<ResponseHandler<PlaceOrderResponseModel>?> proceedToCheckout({
    required PlaceOrderRequestModel placeOrderRequestModel,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.placeOrder,
      apiType: ApiType.post,
      data: placeOrderRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: PlaceOrderResponseModel.fromJson,
    );
  }
}
