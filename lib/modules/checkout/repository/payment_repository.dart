import '../../../utils/exports.dart';

/// Abstract class representing a payment repository that interacts with the API
/// for reviewing payment and proceeding with checkout.
abstract class PaymentRepository extends BaseRepository {

  /// Fetches the review payment details.
  ///
  /// [reviewPaymentRequestModel] The [ReviewPaymentRequestModel] containing the necessary
  /// parameters to review payment details.
  ///
  /// Returns a [ResponseHandler] containing [ReviewPaymentResponseModel] with the
  /// payment review details.
  Future<ResponseHandler<ReviewPaymentResponseModel>?> getReviewPaymentApi({
    required ReviewPaymentRequestModel reviewPaymentRequestModel,
  });

  /// Proceeds with the checkout process by placing an order.
  ///
  /// [placeOrderRequestModel] The [PlaceOrderRequestModel] containing the necessary
  /// parameters to place the order and proceed to checkout.
  ///
  /// Returns a [ResponseHandler] containing [PlaceOrderResponseModel] with the
  /// details of the placed order and checkout status.
  Future<ResponseHandler<PlaceOrderResponseModel>?> proceedToCheckout({
    required PlaceOrderRequestModel placeOrderRequestModel,
  });
}
