import '../../../utils/exports.dart';

/// Implementation of [ProductListingRepository] that handles API calls
/// for product listing with filter operations.

/// Implementation of [ProductListingRepository] that handles API calls
/// for product listing with filter operations.
class ProductListingRepositoryImpl extends ProductListingRepository {
  /// Fetches product listing data with filters by making an API call.
  ///
  /// [request] The request model containing all necessary parameters
  /// for the product listing API call.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<ProductListingResponse>>]
  /// with the product listing data.
  @override
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>>
      getProductListing({
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
      parser: (Map<String, dynamic> json) =>
          BaseResponse<List<ProductListingResponse>>.fromJson(
        json,
        (dynamic data) => (data as List<dynamic>)
            .map((dynamic item) =>
                ProductListingResponse.fromJson(item as Map<String, dynamic>))
            .toList(),
      ),
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
          success: value['success'] == true && value['status_code'] == 200,
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

  /// Fetches filter data for product listing by making an API call.
  ///
  /// [request] The request model containing all necessary parameters
  /// for the filter data API call.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<GetFilterData>]
  /// with the filter data.
  @override
  Future<ResponseHandler<BaseResponse<GetFilterData>>> getFilterData({
    required GetFilterDataRequestModel request,
  }) async {
    // Make the API call to fetch filter data
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.getFilterData,
      apiType: ApiType.post,
      data: request.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) =>
          BaseResponse<GetFilterData>.fromJson(
        value,
        (Object? json) => GetFilterData.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>>
      getRelatedProducts(String productSku, {dynamic quoteId}) async {
    DebugLog.instance.e("=== Repository getRelatedProducts STARTED ===");
    DebugLog.instance.e("Product SKU: $productSku");
    final RelatedProductsRequestModel requestModel =
        RelatedProductsRequestModel(
      customerToken: getIt<UserProfileService>().customerToken,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      productSku: productSku,
      limit: AppConstant.limitDeal,
      storeId: getIt<CountryService>().store ?? 0,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      quoteId: quoteId ?? getIt<UserProfileService>().quoteId,
    );
    DebugLog.instance.e("Request Model: ${requestModel.toJson()}");

    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.getRelatedProducts,
            apiType: ApiType.post,
            data: requestModel.toJson());

    DebugLog.instance.e("API Response: $response");

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        DebugLog.instance.e("Parser called with value: $value");

        return BaseResponse<List<ProductListingResponse>>.fromJson(
          value,
          (Object? json) => (json as List<dynamic>)
              .map((dynamic item) =>
                  ProductListingResponse.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>>
      getTrendingProducts({dynamic quoteId}) async {
    DebugLog.instance.e("=== Repository getTrendingProducts STARTED ===");

    final TrendingProductsRequestModel requestModel =
        TrendingProductsRequestModel(
      customerToken: getIt<UserProfileService>().customerToken,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      storeId: getIt<CountryService>().store ?? 0,
      limit: AppConstant.limitDeal,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      quoteId: quoteId ?? getIt<UserProfileService>().quoteId,
    );
    DebugLog.instance.e("Request Model: ${requestModel.toJson()}");

    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.getTrendingProducts,
            apiType: ApiType.post,
            data: requestModel.toJson());

    DebugLog.instance.e("API Response: $response");

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        DebugLog.instance.e("Parser called with value: $value");

        return BaseResponse<List<ProductListingResponse>>.fromJson(
          value,
          (Object? json) => (json as List<dynamic>)
              .map((dynamic item) =>
                  ProductListingResponse.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>>
      getRelatedProductsWithFilters(
    String productSku, {
    int? limit,
    int? offset,
    String? sorting,
    List<FilterData>? filterData,
    dynamic quoteId,
  }) async {
    DebugLog.instance.e("=== Repository getRelatedProductsWithFilters STARTED ===");
    DebugLog.instance.e("Product SKU: $productSku");

    final RelatedProductsRequestModel requestModel =
        RelatedProductsRequestModel(
      customerToken: getIt<UserProfileService>().customerToken,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      productSku: productSku,
      limit: limit ?? AppConstant.limitDeal,
      offset: offset ?? 0,
      sorting: sorting,
      storeId: getIt<CountryService>().store ?? 0,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      filterData: filterData,
      quoteId: quoteId ?? getIt<UserProfileService>().quoteId,
    );
    DebugLog.instance.e("Request Model: ${requestModel.toJson()}");

    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.getRelatedProducts,
            apiType: ApiType.post,
            data: requestModel.toJson());

    DebugLog.instance.e("API Response: $response");

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        DebugLog.instance.e("Parser called with value: $value");

        return BaseResponse<List<ProductListingResponse>>.fromJson(
          value,
          (Object? json) => (json as List<dynamic>)
              .map((dynamic item) =>
                  ProductListingResponse.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>>
      getTrendingProductsWithFilters({
    int? limit,
    int? offset,
    String? sorting,
    List<FilterData>? filterData,
    dynamic quoteId,
  }) async {
    DebugLog.instance
        .e("=== Repository getTrendingProductsWithFilters STARTED ===");

    final TrendingProductsRequestModel requestModel =
        TrendingProductsRequestModel(
      customerToken: getIt<UserProfileService>().customerToken,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      storeId: getIt<CountryService>().store ?? 0,
      limit: limit ?? AppConstant.limitDeal,
      offset: offset ?? 0,
      sorting: sorting,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      filterData: filterData,
      quoteId: quoteId ?? getIt<UserProfileService>().quoteId,
    );
    DebugLog.instance.e("Request Model: ${requestModel.toJson()}");

    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.getTrendingProducts,
            apiType: ApiType.post,
            data: requestModel.toJson());

    DebugLog.instance.e("API Response: $response");

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        DebugLog.instance.e("Parser called with value: $value");

        return BaseResponse<List<ProductListingResponse>>.fromJson(
          value,
          (Object? json) => (json as List<dynamic>)
              .map((dynamic item) =>
                  ProductListingResponse.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      },
    );
  }
}
