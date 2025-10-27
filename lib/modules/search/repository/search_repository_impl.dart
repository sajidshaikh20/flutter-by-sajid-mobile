import '../../../utils/exports.dart';
///SearchRepositoryImpl
class SearchRepositoryImpl extends SearchRepository {

  /// Fetches product listing data with filters by making an API call.
  ///
  /// [request] The request model containing all necessary parameters
  /// for the product listing API call.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<ProductListingResponse>>]
  /// with the product listing data.
  @override
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>> getProductListing({
    required ProductListingRequestModel request,
  }) async {
    // Make the API call to fetch product listing data
    ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.productListing,
      apiType: ApiType.post,
      data: request.toJson(),
    );

    // Parse and return the response using the response handler
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> json) => BaseResponse<List<ProductListingResponse>>.fromJson(
        json,
            (dynamic data) => (data as List<dynamic>)
            .map((dynamic item) => ProductListingResponse.fromJson(item as Map<String, dynamic>))
            .toList(),
      ),
    );
  }
}
