import '../../../utils/exports.dart';

/// Abstract repository for product listing with filter operations.
abstract class ProductListingRepository extends BaseRepository {
  /// Fetches product listing data with filters.
  ///
  /// [request] The request model containing all necessary parameters
  /// for the product listing API call.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<ProductListingResponse>>]
  /// with the product listing data.
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>> getProductListing({
    required ProductListingRequestModel request,
  });

  /// Fetches the home deals list.
  Future<ResponseHandler<BaseResponse<List<DealsResponseModel>>>>
  getHomeDealsList(
      DealsRequestModel request,
      );

  /// Fetches related products for a given product SKU.
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>> getRelatedProducts(
      String productSku, {
      dynamic quoteId,
    });

  /// Fetches related products with filters applied.
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>> getRelatedProductsWithFilters(
      String productSku, {
      int? limit,
      int? offset,
      String? sorting,
      List<FilterData>? filterData,
      dynamic quoteId,
    });

  /// Fetches trending products.
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>> getTrendingProducts({
      dynamic quoteId,
    });

  /// Fetches trending products with filters applied.
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>> getTrendingProductsWithFilters({
      int? limit,
      int? offset,
      String? sorting,
      List<FilterData>? filterData,
      dynamic quoteId,
    });

  /// Fetches filter data for product listing.
  ///
  /// [request] The request model containing all necessary parameters
  /// for the filter data API call.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<GetFilterData>]
  /// with the filter data.
  Future<ResponseHandler<BaseResponse<GetFilterData>>> getFilterData({
    required GetFilterDataRequestModel request,
  });

}
