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
abstract class WriteReviewRepository extends BaseRepository {
  /// Calls the save review API.
  ///
  /// [saveReviewRequestModel] - Request payload with review details.
  /// [showLoader] - Whether to display a loader while the request is in progress (default: true).
  Future<ResponseHandler<SaveReview>> callSaveReviewAPI(
      Map<String, dynamic> saveReviewRequestModel, // Added ratings parameter
          {bool showLoader = true});

  /// Makes an API call to rate a product.
  Future<ResponseHandler<BaseResponse<void>>> rateProducts(
     RateProductRequestModel rateProductRequestModel,
  );

  /// Makes an API call to rate an order.
  Future<ResponseHandler<BaseResponse<void>>> rateOrder(
      RateOrderRequestModel rateOrderRequestModel,
      );
}
