import '../../../utils/exports.dart';

/// Cubit for managing the state of home categories,
/// including fetching category data.
class HomeCategoryCubit extends Cubit<HomeCategoryState> {
  /// Constructor for managing the state of home categories,
  /// including fetching category data.
  HomeCategoryCubit({required this.homeRepository})
      : super(
          HomeCategoryState(),
        ) {
    _initializeScrollListener();
    scheduleMicrotask(() async => callHomeCategory());

  }

  /// Repository for fetching home category data.
  final HomeRepository homeRepository;

  /// Fetches the home categories asynchronously and updates the state based on
  /// the result.



  /// Initialize scroll listener for infinite scroll pagination
  void _initializeScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  /// Handle scroll events for infinite scroll pagination
  void _onScroll() {
    if (state.scrollController.position.pixels >= 
        state.scrollController.position.maxScrollExtent - 200) {
      // Load more when user is 200 pixels from the bottom
      if (state.hasMore && !state.isLoadingMore) {
        unawaited(loadMoreCategories());
      }
    }
  }

  /// api call for the home HomeCategories
  Future<void> callHomeCategory({
    int? limit,
    int? offset,
  }) async {
    emit(state.copyWith(status: BaseStateStatus.loading));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final LanguageService languageService = getIt<LanguageService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Use passed parameters or fall back to defaults
    final int finalLimit = limit ?? AppConstant.limitCategoryList;
    final int finalOffset = offset ?? 0;

    // Create category request model
    final CategoryRequestModel categoryRequest = CategoryRequestModel(
        languageId: int.tryParse(languageService.languageId) ?? 1,
      //  quoteId: userProfileService.quoteId,
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        currency: languageService.defaultCurrency,
        storeId: countryService.store,
        limit: finalLimit,
        offset: finalOffset);

    // Call the repository to save address using AddAddressRepository
    final ResponseHandler<BaseResponse<List<CategoryResponseModel>>> response =
    await homeRepository.getHomeCategoryList(categoryRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<CategoryResponseModel>>>?
      successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<CategoryResponseModel>> saveResponse =
            successInstance.response;
        // Check if the save operation was successful
        if (saveResponse.success) {
          final List<CategoryResponseModel> newCategories = saveResponse.data ?? <CategoryResponseModel>[];
          final int apiTotalCount = saveResponse.totalCount ?? 0;
          final int currentOffset = offset ?? 0;
          
          // Determine if this is a fresh load or pagination
          final bool isFirstPage = currentOffset == 0;
          final List<CategoryResponseModel> updatedCategoryList = isFirstPage 
              ? newCategories 
              : <CategoryResponseModel>[...(state.categoryList), ...newCategories];
          
          // Calculate pagination info
          final bool hasMoreData = updatedCategoryList.length < apiTotalCount;
          
          emit(state.copyWith(
            status: BaseStateStatus.success,
            categoriesModel: saveResponse, // Store the category data in state
            categoryList: updatedCategoryList,
            totalCount: apiTotalCount,
            currentPage: isFirstPage ? 1 : state.currentPage + 1,
            hasMore: hasMoreData,
            isLoadingMore: false,
          ));
          DebugLog.instance.d('Home category page categories loaded: ${saveResponse.data?.length ?? 0} categories');
          
          // Debug log the category data
          if (saveResponse.data != null && saveResponse.data!.isNotEmpty) {
            for (int i = 0; i < saveResponse.data!.length; i++) {
              final CategoryResponseModel category = saveResponse.data![i];
              DebugLog.instance.d('Main Category $i: ${category.categoryName} (ID: ${category.categoryId})');
              DebugLog.instance.d('Main Category $i Image: ${category.categoryImage}');
              DebugLog.instance.d('Main Category $i Has Children: ${category.hasChildren}');
              DebugLog.instance.d('Main Category $i Child Categories Count: ${category.childCategories.length}');
              
              // Log child categories if they exist
              if (category.childCategories.isNotEmpty) {
                for (int j = 0; j < category.childCategories.length; j++) {
                  final ChildCategoryModel childCategory = category.childCategories[j];
                  DebugLog.instance.d('  - Child Category $j: ${childCategory.categoryName} (ID: ${childCategory.categoryId})');
                }
              }
            }
          }
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: saveResponse.error,
          ));
        }
      }
    }
  }

  /// Loads more categories for pagination
  Future<void> loadMoreCategories() async {
    if (!state.hasMore || state.isLoadingMore) {
      return;
    }

    DebugLog.instance.i('HomeCategoryCubit: Loading more categories - Page: ${state.currentPage + 1}');
    
    // Set loading more state
    emit(state.copyWith(isLoadingMore: true));
    
    // Calculate next offset based on current page
    final int nextOffset = state.currentPage * AppConstant.limitCategory;
    
    // Load more categories
    await callHomeCategory(
      offset: nextOffset,
      limit: AppConstant.limitCategory,
    );
  }

  /// Refreshes the category list (resets pagination)
  Future<void> refreshCategories() async {
    DebugLog.instance.i('HomeCategoryCubit: Refreshing categories');
    
    // Reset pagination state and load from beginning
    await callHomeCategory(offset: 0);
  }

  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }
}
