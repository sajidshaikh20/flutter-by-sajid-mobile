import '../../../utils/exports.dart';

/// Abstract repository for review and rating operations.
abstract class MyReviewRepository extends BaseRepository {
  /// Fetches the list of reviews and ratings.
  ///
  /// [myReviewsRatingRequestModel] The request model containing parameters for the review list API.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<ListOfMyReviewsRatingResponseModel>>]
  /// with the list of reviews and ratings.
  Future<ResponseHandler<BaseResponse<List<ListOfMyReviewsRatingResponseModel>>>> getReviewList(
       MyReviewsRatingRequestModel myReviewsRatingRequestModel);
}
