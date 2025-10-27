import '../../../utils/exports.dart';

/// Implementation of the product details repository.
class ProductDetailsRepositoryImpl extends ProductDetailsRepository {
  @override
  Future<ResponseHandler<BaseResponse<ProductDetailsResponse>>>
      getProductDetails(String entityId) async {
    final ProductDetailsRequestModel requestModel = ProductDetailsRequestModel(
      customerToken: getIt<UserProfileService>().customerToken,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      quoteId: getIt<UserProfileService>().quoteId ?? 0,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      currency: getIt<LanguageService>().defaultCurrency,
      storeId: getIt<CountryService>().store ?? 0,
      productId: int.tryParse(entityId),
    );

    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.productDetails,
      apiType: ApiType.post,
      data: requestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<ProductDetailsResponse>.fromJson(
          value,
          (Object? json) =>
              ProductDetailsResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<GetReviewSummaryResponse>>>
      getProductReview(String entityId) async {
    DebugLog.instance.e("=== Repository getProductReview STARTED ===");
    DebugLog.instance.e("Entity ID: $entityId");

    final ReviewRequestModel requestModel = ReviewRequestModel(
      customerToken: getIt<UserProfileService>().customerToken,
      websiteId: 1,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      currency: getIt<LanguageService>().defaultCurrency,
      storeId: getIt<CountryService>().store ?? 0,
      productId: int.tryParse(entityId) ?? 0,
    );

    DebugLog.instance.e("Request Model: ${requestModel.toJson()}");

    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.getReviewSummary,
            apiType: ApiType.post,
            data: requestModel.toJson());

    DebugLog.instance.e("API Response: $response");

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        DebugLog.instance.e("Parser called with value: $value");

        return BaseResponse<GetReviewSummaryResponse>.fromJson(
          value,
          (Object? json) =>
              GetReviewSummaryResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>>
      getRelatedProducts(String productSku) async {
    DebugLog.instance.e("=== Repository getRelatedProducts STARTED ===");
    DebugLog.instance.e("Product SKU: $productSku");

    final RelatedProductsRequestModel requestModel =
        RelatedProductsRequestModel(
      customerToken: getIt<UserProfileService>().customerToken,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      productSku: productSku,
      quoteId: getIt<UserProfileService>().quoteId ?? 0,
      limit: AppConstant.limitDeal,
      storeId: getIt<CountryService>().store ?? 0,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
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
      getTrendingProducts() async {
    DebugLog.instance.e("=== Repository getTrendingProducts STARTED ===");

    final TrendingProductsRequestModel requestModel =
        TrendingProductsRequestModel(
      customerToken: getIt<UserProfileService>().customerToken,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      storeId: getIt<CountryService>().store ?? 0,
      limit: AppConstant.limitDeal,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      quoteId: getIt<UserProfileService>().quoteId ?? 0,
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
