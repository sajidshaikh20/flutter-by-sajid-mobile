import '../../../../utils/exports.dart';

///SearchRepository
abstract class SearchRepository extends BaseRepository {
  /// Fetches product listing data with search and filters.
  ///
  /// [request] The request model containing all necessary parameters
  /// for the product listing API call including search query and filters.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<ProductListingResponse>>]
  /// with the product listing data matching the search criteria.
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>>
      getProductListing({
    required ProductListingRequestModel request,
  });
}
