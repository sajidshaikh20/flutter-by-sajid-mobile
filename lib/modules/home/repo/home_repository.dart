import '../../../utils/exports.dart';

/// Abstract repository for home screen data operations.
abstract class HomeRepository extends BaseRepository {
  /// Creates an instance of [HomeRepository].
  HomeRepository();





//////////////////////NEW API /////////////////////////

  /// Fetches the home category list from the API.
  ///
  /// [categoryRequest] The request parameters for categories.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<CategoryResponseModel>>]
  /// with the category list data.
  Future<ResponseHandler<BaseResponse<List<CategoryResponseModel>>>>
      getHomeCategoryList(CategoryRequestModel categoryRequest);

  /// Fetches the brands listing from the API.
  ///
  /// [request] The request parameters for brands.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<ListOfBrandsResponse>>]
  /// with the brands data.
  Future<ResponseHandler<BaseResponse<List<ListOfBrandsResponse>>>>
      getBrandsListing(
    BrandListRequest request,
  );

  /// Fetches the home deals list from the API.
  ///
  /// [request] The request parameters for deals.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<DealsResponseModel>>]
  /// with the deals data.
  Future<ResponseHandler<BaseResponse<List<DealsResponseModel>>>>
      getHomeDealsList(
    DealsRequestModel request,
  );

  /// Fetches the home banners list from the API.
  ///
  /// [bannerRequest] The request parameters for banners.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<BannerResponseModel>>]
  /// with the banners data.
  Future<ResponseHandler<BaseResponse<List<BannerResponseModel>>>>
      getHomeBannersList(
    BannerRequestModel bannerRequest,
  );

  /// Fetches the loyalty points data from the API.
  ///
  /// [request] The request parameters for loyalty points.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<LoyaltyPointsResponseModel>>]
  /// with the loyalty points data.
  Future<ResponseHandler<BaseResponse<List<LoyaltyPointsResponseModel>>>> getLoyaltyPoints(
    LoyaltyPointsRequestModel request,
  );
}
