import '../../../utils/exports.dart';

///Home respository implementation
class HomeRepositoryImpl extends HomeRepository {


  @override
  Future<ResponseHandler<BaseResponse<List<ListOfBrandsResponse>>>>
      getBrandsListing(BrandListRequest request) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.listOfBrands,
      data: request.toJson(),
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> json) =>
          BaseResponse<List<ListOfBrandsResponse>>.fromJson(
        json,
        (dynamic data) => (data as List<dynamic>)
            .map((dynamic item) =>
                ListOfBrandsResponse.fromJson(item as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<CategoryResponseModel>>>>
      getHomeCategoryList(CategoryRequestModel categoryRequest) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.categoryListing,
      data: categoryRequest.toJson(),

    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        final List<CategoryResponseModel> categories =
            (value['data'] as List<dynamic>? ?? <dynamic>[])
                .whereType<Map<String, dynamic>>()
                .map((Map<String, dynamic> item) =>
                    CategoryResponseModel.fromJson(item))
                .toList();

        return BaseResponse<List<CategoryResponseModel>>(
          success: value['success'] == true || value['status_code'] == 200,
          statusCode: value['status_code'] ?? 0,
          message: value['message'] ?? '',
          data: categories,
          totalCount: value['total_count'] as int?,
          error: value['error'] as String?,
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<DealsResponseModel>>>>
      getHomeDealsList(DealsRequestModel dealsRequest) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.dealsListing,
      apiType: ApiType.post,
      data: dealsRequest.toJson(),

    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        final List<DealsResponseModel> deals =
            (value['data'] as List<dynamic>? ?? <dynamic>[])
                .whereType<Map<String, dynamic>>()
                .map((Map<String, dynamic> item) =>
                    DealsResponseModel.fromJson(item))
                .toList();

        final BaseResponse<List<DealsResponseModel>> result =
            BaseResponse<List<DealsResponseModel>>(
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

  @override
  Future<ResponseHandler<BaseResponse<List<BannerResponseModel>>>>
      getHomeBannersList(BannerRequestModel bannerRequest) async {

    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.bannerListing,
      data: bannerRequest.toJson(),

    );

    if (response.isFailure()) {
      response.getFailureInstance();
    }
    
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {

          final List<BannerResponseModel> banners =
              (value['data'] as List<dynamic>? ?? <dynamic>[])
                  .whereType<Map<String, dynamic>>()
                  .map((Map<String, dynamic> item) {
                    return BannerResponseModel.fromJson(item);
                  })
                  .toList();


          final BaseResponse<List<BannerResponseModel>> result =
              BaseResponse<List<BannerResponseModel>>(
            success: value['success'] == true || value['status_code'] == 200,
            statusCode: value['status_code'] ?? 0,
            message: value['message'] ?? '',
            data: banners,
                totalCount: value['total_count'] as int?,
            error: value['error'] as String?,
          );

          return result;

      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<LoyaltyPointsResponseModel>>>> getLoyaltyPoints(
    LoyaltyPointsRequestModel request,
  ) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.loyaltyPoints,
      apiType: ApiType.post,
      data: request.toJson(),
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        final List<LoyaltyPointsResponseModel> loyaltyPointsData =
            (value['data'] as List<dynamic>? ?? <dynamic>[])
                .whereType<Map<String, dynamic>>()
                .map((Map<String, dynamic> item) =>
                LoyaltyPointsResponseModel.fromJson(item))
                .toList();

        return BaseResponse<List<LoyaltyPointsResponseModel>>(
          success: value['success'] == true || value['status_code'] == 200,
          statusCode: value['status_code'] ?? 0,
          message: value['message'] ?? '',
          data: loyaltyPointsData,
          totalCount: value['total_count'] as int?,
          error: value['error'] as String?,
        );
      },
    );
  }
}
