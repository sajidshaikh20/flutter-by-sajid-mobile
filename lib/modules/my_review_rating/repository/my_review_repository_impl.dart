import '../../../utils/exports.dart';

/// Implementation of [MyReviewRepository] that handles review and rating API calls.
class MyReviewRepositoryImpl extends MyReviewRepository {
  ///The `getResponseList` method  an API call to retrieve a list of languages based
  /// on the provided `GetMyReviewRequestModel`.

  @override
  Future<ResponseHandler<BaseResponse<List<ListOfMyReviewsRatingResponseModel>>>> getReviewList(
       MyReviewsRatingRequestModel myReviewsRatingRequestModel) async {
    final ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.myReviewSummary,
      apiType: ApiType.post,
      data: myReviewsRatingRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        final List<ListOfMyReviewsRatingResponseModel> deals =
        (value['data'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map((Map<String, dynamic> item) =>
            ListOfMyReviewsRatingResponseModel.fromJson(item))
            .toList();

        final BaseResponse<List<ListOfMyReviewsRatingResponseModel>> result =
        BaseResponse<List<ListOfMyReviewsRatingResponseModel>>(
          success: value['success'] == true || value['status_code'] == 200,
          statusCode: value['status_code'] ?? 0,
          message: value['message'] ?? '',
          data: deals,
          totalCount: value['total_count'] as int?,
          error: value['error'] as String?,
        );

        return result;
      },
    );
  }
}
