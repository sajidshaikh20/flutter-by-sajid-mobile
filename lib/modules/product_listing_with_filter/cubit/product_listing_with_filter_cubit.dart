import '../../../utils/exports.dart';



/// Cubit that manages product listing with filter functionality and state management.
class ProductListingWithFilterCubit
    extends BaseCubit<ProductListingWithFilterState> with WishlistCartMixin<ProductListingWithFilterState>, CartOperationMixin<ProductListingWithFilterState> {
  /// The repository for product listing operations.
  final ProductListingRepository _repository;

  /// Stream subscription for global wishlist manager
  StreamSubscription<GlobalWishlistState>? _globalWishlistSubscription;

  /// Creates a product listing with filter cubit.
  ProductListingWithFilterCubit({
    ProductListingRepository? repository,
    int? typeId,
    String? type,
    String? label,
    List<dynamic>? tabLabels,
    String? productSku,
  }) : _repository = repository ?? ProductListingRepositoryImpl(),
        super(ProductListingWithFilterState.initial().copyWith(
          typeId: typeId,
          type: type,
          label: label,
          tabLabels : _addAllTabIfEmpty(tabLabels),
          selectedSortOption: AppConstant.sortOptions.first, // Set default sort option
          productSku: productSku,
        ))  {

    wishlistCartRepository = WishlistCartRepositoryImpl();
    _initializeScrollListener();
    
    // Listen to global wishlist changes
    scheduleMicrotask(() {
      final GlobalWishlistManager globalWishlistManager = getIt<GlobalWishlistManager>();
      _globalWishlistSubscription = globalWishlistManager.stream.listen((GlobalWishlistState newState) {
        DebugLog.instance.d('🔄 PLP: Global state changed, syncing PLP');
        // Always sync with cart changes
        _syncWithGlobalCart();
        _syncWithGlobalWishlist();
      });
    });


    // Fetch filter data
    DebugLog.instance.i('ProductListingWithFilterCubit: Constructor called, about to fetch filter data');
    
    // Pass tagName to getFilterData based on the type
    if(type == DealsTagName.bestDeals.name){
      DebugLog.instance.d('Calling bestDeals API with tagName');
      scheduleMicrotask(() async => getFilterData(tagName: DealsTagName.bestDeals.value));
      scheduleMicrotask(() async => callHomeDeals(tagName: DealsTagName.bestDeals, filterData: getSelectedFiltersAsFilterData()));
    } else if (type == DealsTagName.youMayAlsoLike.name){
      DebugLog.instance.d('Calling youMayAlsoLike API with tagName');
      scheduleMicrotask(() async => getFilterData(tagName: DealsTagName.youMayAlsoLike.value));
      scheduleMicrotask(() async => callHomeDeals(tagName: DealsTagName.youMayAlsoLike, filterData: getSelectedFiltersAsFilterData()));
    } else if (type == DealsTagName.related.name){
      DebugLog.instance.d('Calling related products API with tagName');
      scheduleMicrotask(() async => getFilterData(productSku: state.productSku, tagName: DealsTagName.related.value));
      scheduleMicrotask(() async => callRelatedProducts(filterData: getSelectedFiltersAsFilterData()));
    } else if (type == DealsTagName.trending.name){
      DebugLog.instance.d('Calling trending products API with tagName');
      scheduleMicrotask(() async => getFilterData(tagName: DealsTagName.trending.value));
      scheduleMicrotask(() async => callTrendingProducts(filterData: getSelectedFiltersAsFilterData()));
    } else{
      DebugLog.instance.d('Calling regular product listing API');
      scheduleMicrotask(() async => getFilterData());
      unawaited(getProductListing(filterData: getSelectedFiltersAsFilterData()));
    }
  }


  /// Initialize scroll listener for infinite scroll pagination
  void _initializeScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  /// Handle scroll events for infinite scroll pagination
  void _onScroll() {
    if (state.scrollController.position.pixels >=
        state.scrollController.position.maxScrollExtent - 1500) {
      // Load more when user is 200 pixels from the bottom, but not during sorting/loading
      if (state.hasMore && !state.isLoadingMore && state.status != BaseStateStatus.loading) {
        unawaited(loadMoreProducts());
      }
    }
  }

  /// Stores selected filters in the state
  void storeSelectedFilters(List<Map<String, dynamic>> filters) {
    emit(state.copyWith(selectedFilters: filters));
  }

  /// Clears stored selected filters
  void clearSelectedFilters() {
    final ProductListingWithFilterState newState = state.copyWith(selectedFilters: <Map<String, dynamic>>[]);
    emit(newState);
  }



  /// Converts selected filters to FilterData format for API calls
  List<FilterData>? getSelectedFiltersAsFilterData() {
    if (state.selectedFilters == null || state.selectedFilters!.isEmpty) {
      return null;
    }

    return state.selectedFilters!.map((Map<String, dynamic> filter) {
      final String code = filter['code'] as String;

      if (code == 'price') {
        return FilterData(
          code: code,
          minPrice: (filter['min_price'] as num?)?.toDouble(),
          maxPrice: (filter['max_price'] as num?)?.toDouble(),
        );
      } else {
        // For brand and category filters
        final List<dynamic>? optionsData = filter['options'] as List<dynamic>?;
        final List<FilterOption>? options = optionsData?.map((dynamic option) {
          final Map<String, dynamic> optionMap = option as Map<String, dynamic>;
          return FilterOption(
            id: optionMap['id'] as String?,
            count: optionMap['count'] as int?,
          );
        }).toList();

        return FilterData(
          code: code,
          options: options,
        );
      }
    }).toList();
  }


  /// Fetches filter data for the product listing
  Future<void> getFilterData({
    String? tagName,
    String? productSku,
  }) async {
    try {
      DebugLog.instance.i('ProductListingWithFilterCubit: ===== STARTING FILTER DATA FETCH =====');

      // Get services
      final UserProfileService userProfileService = getIt<UserProfileService>();
      final LanguageService languageService = getIt<LanguageService>();
      final CountryService countryService = getIt<CountryService>();
      final MainConfig mainConfig = getIt<MainConfig>();

      // Create request model
      final GetFilterDataRequestModel request = GetFilterDataRequestModel(
        customerToken: userProfileService.customerToken,
        languageId: int.tryParse(languageService.languageId) ?? 1,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        currency: languageService.defaultCurrency,
        storeId: countryService.store ?? 0,
        typeId: state.typeId,
        type: state.type,
        tagName: tagName,
        productSku: productSku
      );


      // Make API call
      final ResponseHandler<BaseResponse<GetFilterData>> response = await _repository.getFilterData(request: request);

      if (response.isSuccess()|| response.getSuccessInstance()?.response.data!=null) {
        final BaseResponse<GetFilterData>? filterDataResponse = response.getSuccessInstance()?.response;
        if (filterDataResponse?.data != null) {
            emit(state.copyWith(
              filterData: filterDataResponse?.data,
            ));
        } else {
          emit(state.copyWith(
            errorMessage: '"',
          ));
        }
      } else {
        final String error = response.getFailureInstance()?.error?.errorMessage ?? '';
        emit(state.copyWith(
          errorMessage: error,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        errorMessage: 'Exception: ${e.toString()}',
      ));
    }
    

  }

  /// Fetches product listing data with filters
  Future<void> getProductListing({
    int? typeId,
    String? type,
    String? query = '',
    String? sorting,
    List<FilterData>? filterData,
    int? limit,
    int? offset,
  }) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        status: BaseStateStatus.loading,
      ));

      // Use passed parameters or fall back to state parameters
      final int finalTypeId = typeId ?? state.typeId ?? 0;
      final String finalType = type ?? state.type ?? 'category';
      final String finalSorting = sorting ?? state.selectedSortOption?.id ?? '';
      final int finalLimit = limit ?? AppConstant.limitProduct; // Default limit
      final int finalOffset = offset ?? 0; // Default offset
      final UserProfileService userProfileService = getIt<UserProfileService>();

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
        sorting: finalSorting,
        filterData: filterData,
        limit: finalLimit,
        offset: finalOffset,
        quoteId:   userProfileService.quoteId ?? 0,
      );

      // Make API call
      final ResponseHandler<BaseResponse<List<ProductListingResponse>>> response = await _repository.getProductListing(request: request);

      if (response.isSuccess()) {
        final BaseResponse<List<ProductListingResponse>>? productListingResponse = response.getSuccessInstance()?.response;

        if (productListingResponse != null) {
          final List<ProductListingResponse> newProducts = productListingResponse.data ?? <ProductListingResponse>[];
          final int apiTotalCount = productListingResponse.totalCount ?? 0;
          final int currentOffset = offset ?? 0;
          
          // Determine if this is a fresh load or pagination
          final bool isFirstPage = currentOffset == 0;
          final List<ProductListingResponse> updatedProductList = isFirstPage 
              ? newProducts 
              : <ProductListingResponse>[...(state.productList ?? <ProductListingResponse>[]), ...newProducts];
          
          // Calculate pagination info
          final bool hasMoreData = updatedProductList.length < apiTotalCount;
          
          emit(state.copyWith(
            productListingResponse: productListingResponse,
            productList: updatedProductList,
            isLoading: false,
            isLoadingMore: false,
            status: BaseStateStatus.success,
            totalCount: apiTotalCount,
            currentPage: isFirstPage ? 1 : state.currentPage + 1,
            hasMore: hasMoreData,
          ));
          
          // Store products in global wishlist manager
          final GlobalWishlistManager globalWishlistManager = getIt<GlobalWishlistManager>()
          ..storeProductsFromAPI(updatedProductList);
          DebugLog.instance.e(globalWishlistManager.wishlistCount.toString());
          DebugLog.instance.e(productListingResponse.toJson((List<ProductListingResponse> data) => data.map((ProductListingResponse e) => e.toJson()).toList()).toString());

        } else {
          emit(state.copyWith(
            isLoading: false,
            status: BaseStateStatus.failure,
            errorMessage: '',
          ));
        }
      } else {
        final String error = response.getFailureInstance()?.error?.errorMessage ??
            '';
        emit(state.copyWith(
          isLoading: false,
          status: BaseStateStatus.failure,
          errorMessage: error,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        isLoading: false,
        status: BaseStateStatus.failure,
        errorMessage: e.toString(),
      ));

    }
    
  }




  /// Handles tab selection for child categories
  void onTabSelected(int tabIndex) {
    if (state.tabLabels != null && tabIndex < state.tabLabels!.length) {
      final dynamic selectedCategory = state.tabLabels![tabIndex];
      String categoryName = '';
      String categoryId = '';
      
      if (selectedCategory is CategoryResponseModel) {
        categoryName = selectedCategory.categoryName.toString();
        categoryId = selectedCategory.categoryId?.toString() ?? '';
        DebugLog.instance.i('ProductListingWithFilterCubit: Tab selected - CategoryResponseModel:');
        DebugLog.instance.i('  - Category Name: $categoryName');
        DebugLog.instance.i('  - Category ID: $categoryId');
        DebugLog.instance.i('  - Tab Index: $tabIndex');
        DebugLog.instance.i('  - Has Children: ${selectedCategory.hasChildren}');
        DebugLog.instance.i('  - Child Categories Count: ${selectedCategory.childCategories.length}');
      } else if (selectedCategory is ChildCategoryModel) {
        categoryName = selectedCategory.categoryName.toString();
        categoryId = selectedCategory.categoryId?.toString() ?? '';
        DebugLog.instance.i('ProductListingWithFilterCubit: Tab selected - ChildCategoryModel:');
        DebugLog.instance.i('  - Category Name: $categoryName');
        DebugLog.instance.i('  - Category ID: $categoryId');
        DebugLog.instance.i('  - Tab Index: $tabIndex');
        DebugLog.instance.i('  - URL: ${selectedCategory.url}');
        DebugLog.instance.i('  - Request Path: ${selectedCategory.requestPath}');
      }
      DebugLog.instance.i('ProductListingWithFilterCubit: Tab selected: $categoryName at index: $tabIndex');
      
      // Update selected tab index
      emit(state.copyWith(selectedSegmentIndex: tabIndex));
      
      // Handle tab selection logic
      if (tabIndex == 0) {
        // "All" tab selected - show all products without category filtering
        DebugLog.instance.i('ProductListingWithFilterCubit: "All" tab selected - showing all products');
        // Refresh products without category filter (use original typeId)
        unawaited(_refreshProductsWithCategory(null));
      } else {
        // Specific category selected - filter products by category
        DebugLog.instance.i('ProductListingWithFilterCubit: Category "$categoryName" selected - filtering products with typeId: $categoryId');
        // Filter products by the selected category typeId
        unawaited(_refreshProductsWithCategory(categoryId));
      }
    }
  }

  /// Refresh products with category filtering
  Future<void> _refreshProductsWithCategory(String? categoryTypeId) async {
    try {
      // Clear current product list and reset pagination
      emit(state.copyWith(
        productList: <ProductListingResponse>[],
        currentPage: 1,
        hasMore: true,
        isLoadingMore: false,
        status: BaseStateStatus.loading,
      ));

      // Check if we're in deals mode and call appropriate API
      if (state.type == DealsTagName.bestDeals.name) {
        await callHomeDeals(
          tagName: DealsTagName.bestDeals,
          sorting: state.selectedSortOption?.id,
          offset: 0,
          filterData: getSelectedFiltersAsFilterData(),
        );
      } else if (state.type == DealsTagName.youMayAlsoLike.name) {
        await callHomeDeals(
          tagName: DealsTagName.youMayAlsoLike,
          sorting: state.selectedSortOption?.id,
          offset: 0,
          filterData: getSelectedFiltersAsFilterData(),
        );
      } else if (state.type == DealsTagName.related.name) {
        await callRelatedProducts(
          offset: 0,
          filterData: getSelectedFiltersAsFilterData(),
        );
      } else if (state.type == DealsTagName.trending.name) {
        await callTrendingProducts(
          offset: 0,
          filterData: getSelectedFiltersAsFilterData(),
        );
      } else {
        // Regular product listing with category filtering
        await getProductListing(
          typeId: categoryTypeId != null ? int.tryParse(categoryTypeId) : state.typeId,
          offset: 0,
          filterData: getSelectedFiltersAsFilterData(),
        );
      }
    } on Exception catch (e) {
      DebugLog.instance.e('ProductListingWithFilterCubit: Error refreshing products with category: $e');
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        errorMessage: '',
      ));
    }
  }

  /// Handles sort option selection
  Future<void> onSortOptionSelected(SortOptionModel sortOption) async {
    DebugLog.instance.i('ProductListingWithFilterCubit: Sort option selected: ${sortOption.id} - ${sortOption.label}');

    // Set loading state to show shimmer during sorting
    emit(state.copyWith(
      selectedSortOption: sortOption,
      status: BaseStateStatus.loading,
      isLoading: true,
    ));

    try {
      // Get the currently selected category ID based on the selected tab
      String? currentCategoryId;
      if (state.selectedSegmentIndex > 0 && 
          state.tabLabels != null && 
          state.selectedSegmentIndex < state.tabLabels!.length) {
        final dynamic selectedCategory = state.tabLabels![state.selectedSegmentIndex];
        
        if (selectedCategory is CategoryResponseModel) {
          currentCategoryId = selectedCategory.categoryId?.toString();
        } else if (selectedCategory is ChildCategoryModel) {
          currentCategoryId = selectedCategory.categoryId?.toString();
        }
        
        DebugLog.instance.i('ProductListingWithFilterCubit: Sort with selected category ID: $currentCategoryId');
      } else {
        DebugLog.instance.i('ProductListingWithFilterCubit: Sort with original typeId (All tab selected)');
      }

      // Check if we're in deals mode and call appropriate API
      if (state.type == DealsTagName.bestDeals.name) {
        await callHomeDeals(
          tagName: DealsTagName.bestDeals,
          sorting: sortOption.id,
          offset: 0,
          filterData: getSelectedFiltersAsFilterData(),
        );
      } else if (state.type == DealsTagName.youMayAlsoLike.name) {
        await callHomeDeals(
          tagName: DealsTagName.youMayAlsoLike,
          sorting: sortOption.id,
          offset: 0,
          filterData: getSelectedFiltersAsFilterData(),
        );
      } else if (state.type == DealsTagName.related.name) {
        await callRelatedProducts(offset: 0, filterData: getSelectedFiltersAsFilterData());
      } else if (state.type == DealsTagName.trending.name) {
        await callTrendingProducts(offset: 0, filterData: getSelectedFiltersAsFilterData());
      } else {
        // Regular product listing - use current category ID if available, otherwise use original typeId
        final int? typeIdToUse = currentCategoryId != null 
            ? int.tryParse(currentCategoryId) 
            : state.typeId;
        
        await getProductListing(
          typeId: typeIdToUse,
          sorting: sortOption.id, 
          offset: 0, 
          filterData: getSelectedFiltersAsFilterData()
        );
      }
    } on Exception catch (e) {
      DebugLog.instance.e('ProductListingWithFilterCubit: Error during sorting: $e');
      // Reset to success state if there's an error
      emit(state.copyWith(
        status: BaseStateStatus.success,
        isLoading: false,
        errorMessage: 'Failed to sort products',
      ));
    }
  }

  /// Loads more products for pagination
  Future<void> loadMoreProducts() async {
    if (!state.hasMore || state.isLoadingMore) {
      return;
    }

    DebugLog.instance.i('ProductListingWithFilterCubit: Loading more products - Page: ${state.currentPage + 1}');
    
    // Set loading more state
    emit(state.copyWith(isLoadingMore: true));
    
    // Calculate next offset based on current page
    final int nextOffset = state.currentPage * AppConstant.limitProduct;

    // Get the currently selected category ID based on the selected tab
    String? currentCategoryId;
    if (state.selectedSegmentIndex > 0 && 
        state.tabLabels != null && 
        state.selectedSegmentIndex < state.tabLabels!.length) {
      final dynamic selectedCategory = state.tabLabels![state.selectedSegmentIndex];
      
      if (selectedCategory is CategoryResponseModel) {
        currentCategoryId = selectedCategory.categoryId?.toString();
      } else if (selectedCategory is ChildCategoryModel) {
        currentCategoryId = selectedCategory.categoryId?.toString();
      }
      
      DebugLog.instance.i('ProductListingWithFilterCubit: Load more with selected category ID: $currentCategoryId');
    } else {
      DebugLog.instance.i('ProductListingWithFilterCubit: Load more with original typeId (All tab selected)');
    }

    // Check if we're in deals mode and call appropriate API
    if (state.type == DealsTagName.bestDeals.name) {
      await callHomeDeals(
        tagName: DealsTagName.bestDeals,
        sorting: state.selectedSortOption?.id,
        offset: nextOffset,
        limit: AppConstant.limitProduct,
        filterData: getSelectedFiltersAsFilterData(),
      );
    } else if (state.type == DealsTagName.youMayAlsoLike.name) {
      await callHomeDeals(
        tagName: DealsTagName.youMayAlsoLike,
        sorting: state.selectedSortOption?.id,
        offset: nextOffset,
        limit: AppConstant.limitProduct,
        filterData: getSelectedFiltersAsFilterData(),
      );
    } else if (state.type == DealsTagName.related.name) {
      await callRelatedProducts(
        offset: nextOffset,
        limit: AppConstant.limitProduct,
        filterData: getSelectedFiltersAsFilterData(),
      );
    } else if (state.type == DealsTagName.trending.name) {
      await callTrendingProducts(
        offset: nextOffset,
        limit: AppConstant.limitProduct,
        filterData: getSelectedFiltersAsFilterData(),
      );
    } else {
      // Regular product listing - use current category ID if available, otherwise use original typeId
      final int? typeIdToUse = currentCategoryId != null 
          ? int.tryParse(currentCategoryId) 
          : state.typeId;
      
      await getProductListing(
        typeId: typeIdToUse,
        offset: nextOffset,
        filterData: getSelectedFiltersAsFilterData(),
        limit: AppConstant.limitProduct,
      );
    }
  }

  /// Refreshes the product list (resets pagination)
  Future<void> refreshProducts() async {
    DebugLog.instance.i('ProductListingWithFilterCubit: Refreshing products');
    
    // Get the currently selected category ID based on the selected tab
    String? currentCategoryId;
    if (state.selectedSegmentIndex > 0 && 
        state.tabLabels != null && 
        state.selectedSegmentIndex < state.tabLabels!.length) {
      final dynamic selectedCategory = state.tabLabels![state.selectedSegmentIndex];
      
      if (selectedCategory is CategoryResponseModel) {
        currentCategoryId = selectedCategory.categoryId?.toString();
      } else if (selectedCategory is ChildCategoryModel) {
        currentCategoryId = selectedCategory.categoryId?.toString();
      }
      
      DebugLog.instance.i('ProductListingWithFilterCubit: Refresh with selected category ID: $currentCategoryId');
    } else {
      DebugLog.instance.i('ProductListingWithFilterCubit: Refresh with original typeId (All tab selected)');
    }
    
    // Check if we're in deals mode and call appropriate API
    if (state.type == DealsTagName.bestDeals.name) {
      await callHomeDeals(
        tagName: DealsTagName.bestDeals,
        sorting: state.selectedSortOption?.id,
        offset: 0,
        filterData: getSelectedFiltersAsFilterData(),
      );
    } else if (state.type == DealsTagName.youMayAlsoLike.name) {
      await callHomeDeals(
        tagName: DealsTagName.youMayAlsoLike,
        sorting: state.selectedSortOption?.id,
        offset: 0,
        filterData: getSelectedFiltersAsFilterData(),
      );
    } else if (state.type == DealsTagName.related.name) {
      await callRelatedProducts(offset: 0, filterData: getSelectedFiltersAsFilterData());
    } else if (state.type == DealsTagName.trending.name) {
      await callTrendingProducts(offset: 0, filterData: getSelectedFiltersAsFilterData());
    } else {
      // Regular product listing - use current category ID if available, otherwise use original typeId
      final int? typeIdToUse = currentCategoryId != null 
          ? int.tryParse(currentCategoryId) 
          : state.typeId;
      
      await getProductListing(
        typeId: typeIdToUse,
        offset: 0, 
        filterData: getSelectedFiltersAsFilterData()
      );
    }
  }

  /// Handle like/dislike functionality for wishlist items
  /// Now uses GlobalWishlistCubit for consistent state management
  Future<void> handleWishlistLikeDislike({
    required String sku,
    required int productIndex,
    required bool isCurrentlyFavorite,
  }) async {
    try {
      // Get product details for global wishlist
      final List<ProductListingResponse> currentProducts = state.productList ?? <ProductListingResponse>[];
      ProductListingResponse? product;
      if (productIndex >= 0 && productIndex < currentProducts.length) {
        product = currentProducts[productIndex];
      }
      // Use global wishlist manager for state management
      final GlobalWishlistManager globalWishlistManager = getIt<GlobalWishlistManager>();

      if (isCurrentlyFavorite) {
        // Remove from wishlist (dislike)
        final ResponseHandler<BaseResponse<void>> response = await removeFromWishlistAPI(
          removeWishlistParams: createRemoveWishlistRequest(sku),
        );

        if (response.isSuccess()) {
          final BaseResponse<void>? responseData = response.getSuccessInstance()?.response;

          if (responseData?.success ?? false) {
            // Update global wishlist state
            globalWishlistManager.toggleWishlist(sku, false);
            DebugLog.instance.d('🔄 PLP: Removed $sku from wishlist');

            // Update the product's favorite status in the list
            _updateProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: false,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
            );
          } else {
            _updateProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: isCurrentlyFavorite, // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
            );
          }
        } else if (response.isFailure()) {
          _updateProductWishlistStatus(
            productIndex: productIndex,
            isFavorite: isCurrentlyFavorite, // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ?? '',
          );
        }
      } else {
        // Add to wishlist (like)
        final ResponseHandler<AddWishlistModel> response = await addToWishlistAPI(
          wishListParams: createAddWishlistRequest(sku),
        );

        if (response.isSuccess()) {
          final AddWishlistModel? responseData = response.getSuccessInstance()?.response;

          if (responseData?.success ?? false) {
            // Update global wishlist state
            globalWishlistManager.toggleWishlist(sku, true);
            DebugLog.instance.d('🔄 PLP: Added $sku to wishlist');

            // Update the product's favorite status in the list
            _updateProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: true,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
            );
          } else {
            _updateProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: isCurrentlyFavorite, // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
            );
          }
        } else if (response.isFailure()) {
          _updateProductWishlistStatus(
            productIndex: productIndex,
            isFavorite: isCurrentlyFavorite, // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ?? '',
          );
        }
      }
    } on Exception {
      _updateProductWishlistStatus(
        productIndex: productIndex,
        isFavorite: isCurrentlyFavorite, // Keep current status
        status: BaseStateStatus.failure,
        message: 'An error occurred while updating wishlist',
      );
    }
  }

  /// Update product wishlist status in product list
  void _updateProductWishlistStatus({
    required int productIndex,
    required bool isFavorite,
    required BaseStateStatus status,
    required String message,
  }) {
    List<ProductListingResponse> currentProductList = state.productList ?? <ProductListingResponse>[];

    // Check if product index is valid
    if (productIndex < 0 || productIndex >= currentProductList.length) {
      return;
    }

    List<ProductListingResponse> updatedProductList = List<ProductListingResponse>.from(currentProductList);
    ProductListingResponse product = updatedProductList[productIndex];

    // Update the product's favorite status
    updatedProductList[productIndex] = product.copyWith(
      isFavorite: isFavorite,
    );

    // Emit the updated state
    emit(
      state.copyWith(
        status: status,
        productList: updatedProductList,
      ),
    );

    // Show snackbar message
    if (MainConfig.context.mounted) {
      displaySnackBar(message, MainConfig.context);
    }
  }

  /// Handle cart operations for product listing
  /// This method handles add, increase, decrease, and remove cart operations
  /// Can be called for main product or specific variant
  Future<void> handleProductCartOperation({
    required int productIndex,
    required CartOperation operation,
    int? variantIndex, // Optional: specify which variant to use
  }) async {
    final List<ProductListingResponse> currentProducts = state.productList ?? <ProductListingResponse>[];

    // Use the common mixin method
    await super.handleCartOperation(
      productIndex: productIndex,
      products: currentProducts,
      operation: operation,
      variantIndex: variantIndex,
      updateProductCartQuantity: (int productIndex, int cartQuantity, BaseStateStatus status, String message, int? variantIndex, int? apiCartCount) async {
        await _updateProductCartQuantity(
          productIndex: productIndex,
          cartQuantity: cartQuantity,
          status: status,
          message: message,
          variantIndex: variantIndex,
          apiCartCount: apiCartCount,
        );
      },
      addToCartApi: addToCartListApi,
      removeFromCartApi: removeToCartListApi,
        updateToCartApi: updateToCartListApi
    );
  }



  /// Update product cart quantity in product list
  Future<void> _updateProductCartQuantity({
    required int productIndex,
    required int cartQuantity,
    required BaseStateStatus status,
    required String message,
    int? variantIndex, // Optional: specify which variant to update
    int? apiCartCount, // Cart count from API response
  }) async {
    // Update cart count from API response if available
    if (status == BaseStateStatus.success && apiCartCount != null) {
      // Use the cart count from API response (this is the correct approach)
      getIt<CartCountCubit>().updateCount(apiCartCount);
      DebugLog.instance.i('Updated cart count from API in product listing: $apiCartCount');
    }
    List<ProductListingResponse> currentProductList = state.productList ?? <ProductListingResponse>[];

    // Check if product index is valid
    if (productIndex < 0 || productIndex >= currentProductList.length) {
      return;
    }

    List<ProductListingResponse> updatedProductList = List<ProductListingResponse>.from(currentProductList);
    ProductListingResponse product = updatedProductList[productIndex];

    ProductListingResponse updatedProduct;
    
    if (variantIndex != null && product.productVariant != null && variantIndex < product.productVariant!.length) {
      // Update specific variant cart quantity
      final List<ProductVariantDukkan> updatedVariants = List<ProductVariantDukkan>.from(product.productVariant!);
      updatedVariants[variantIndex] = updatedVariants[variantIndex].copyWith(
        cartQuantity: cartQuantity,
      );
      
      // Update the product with updated variants
      updatedProduct = product.copyWith(
        productVariant: updatedVariants,
      );
    } else {
      // Update main product cart quantity
      updatedProduct = product.copyWith(
        cartQuantity: cartQuantity,
        isCart: cartQuantity > 0,
      );
    }

    updatedProductList[productIndex] = updatedProduct;

    // Emit the updated state
    emit(
      state.copyWith(
        msg: message,
        errorMessage: message,
        status: status,
        productList: updatedProductList,
      ),
    );


  }

  /// Helper method to add "All" tab as the first tab
  static List<dynamic> _addAllTabIfEmpty(List<dynamic>? tabLabels) {
    final List<dynamic> allTabs = <dynamic>[];
    DebugLog.instance.i('ProductListingWithFilterCubit: Processing tabLabels - Original count: ${tabLabels?.length ?? 0}');
    // Check if "All" tab already exists in the provided tabs
    bool hasAllTab = false;
    if (tabLabels != null && tabLabels.isNotEmpty) {
      for (final dynamic tab in tabLabels) {
        final String tabName = tab is CategoryResponseModel 
            ? tab.categoryName.toString() 
            : tab is ChildCategoryModel 
                ? tab.categoryName.toString() 
                : '';
        
        // Check for both English and Arabic "All" text
        // #TODO this is tempory when we remove backend the remove it
        if (tabName == AppConstant.all || tabName == 'الكل') {
          hasAllTab = true;
          DebugLog.instance.i('ProductListingWithFilterCubit: Found existing "All" tab: $tabName');
          break;
        }
      }
    }
    
    // Only add "All" tab if it doesn't already exist
    if (!hasAllTab) {
      // Use localized "All" text based on current language
      final String allText = getLocalizedAllText();
      allTabs.add(CategoryResponseModel(categoryName: allText));
    } else {
    }
    
    // Add existing tabs if they exist
    if (tabLabels != null && tabLabels.isNotEmpty) {
      allTabs.addAll(tabLabels);
    }
    
    return allTabs;
  }

  @override
  ProductListingWithFilterState getResetErrorState() =>
      state.copyWith(
        status: BaseStateStatus.initial,
        errorMessage: '',
      );

  @override
  void resetError() {
    emit(getResetErrorState());
  }

  @override
  ProductListingWithFilterState getResetRedirectionState() => state.copyWith();

  @override
  Future<void> close() async {
    await _globalWishlistSubscription?.cancel();
    state.scrollController.dispose();
    await super.close();
  }

  /// api call for the  Deals
  Future<void> callHomeDeals({
    required DealsTagName tagName,
    String? sorting,
    int? limit,
    int? offset,
    List<FilterData>? filterData,
  }) async {
    emit(state.copyWith(status: BaseStateStatus.loading));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final LanguageService languageService = getIt<LanguageService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Use passed parameters or fall back to defaults
    final String finalSorting = sorting ?? state.selectedSortOption?.id ?? '';
    final int finalLimit = limit ?? AppConstant.limitProduct;
    final int finalOffset = offset ?? 0;

    // Create category request model
    final DealsRequestModel dealsRequest = DealsRequestModel(
        languageId: int.tryParse(languageService.languageId) ?? 1,
        quoteId: userProfileService.quoteId ?? 0,
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        currency: languageService.defaultCurrency,
        storeId: countryService.store,
        tagName: tagName.value,
        screen: DealsScreen.home.value,
        sorting: finalSorting,
        limit: finalLimit,
        offset: finalOffset,
        filterData: filterData);
    DebugLog.instance.i('DealsRequestModel created: ${dealsRequest.toJson()}');

    // Call the repository to get deals list
    final ResponseHandler<BaseResponse<List<DealsResponseModel>>> response =
    await _repository.getHomeDealsList(dealsRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<DealsResponseModel>>>?
      successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<DealsResponseModel>> saveResponse =
            successInstance.response;

        // Check if the save operation was successful
        if (saveResponse.success) {
          // Handle empty data case - check if data exists and is not empty
          final List<ProductListingResponse> newProducts;
          if (saveResponse.data != null && saveResponse.data!.isNotEmpty) {
            newProducts = saveResponse.data!.first.productListModel;
          } else {
            newProducts = <ProductListingResponse>[];
          }

          final int apiTotalCount = saveResponse.totalCount ?? 0;
          final int currentOffset = offset ?? 0;
          
          // Determine if this is a fresh load or pagination
          final bool isFirstPage = currentOffset == 0;
          final List<ProductListingResponse> updatedProductList = isFirstPage 
              ? newProducts 
              : <ProductListingResponse>[...(state.productList ?? <ProductListingResponse>[]), ...newProducts];
          
          // Calculate pagination info
          final bool hasMoreData = updatedProductList.length < apiTotalCount;
          
          emit(state.copyWith(
            status: BaseStateStatus.success,
            isLoading: false,
            isLoadingMore: false,
            productListingResponse: BaseResponse<List<ProductListingResponse>>(
              data: updatedProductList,
              success: saveResponse.success,
              statusCode: saveResponse.statusCode,
              message: saveResponse.message,
              totalCount: apiTotalCount,
            ),
            productList: updatedProductList,
            totalCount: apiTotalCount,
            currentPage: isFirstPage ? 1 : state.currentPage + 1,
            hasMore: hasMoreData,
          ));

          // Debug log the category data
          if (saveResponse.data != null && saveResponse.data!.isNotEmpty) {
            for (int i = 0; i < saveResponse.data!.length; i++) {
              final DealsResponseModel deals = saveResponse.data![i];
              // Log child categories if they exist
              if (deals.productListModel.isNotEmpty) {
                for (int j = 0; j < deals.productListModel.length; j++) {
                  final ProductListingResponse productListModel =
                  deals.productListModel[j];

                  if (productListModel.productVariant?.isNotEmpty ??
                      false) {
                    for (int k = 0;
                    k < productListModel.productVariant!.length;
                    k++) {
                    }
                  }
                }
              }
            }
          }
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            errorMessage: saveResponse.error,
          ));
        }
      } else {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          errorMessage: response
              .getFailureInstance()
              ?.error
              ?.errorMessage ?? '',
        ));
      }
      
    }
  }

  /// API call for related products
  Future<void> callRelatedProducts({
    int? limit,
    int? offset,
    List<FilterData>? filterData,
  }) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading, isLoading: true));

      final int finalLimit = limit ?? AppConstant.limitProduct;
      final int finalOffset = offset ?? 0;

      DebugLog.instance.d('ProductListingWithFilterCubit: Calling related products API with SKU: ${state.productSku}');

      if (state.productSku == null || state.productSku!.isEmpty) {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          errorMessage: 'Product SKU is required for related products',
          isLoading: false,
        ));
        return;
      }

      final ResponseHandler<BaseResponse<List<ProductListingResponse>>> response =
          await _repository.getRelatedProductsWithFilters(
        state.productSku!,
        limit: finalLimit,
        offset: finalOffset,
        sorting: state.selectedSortOption?.id,
        filterData: filterData,
      );

      if (response.isSuccess()) {
        final BaseResponse<List<ProductListingResponse>>? relatedProductsResponse = response.getSuccessInstance()?.response;

        if (relatedProductsResponse != null) {
          final List<ProductListingResponse> newProducts = relatedProductsResponse.data ?? <ProductListingResponse>[];
          final int apiTotalCount = relatedProductsResponse.totalCount ?? 0;
          final int currentOffset = offset ?? 0;

          // Determine if this is a fresh load or pagination
          final bool isFirstPage = currentOffset == 0;
          final List<ProductListingResponse> updatedProductList = isFirstPage
              ? newProducts
              : <ProductListingResponse>[...(state.productList ?? <ProductListingResponse>[]), ...newProducts];

          // Calculate pagination info
          final bool hasMoreData = updatedProductList.length < apiTotalCount;

          emit(state.copyWith(
            productListingResponse: relatedProductsResponse,
            productList: updatedProductList,
            isLoading: false,
            isLoadingMore: false,
            status: BaseStateStatus.success,
            totalCount: apiTotalCount,
            currentPage: isFirstPage ? 1 : state.currentPage + 1,
            hasMore: hasMoreData,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            status: BaseStateStatus.failure,
            errorMessage: '',
          ));
        }
      } else {
        final String error = response.getFailureInstance()?.error?.errorMessage ?? '';
        emit(state.copyWith(
          isLoading: false,
          status: BaseStateStatus.failure,
          errorMessage: error,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        isLoading: false,
        status: BaseStateStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// API call for trending products
  Future<void> callTrendingProducts({
    int? limit,
    int? offset,
    List<FilterData>? filterData,
  }) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading, isLoading: true));

      final int finalLimit = limit ?? AppConstant.limitProduct;
      final int finalOffset = offset ?? 0;

      DebugLog.instance.d('ProductListingWithFilterCubit: Calling trending products API');

      final ResponseHandler<BaseResponse<List<ProductListingResponse>>> response =
          await _repository.getTrendingProductsWithFilters(
        limit: finalLimit,
        offset: finalOffset,
        sorting: state.selectedSortOption?.id,
        filterData: filterData,
      );

      if (response.isSuccess()) {
        final BaseResponse<List<ProductListingResponse>>? trendingProductsResponse = response.getSuccessInstance()?.response;

        if (trendingProductsResponse != null) {
          final List<ProductListingResponse> newProducts = trendingProductsResponse.data ?? <ProductListingResponse>[];
          final int apiTotalCount = trendingProductsResponse.totalCount ?? 0;
          final int currentOffset = offset ?? 0;

          // Determine if this is a fresh load or pagination
          final bool isFirstPage = currentOffset == 0;
          final List<ProductListingResponse> updatedProductList = isFirstPage
              ? newProducts
              : <ProductListingResponse>[...(state.productList ?? <ProductListingResponse>[]), ...newProducts];

          // Calculate pagination info
          final bool hasMoreData = updatedProductList.length < apiTotalCount;

          emit(state.copyWith(
            productListingResponse: trendingProductsResponse,
            productList: updatedProductList,
            isLoading: false,
            isLoadingMore: false,
            status: BaseStateStatus.success,
            totalCount: apiTotalCount,
            currentPage: isFirstPage ? 1 : state.currentPage + 1,
            hasMore: hasMoreData,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            status: BaseStateStatus.failure,
            errorMessage: '',
          ));
        }
      } else {
        final String error = response.getFailureInstance()?.error?.errorMessage ?? '';
        emit(state.copyWith(
          isLoading: false,
          status: BaseStateStatus.failure,
          errorMessage: error,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        isLoading: false,
        status: BaseStateStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }



  /// Sync PLP with global wishlist
  void _syncWithGlobalWishlist() {
    DebugLog.instance.d('🔄 PLP: Syncing with global wishlist');

    try {
      final GlobalWishlistManager globalWishlistManager = getIt<GlobalWishlistManager>();
      final Map<String, bool> globalWishlist = globalWishlistManager.state.wishlistMap;

      DebugLog.instance.d('🔄 PLP: Global wishlist: $globalWishlist');

      final List<ProductListingResponse> currentProducts = state.productList ?? <ProductListingResponse>[];
      if (currentProducts.isEmpty) return;

      final List<ProductListingResponse> updatedProducts = currentProducts.map((ProductListingResponse product) {
        if (product.sku == null || product.sku!.isEmpty) {
          return product;
        }

        final bool isInGlobalWishlist = globalWishlist[product.sku] ?? false;

        if (product.isFavorite != isInGlobalWishlist) {
          DebugLog.instance.d('🔄 PLP: Update ${product.sku} from ${product.isFavorite} to $isInGlobalWishlist');
          return product.copyWith(isFavorite: isInGlobalWishlist);
        }

        return product;
      }).toList();

      emit(state.copyWith(productList: updatedProducts));
      DebugLog.instance.d('🔄 PLP: Successfully synced with global wishlist');
    }  on Exception catch (e) {
      DebugLog.instance.e('🔄 PLP: Error syncing with global wishlist: $e');
    }
  }

  /// Sync PLP with global cart
  void _syncWithGlobalCart() {
    DebugLog.instance.d('🔄 PLP: Syncing with global cart');

    try {
      final GlobalWishlistManager globalWishlistManager = getIt<GlobalWishlistManager>();
      final Map<String, int> globalCart = globalWishlistManager.state.cartMap;

      DebugLog.instance.d('🔄 PLP: Global cart: $globalCart');

      final List<ProductListingResponse> currentProducts = state.productList ?? <ProductListingResponse>[];
      if (currentProducts.isEmpty) return;

      final List<ProductListingResponse> updatedProducts = currentProducts.map((ProductListingResponse product) {
        return _syncProductWithGlobalCart(product, globalCart);
      }).toList();

      emit(state.copyWith(productList: updatedProducts));
      DebugLog.instance.d('🔄 PLP: Successfully synced with global cart');
    }  on Exception catch (e) {
      DebugLog.instance.e('🔄 PLP: Error syncing with global cart: $e');
    }
  }

  /// Helper method to sync individual product with global cart
  ProductListingResponse _syncProductWithGlobalCart(ProductListingResponse product, Map<String, int> globalCart) {
    if (product.sku == null || product.sku!.isEmpty) {
      return product;
    }

    // Update product variants with global cart quantities (each variant has its own key)
    if (product.productVariant != null && product.productVariant!.isNotEmpty) {
      final List<ProductVariantDukkan> updatedVariants = product.productVariant!.map((ProductVariantDukkan variant) {
        final String? variantEntityId = variant.entityId?.toString();
        final int currentCartQuantity = variant.cartQuantity ?? 0;
        int globalCartQuantity = 0;

        if (variantEntityId != null && variantEntityId.isNotEmpty) {
          final String cartKey = '${product.sku}_$variantEntityId';
          globalCartQuantity = globalCart[cartKey] ?? 0;
        }

        if (currentCartQuantity != globalCartQuantity) {
          DebugLog.instance.d('🔄 PLP: Update variant ${variant.name} cart quantity from $currentCartQuantity to $globalCartQuantity');
          return variant.copyWith(
            cartQuantity: globalCartQuantity,
            isCart: globalCartQuantity > 0,
          );
        }
        return variant;
      }).toList();

      return product.copyWith(productVariant: updatedVariants);
    }

    return product;
  }

}
