import '../../../../utils/exports.dart';

/// Handles search queries, emits loading/success/failure, and manages input.
class SearchCubit extends Cubit<SearchState> {
  /// Creates a search cubit.
  SearchCubit({required this.repository, required SearchState intialState})
      : super(intialState);

  /// The repository used for search operations.
  final SearchRepository repository;


  ///Clear search list
  void clearList() {
    emit(state.copyWith(
        status: BaseStateStatus.initial,
      productListingResponse: BaseResponse<List<ProductListingResponse>>(
        data: <ProductListingResponse>[],
        statusCode: 0,
        success: false,
        message: ''
      ),
    ));
  }

  /// Clears the search text and resets the state.
  void onClearText() {
    state.searchController.text = "";
    emit(state.copyWith(
      status: BaseStateStatus.initial,
      errorMessage: '',
      isLoading: false,
      searchText: "",
      productListingResponse: BaseResponse<List<ProductListingResponse>>(
          data: <ProductListingResponse>[],
          statusCode: 0,
          success: false,
          message: ''
      ),
    ));
  }
///emitOnChangeText
  void emitOnChangeText(String value) {
    state.searchController.text = value;
    emit(state.copyWith(
      status: BaseStateStatus.initial,
      errorMessage: '',
      isLoading: false,
      searchText: value,
      msg: "",
    ));
  }


  @override
  Future<void> close() {
    state.searchController.dispose();
    return super.close();
  }


  /// Fetches product listing data with filters
  Future<void> getProductListing({
    int? typeId,
    String? type,
    String? query = '',
    String? sorting = AppConstant.sortingLowToHigh,
    List<FilterData>? filterData,
  }) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        status: BaseStateStatus.loading,
      ));

      // Use passed parameters or fall back to state parameters
      final int? finalTypeId = typeId ?? state.typeId;
      final String? finalType = type ?? state.type;

      // Create request model
      final ProductListingRequestModel request = ProductListingRequestModel(
        customerToken: getIt<UserProfileService>().customerToken,
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        typeId: finalTypeId,
        storeId: getIt<CountryService>().store.toString(),
        type: finalType,
        query: query,
        sorting: sorting,
        filterData: filterData,
      );

      // Make API call
      final ResponseHandler<BaseResponse<
          List<ProductListingResponse>>> response = await repository
          .getProductListing(request: request);

      if (response.isSuccess()) {
        final BaseResponse<
            List<ProductListingResponse>>? productListingResponse = response
            .getSuccessInstance()
            ?.response;

        if (productListingResponse != null) {
          emit(state.copyWith(
            productListingResponse: productListingResponse,
            isLoading: false,
            status: BaseStateStatus.success,
          ));

          DebugLog.instance.e(productListingResponse
              .toJson((
              List<ProductListingResponse> data) =>
              data.map((ProductListingResponse e) => e.toJson()).toList())
              .toString());
        } else {
          emit(state.copyWith(
            isLoading: false,
            status: BaseStateStatus.failure,
            errorMessage: productListingResponse?.error,
          ));
        }
      } else {
        final String error = response
            .getFailureInstance()
            ?.error
            ?.errorMessage ??
            '';

        emit(state.copyWith(
          isLoading: false,
          status: BaseStateStatus.failure,
          errorMessage: error,
        ));
        //  print('Product Listing Error: $error');
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        isLoading: false,
        status: BaseStateStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
