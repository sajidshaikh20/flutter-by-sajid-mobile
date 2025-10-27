import '../../../utils/exports.dart';

/// Implementation of the [CategoryListingRepository] to fetch category listing
/// data from an API.
///
/// This class is responsible for making the network request to retrieve
/// the category listing information based on
/// the provided [CategoryListingModel],
/// and it returns a parsed response as [CategoryListingResponse].
class CategoryListingRepositoryImpl extends CategoryListingRepository {
  /// Fetches the category listing data from the API based on the provided
  /// [CategoryListingModel].
  ///
  /// The method constructs the appropriate API endpoint URL based on whether
  /// the category listing is being fetched from a search or a regular category.
  /// It then sends the request and returns the parsed response.
  ///
  /// [categoryModel] - The model containing the parameters for the API request.
  ///
  /// Returns a [ResponseHandler] containing the
  /// parsed [CategoryListingResponse].
  @override
  Future<ResponseHandler<CategoryListingResponse>> getCategoryListing({
    required CategoryListingModel categoryModel,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response;

    // Determine the appropriate endpoint based on whether the request is
    // from a search or a regular category listing.
    String endpoint =
        categoryModel.isFromSearch != null && categoryModel.isFromSearch!
            ? Apis.getSearchList // Use search endpoint if isFromSearch is true
            : Apis.productListing; // Use product listing endpoint otherwise

    // Send GET request to the determined endpoint with the parameters from the
    // provided [categoryModel].
    response = await MainConfig.apiClient.get<Map<String, dynamic>>(
      endpoint,
      params: categoryModel.toJson(),
    );

    // Parse the response using the CategoryListingResponse.fromJson method
    // and return the parsed result wrapped in a ResponseHandler.
    return getParsedResponseHandler(
      responseHandler: response,
      parser: CategoryListingResponse.fromJson,
    );
  }
}
