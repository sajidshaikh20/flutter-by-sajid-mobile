import '../../../utils/exports.dart';

/// Implementation of the [CategoryListingRepository] that fetches category
/// listing data.
///
/// This class implements the [getCategoryListing] method and interacts
/// with the API
/// client to retrieve category listing data. It decides which API endpoint to
/// call
/// based on whether the request is a search or a product listing.
class CategoryListingRepositoryImpl extends CategoryListingRepository {
  @override
  Future<ResponseHandler<CategoryListingResponse>> getCategoryListing({
    required CategoryListingModel categoryModel,
  }) async {
    // Determine the API endpoint based on whether the request is from a search
    // or a category listing.
    String endpoint = categoryModel.isFromSearch ?? false
        ? Apis.getSearchList
        : Apis.productListing; // Otherwise, use product listing endpoint

    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.get<Map<String, dynamic>>(
      endpoint,
      params: categoryModel.toJson(),
    );

    // Return the parsed response using the specified parser.
    return getParsedResponseHandler(
      responseHandler: response,
      parser: CategoryListingResponse.fromJson,
    );
  }
}
