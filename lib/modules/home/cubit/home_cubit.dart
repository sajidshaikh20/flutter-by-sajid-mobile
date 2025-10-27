import '../../../utils/exports.dart';
import '../../../utils/refresh_helper.dart';

/// `HomeCubit` is responsible for managing the home screen state,
/// including fetching banners, notices, categories, and products.
/// It also handles wishlist and cart operations using `WishlistCartMixin`.
class HomeCubit extends BaseCubit<HomeState>
    with WishlistCartMixin<HomeState>, CartOperationMixin<HomeState> {
  /// Repository for handling home-related API calls and data.
  final HomeRepository homeRepository;

  /// Repository for handling address-related API calls and data.
  final AddressRepositoryImpl addressRepositoryImpl;

  /// Cubit responsible for managing the cart count state.
  final CartCountCubit countCubit;

  /// Stream subscription for global wishlist manager
  StreamSubscription<GlobalWishlistState>? _globalWishlistSubscription;

  /// Constructor for `HomeCubit`.
  ///
  /// Initializes the cubit with required repositories and dependencies.
  ///
  /// - [wishlistCartRepository]: Repository for managing wishlist and
  /// cart operations.
  /// - [homeRepository]: Repository for fetching home screen-related data.
  /// - [addressRepositoryImpl]: Repository for fetching address data.
  /// - [countCubit]: Cubit for managing cart count updates.
  HomeCubit({
    required WishlistCartRepository wishlistCartRepository,
    required this.homeRepository,
    required this.addressRepositoryImpl,
    required this.countCubit,
  }) : super(HomeState.initial()) {
    // Initialize the mixin's dependency here.
    this.wishlistCartRepository = wishlistCartRepository;
    initData();
    initializeSegmentIndex();

    // Register with refresh helper - only update wishlist state
    RefreshHelper.instance.registerHomeRefreshCallback(() {
      DebugLog.instance
          .d('🔄 HOME: Refresh helper triggered, syncing wishlist state');
      // Force sync when navigating back to home
      forceSyncWishlistOnResume();
    });

    // Listen to global wishlist and cart changes
    scheduleMicrotask(() {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      _globalWishlistSubscription =
          globalWishlistManager.stream.listen((GlobalWishlistState newState) {
        DebugLog.instance
            .d('🔄 HOME: Global state changed, syncing home screen');
        // Always sync with cart changes
        _syncWithGlobalCart();
        // Only sync wishlist if wishlist data actually changed
        if (newState.wishlistMap != globalWishlistManager.state.wishlistMap) {
          _syncWithGlobalWishlist();
        }
      });
    });
  }

  /// Initializes the home screen data by making asynchronous API calls
  /// to fetch banners, notices, categories, products, and addresses.
  ///
  /// Each API call is executed as a microtask to ensure they run
  /// asynchronously without blocking the main thread.
  void initData() {
    // Reset timing variables

    /// Fetches and updates the list of user addresses.
    scheduleMicrotask(() async => _callGetAddressListApi());

    final int? store = getIt<CountryService>().store;

    if (store != null) {
      /// First call cart listing to get quoteId, then chain other API calls
      scheduleMicrotask(() async => _callCartListingApi());

      /// Fetches and updates the home screen banner details.
      scheduleMicrotask(() async => _callHomeBanners());

      /// Fetches and updates the list of home screen categories.
      scheduleMicrotask(() async => _callHomeCategory());

      /// Fetches and updates the list of home screen Brands.
      scheduleMicrotask(() async => _callBrandsListing());
    }

    /// Fetches and updates the loyalty points.
    //# TODO in first phase we don't give loyalty things but in future its required
    // scheduleMicrotask(() async => _callLoyaltyPointsApi());
  }

  /// Initializes the segment index based on the delivery type preference.
  void initializeSegmentIndex() {
    String deliveryType = SharedPref.instance.getDeliveryType();
    int segmentIndex = deliveryType == AppConstant.pickup1 ? 1 : 0;
    emit(state.copyWith(
      selectedSegmentIndex: segmentIndex,
      deliveryType: deliveryType,
    ));
  }

  /// Refreshes the home screen data by reloading all data
  void refreshHomeData() {
    DebugLog.instance.d('🔄 HOME API TIMING: Refreshing home screen data');
    initData();
  }

  /// Simple sync with global wishlist
  void _syncWithGlobalWishlist() {
    DebugLog.instance.d('🔄 HOME: Syncing with global wishlist');

    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, bool> globalWishlist =
          globalWishlistManager.state.wishlistMap;

      DebugLog.instance.d('🔄 HOME: Global wishlist: $globalWishlist');

      List<DealsResponseModel>? updatedDeals;
      List<DealsResponseModel>? updatedYouMayAlsoLike;

      // Update deals section
      if (state.dealsModel?.isNotEmpty ?? false) {
        updatedDeals =
            _updateDealsWithGlobalWishlist(state.dealsModel!, globalWishlist);
      }

      // Update "You may also like" section
      if (state.youMayAlsoLikeDealsModel?.isNotEmpty ?? false) {
        updatedYouMayAlsoLike = _updateDealsWithGlobalWishlist(
            state.youMayAlsoLikeDealsModel!, globalWishlist);
      }

      // Emit updates
      if (updatedDeals != null || updatedYouMayAlsoLike != null) {
        emit(state.copyWith(
          dealsModel: updatedDeals,
          youMayAlsoLikeDealsModel: updatedYouMayAlsoLike,
        ));
        DebugLog.instance
            .d('🔄 HOME: Successfully synced with global wishlist');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('🔄 HOME: Error syncing with global wishlist: $e');
    }
  }

  /// Sync home screen with global cart
  void _syncWithGlobalCart() {
    DebugLog.instance.d('🔄 HOME: Syncing with global cart');

    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, int> globalCart = globalWishlistManager.state.cartMap;

      DebugLog.instance.d('🔄 HOME: Global cart: $globalCart');

      List<DealsResponseModel>? updatedDeals;
      List<DealsResponseModel>? updatedYouMayAlsoLike;

      // Update deals section
      if (state.dealsModel?.isNotEmpty ?? false) {
        updatedDeals =
            _updateDealsWithGlobalCart(state.dealsModel!, globalCart);
      }

      // Update "You may also like" section
      if (state.youMayAlsoLikeDealsModel?.isNotEmpty ?? false) {
        updatedYouMayAlsoLike = _updateDealsWithGlobalCart(
            state.youMayAlsoLikeDealsModel!, globalCart);
      }

      // Emit updates
      if (updatedDeals != null || updatedYouMayAlsoLike != null) {
        emit(state.copyWith(
          dealsModel: updatedDeals,
          youMayAlsoLikeDealsModel: updatedYouMayAlsoLike,
        ));
        DebugLog.instance.d('🔄 HOME: Successfully synced with global cart');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('🔄 HOME: Error syncing with global cart: $e');
    }
  }

  /// Update deals with global wishlist
  List<DealsResponseModel> _updateDealsWithGlobalWishlist(
    List<DealsResponseModel> deals,
    Map<String, bool> globalWishlist,
  ) {
    return deals.map((DealsResponseModel deal) {
      final List<ProductListingResponse> updatedProducts =
          deal.productListModel.map((ProductListingResponse product) {
        if (product.sku == null || product.sku!.isEmpty) {
          return product;
        }

        final bool isInGlobalWishlist = globalWishlist[product.sku] ?? false;

        if (product.isFavorite != isInGlobalWishlist) {
          DebugLog.instance.d(
              '🔄 HOME: Update ${product.sku} from ${product.isFavorite} to $isInGlobalWishlist');
          return product.copyWith(isFavorite: isInGlobalWishlist);
        }

        return product;
      }).toList();

      return DealsResponseModel(
        id: deal.id,
        type: deal.type,
        label: deal.label,
        redirectUrl: deal.redirectUrl,
        productListModel: updatedProducts,
      );
    }).toList();
  }

  /// Update deals with global cart
  List<DealsResponseModel> _updateDealsWithGlobalCart(
    List<DealsResponseModel> deals,
    Map<String, int> globalCart,
  ) {
    return deals.map((DealsResponseModel deal) {
      final List<ProductListingResponse> updatedProducts =
          deal.productListModel.map((ProductListingResponse product) {
        if (product.sku == null || product.sku!.isEmpty) {
          return product;
        }

        // Update product variants with global cart quantities (each variant has its own key)
        if (product.productVariant != null &&
            product.productVariant!.isNotEmpty) {
          final List<ProductVariantDukkan> updatedVariants =
              product.productVariant!.map((ProductVariantDukkan variant) {
            final String? variantEntityId = variant.entityId?.toString();
            final int currentCartQuantity = variant.cartQuantity ?? 0;
            int globalCartQuantity = 0;

            if (variantEntityId != null && variantEntityId.isNotEmpty) {
              final String cartKey = '${product.sku}_$variantEntityId';
              globalCartQuantity = globalCart[cartKey] ?? 0;
            }

            if (currentCartQuantity != globalCartQuantity) {
              DebugLog.instance.d(
                  '🔄 HOME: Update variant ${variant.name} cart quantity from $currentCartQuantity to $globalCartQuantity');
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
      }).toList();

      return DealsResponseModel(
        id: deal.id,
        type: deal.type,
        label: deal.label,
        redirectUrl: deal.redirectUrl,
        productListModel: updatedProducts,
      );
    }).toList();
  }

  /// Force sync wishlist and cart state - used when navigating back to home
  void forceSyncWishlistOnResume() {
    DebugLog.instance.d('🔄 HOME: Force syncing wishlist and cart on resume');
    _syncWithGlobalWishlist();
    _syncWithGlobalCart();
  }

  /// Update specific SKU wishlist status - more targeted approach
  void updateSpecificSkuWishlistStatus({
    required String sku,
    required bool isInWishlist,
  }) {
    try {
      List<DealsResponseModel>? updatedDeals;
      List<DealsResponseModel>? updatedYouMayAlsoLike;

      // Update deals section for specific SKU
      if (state.dealsModel?.isNotEmpty ?? false) {
        updatedDeals =
            _updateSpecificSkuInDeals(state.dealsModel!, sku, isInWishlist);
      }

      // Update "You may also like" section for specific SKU
      if (state.youMayAlsoLikeDealsModel?.isNotEmpty ?? false) {
        updatedYouMayAlsoLike = _updateSpecificSkuInDeals(
            state.youMayAlsoLikeDealsModel!, sku, isInWishlist);
      }

      // Emit both updates in a single state change
      if (updatedDeals != null || updatedYouMayAlsoLike != null) {
        emit(state.copyWith(
          dealsModel: updatedDeals,
          youMayAlsoLikeDealsModel: updatedYouMayAlsoLike,
        ));
        DebugLog.instance.d(
            '🔄 HOME: Successfully updated specific SKU $sku wishlist status');
      }
    } on Exception catch (e) {
      DebugLog.instance
          .e('🔄 HOME: Error updating specific SKU wishlist status: $e');
    }
  }


  /// Simple update: Only change items that are not in global wishlist
  /*List<DealsResponseModel> _simpleUpdateDealsWishlist(
    List<DealsResponseModel> deals,
    List<String> globalWishlistItems,
  ) {
    DebugLog.instance.d(
        '🔄 HOME: Simple update - global wishlist items: $globalWishlistItems');

    return deals.map((DealsResponseModel deal) {
      final List<ProductListingResponse> updatedProducts =
          deal.productListModel.map((ProductListingResponse product) {
        if (product.sku == null || product.sku!.isEmpty) {
          return product; // Keep original state for products without SKU
        }

        final bool isInGlobalWishlist =
            globalWishlistItems.contains(product.sku);

        // Only update if the status is different
        if (product.isFavorite != isInGlobalWishlist) {
          DebugLog.instance.d(
              '🔄 HOME: Simple update - ${product.sku} from ${product.isFavorite} to $isInGlobalWishlist');
          return product.copyWith(isFavorite: isInGlobalWishlist);
        } else {
          DebugLog.instance
              .d('🔄 HOME: Simple update - ${product.sku} no change needed');
          return product;
        }
      }).toList();

      return DealsResponseModel(
        id: deal.id,
        type: deal.type,
        label: deal.label,
        redirectUrl: deal.redirectUrl,
        productListModel: updatedProducts,
      );
    }).toList();
  }*/

  /// Update specific SKU in deals list
  List<DealsResponseModel> _updateSpecificSkuInDeals(
    List<DealsResponseModel> deals,
    String targetSku,
    bool isInWishlist,
  ) {
    bool hasChanges = false;

    final List<DealsResponseModel> updatedDeals =
        deals.map((DealsResponseModel deal) {
      final List<ProductListingResponse> updatedProducts =
          deal.productListModel.map((ProductListingResponse product) {
        if (product.sku == targetSku && product.isFavorite != isInWishlist) {
          DebugLog.instance.d(
              '🔄 HOME: Updating specific product ${product.sku} from ${product.isFavorite} to $isInWishlist');
          hasChanges = true;
          return product.copyWith(isFavorite: isInWishlist);
        }
        return product;
      }).toList();

      return DealsResponseModel(
        id: deal.id,
        type: deal.type,
        label: deal.label,
        redirectUrl: deal.redirectUrl,
        productListModel: updatedProducts,
      );
    }).toList();

    return hasChanges ? updatedDeals : deals;
  }

  /// Update deals wishlist state from global cubit
  /*List<DealsResponseModel> _updateDealsWishlistFromGlobal(
    List<DealsResponseModel> deals,
    List<String> globalWishlistItems,
  ) {
    DebugLog.instance.d(
        '🔄 HOME: Updating deals with global wishlist items: $globalWishlistItems');
    DebugLog.instance
        .d('🔄 HOME: Global wishlist count: ${globalWishlistItems.length}');

    return deals.map((DealsResponseModel deal) {
      final List<ProductListingResponse> updatedProducts =
          deal.productListModel.map((ProductListingResponse product) {
        // Ensure SKU is not null or empty
        if (product.sku == null || product.sku!.isEmpty) {
          DebugLog.instance.d(
              '🔄 HOME: Product has null/empty SKU, skipping: ${product.name}');
          return product; // Keep original state for products without SKU
        }

        final bool isInWishlist = globalWishlistItems.contains(product.sku);
        DebugLog.instance.d(
            '🔄 HOME: Product ${product.sku} - isInWishlist: $isInWishlist, current isFavorite: ${product.isFavorite}');

        // Only update if the wishlist status has actually changed
        if (product.isFavorite != isInWishlist) {
          DebugLog.instance.d(
              '🔄 HOME: Updating ${product.sku} from ${product.isFavorite} to $isInWishlist');
          return product.copyWith(isFavorite: isInWishlist);
        } else {
          DebugLog.instance.d(
              '🔄 HOME: No change needed for ${product.sku} - already $isInWishlist');
          return product; // No change needed
        }
      }).toList();
      return DealsResponseModel(
        id: deal.id,
        type: deal.type,
        label: deal.label,
        redirectUrl: deal.redirectUrl,
        productListModel: updatedProducts,
      );
    }).toList();
  }*/

  /// Loads saved address from AddressService
  Future<void> loadSavedAddress() async {
    try {
      await getIt<AddressService>().ensureAddressDataLoaded();
      final SelectedAddressModel? address =
          getIt<AddressService>().selectedAddress;
      if (address != null && address.isValid) {
        emit(state.copyWith(selectedAddress: address));
      } else {
        // If no saved address, try to select the first address from the list
        await selectFirstAddressIfAvailable();
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error loading saved address: $e');
    }
  }

  /// Select the first address from the list if no address is currently selected
  /// This uses the address list that's already loaded by the HomeCubit's initData()
  Future<void> selectFirstAddressIfAvailable() async {
    try {
      final List<MyAddressListingResponse> addressList = state.addressList;

      // Only proceed if address list is loaded and not empty
      if (addressList.isNotEmpty &&
          state.apiCallForAddress == BaseStateStatus.success) {
        final MyAddressListingResponse firstAddress = addressList.first;

        // Create SelectedAddressModel from the first address
        final SelectedAddressModel selectedAddress = SelectedAddressModel(
            title: AddressUtils.getAddressTitle(firstAddress),
            details: AddressUtils.formatAddress(firstAddress),
            latitude: firstAddress.latitude,
            longitude: firstAddress.longitude,
            streetAddress1: firstAddress.street ?? '',
            city: firstAddress.area ?? '',
            country: '',
            // Default country
            addressId: int.tryParse(firstAddress.id ?? ''),
            addressType: firstAddress.addressType ?? "");
        // Save it using AddressService
        await getIt<AddressService>().saveSelectedAddress(selectedAddress);
        // Set delivery type to delivery
        await SharedPref.instance.saveDeliveryType('delivery');
        // Update the state
        emit(state.copyWith(selectedAddress: selectedAddress));
      } else {
        DebugLog.instance
            .d('Address list not yet loaded or empty, skipping auto-selection');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error selecting first address: $e');
    }
  }

  @override
  HomeState getResetErrorState() => state.copyWith(
        msg: '',
        status: BaseStateStatus.initial,
      );

  @override
  void resetError() {
    const String err = '';
    emit(
      state.copyWith(
        msg: err,
        status: BaseStateStatus.initial,
      ),
    );
  }

  @override
  HomeState getResetRedirectionState() => state.copyWith();

  /// Fetches the list of addresses from the repository and updates the state.
  Future<void> _callGetAddressListApi() async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 HOME API TIMING: Address List API started at ${startTime.toIso8601String()}');

    // Create the request model for address listing
    AddressListRequestModelDukkan addressRequestModel =
        AddressListRequestModelDukkan(
      customerToken: getIt<UserProfileService>().customerToken,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      limit: 10,
      offset: 0,
    );

    // Call the repository to get address list
    await addressRepositoryImpl.getAddressList(addressRequestModel).then(
      (ResponseHandler<BaseResponse<List<MyAddressListingResponse>>>
          value) async {
        if (value.isSuccess()) {
          BaseResponse<List<MyAddressListingResponse>>? response =
              value.getSuccessInstance()?.response;

          if (response?.success ?? false) {
            final List<MyAddressListingResponse> addresses =
                response?.data ?? <MyAddressListingResponse>[];

            /*if (addresses.isEmpty) {
              await getIt<AddressService>().removeSelectedAddress();
            }*/
            // If address list is empty, navigate to address listing page
            final PageRouteInfo? redirectRoute = addresses.isEmpty
                ? SelectAddressRoute(isFromStoreSelection: true)
                : null;
            emit(
              state.copyWith(
                apiCallForAddress: BaseStateStatus.success,
                addressList: addresses,
                redirectRoute: redirectRoute,
              ),
            );

            // After address list is loaded, load saved address or select first one (only if not empty)
            if (addresses.isNotEmpty) {
              await loadSavedAddress();
            }
          } else {
            emit(
              state.copyWith(
                apiCallForAddress: BaseStateStatus.failure,
              ),
            );
          }
        } else if (value.isFailure()) {
          emit(
            state.copyWith(
              apiCallForAddress: BaseStateStatus.failure,
            ),
          );
        }
      },
    );
  }

///////////////New API//////////////////

  /// api call for the brands listing
  Future<void> _callBrandsListing() async {
    emit(state.copyWith(apiCallForBrands: BaseStateStatus.loading));

    await homeRepository
        .getBrandsListing(
      BrandListRequest(
        customerToken: getIt<UserProfileService>().customerToken,
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 0,
        quoteId: getIt<UserProfileService>().quoteId.toString(),
        storeId: getIt<CountryService>().store.toString(),
        currency: getIt<LanguageService>().defaultCurrency,
        offset: 0,
        //limit: 5, #TODO as of now limit remove Because no view all ui.
      ),
    )
        .then(
            (ResponseHandler<BaseResponse<List<ListOfBrandsResponse>>> value) {
      if (value.isSuccess()) {
        final BaseResponse<List<ListOfBrandsResponse>>? brandsResponse =
            value.getSuccessInstance()?.response;
        emit(
          state.copyWith(
            apiCallForBrands: BaseStateStatus.success,
            brandsList: brandsResponse?.data ?? <ListOfBrandsResponse>[],
          ),
        );
      } else if (value.isFailure()) {
        emit(
          state.copyWith(
            msg: value.getFailureInstance()?.error?.errorMessage ?? "",
            apiCallForBrands: BaseStateStatus.failure,
          ),
        );
      }
    });
  }

  /// api call for the  HomeCategories
  Future<void> _callHomeCategory() async {
    emit(state.copyWith(apiCallForHomeCategory: BaseStateStatus.loading));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final LanguageService languageService = getIt<LanguageService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Create category request model
    final CategoryRequestModel categoryRequest = CategoryRequestModel(
        languageId: int.tryParse(languageService.languageId) ?? 1,
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        currency: languageService.defaultCurrency,
        storeId: countryService.store,
        limit: AppConstant.limitCategory,
        offset: 0);
    DebugLog.instance
        .i('CategoryRequestModel created: ${categoryRequest.toJson()}');

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
          emit(state.copyWith(
            apiCallForHomeCategory: BaseStateStatus.success,
            categoriesModel:
                saveResponse.data, // Store the category data in state
          ));
          // Debug log the category data

        } else {
          emit(state.copyWith(
            apiCallForHomeCategory: BaseStateStatus.failure,
            msg: saveResponse.error,
          ));
        }
      }
    }
  }

  /// api call for the  Deals
  Future<void> _callHomeDeals({
    DealsTagName tagName = DealsTagName.bestDeals,
    DealsScreen screen = DealsScreen.home,
    int? limit,
    int? offset,
  }) async {
    emit(state.copyWith(apiCallForHomeDeals: BaseStateStatus.loading));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final LanguageService languageService = getIt<LanguageService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    final int finalLimit = limit ?? AppConstant.limitDeal;
    final int finalOffset = offset ?? 0;

    // Create category request model
    final DealsRequestModel dealsRequest = DealsRequestModel(
        languageId: int.tryParse(languageService.languageId) ?? 1,
        quoteId: int.tryParse(userProfileService.quoteId.toString()) ?? 0,
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        currency: languageService.defaultCurrency,
        storeId: countryService.store,
        tagName: tagName.value,
        screen: screen.value,
        limit: finalLimit,
        offset: finalOffset);
    DebugLog.instance.i('DealsRequestModel created: ${dealsRequest.toJson()}');

    // Call the repository to get deals list
    final ResponseHandler<BaseResponse<List<DealsResponseModel>>> response =
        await homeRepository.getHomeDealsList(dealsRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<DealsResponseModel>>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<DealsResponseModel>> saveResponse =
            successInstance.response;

        // Check if the save operation was successful
        if (saveResponse.success) {
          emit(state.copyWith(
            apiCallForHomeDeals: BaseStateStatus.success,
            dealsModel: saveResponse.data, // Store the deals data in state
          ));

          // Store products in global wishlist manager
          if (saveResponse.data != null && saveResponse.data!.isNotEmpty) {
            for (final DealsResponseModel deal in saveResponse.data!) {
              final GlobalWishlistManager globalWishlistManager = getIt<GlobalWishlistManager>()..storeProductsFromAPI(deal.productListModel);
           DebugLog.instance.e(globalWishlistManager.wishlistCount.toString());
            }
          }

          // Debug log the category data
          if (saveResponse.data != null && saveResponse.data!.isNotEmpty) {
            for (int i = 0; i < saveResponse.data!.length; i++) {
              final DealsResponseModel deals = saveResponse.data![i];
              // Log child categories if they exist
              if (deals.productListModel.isNotEmpty) {
                for (int j = 0; j < deals.productListModel.length; j++) {
                  final ProductListingResponse productListModel =
                      deals.productListModel[j];

                  if (productListModel.productVariant?.isNotEmpty ?? false) {
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
            apiCallForHomeDeals: BaseStateStatus.failure,
            msg: saveResponse.error,
          ));
        }
      } else {
        emit(state.copyWith(
          apiCallForHomeDeals: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ?? '',
        ));
      }
    }
  }

  /// Call deals API for "You May Also Like" section
  /// Now uses GlobalHotDealsCubit for consistent state management
  Future<void> callYouMayAlsoLikeDeals({
    DealsTagName tagName = DealsTagName.youMayAlsoLike,
    DealsScreen screen = DealsScreen.home,
    int? limit,
    int? offset,
  }) async {
    emit(
        state.copyWith(apiCallForYouMayAlsoLikeDeals: BaseStateStatus.loading));

    // Use the original API call for now, but we'll integrate with global cubit later
    final UserProfileService userProfileService = getIt<UserProfileService>();
    final LanguageService languageService = getIt<LanguageService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    final int finalLimit = limit ?? AppConstant.limitDeal;
    final int finalOffset = offset ?? 0;

    // Create deals request model
    final DealsRequestModel dealsRequest = DealsRequestModel(
        languageId: int.tryParse(languageService.languageId) ?? 1,
        quoteId: int.tryParse(userProfileService.quoteId.toString()) ?? 0,
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        currency: languageService.defaultCurrency,
        storeId: countryService.store,
        tagName: DealsTagName.youMayAlsoLike.value,
        screen: DealsScreen.home.value,
        limit: finalLimit,
        offset: finalOffset);

    final ResponseHandler<BaseResponse<List<DealsResponseModel>>> response =
        await homeRepository.getHomeDealsList(dealsRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<DealsResponseModel>>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<DealsResponseModel>> saveResponse =
            successInstance.response;

        // Check if the save operation was successful
        if (saveResponse.success) {
          emit(state.copyWith(
            apiCallForYouMayAlsoLikeDeals: BaseStateStatus.success,
            youMayAlsoLikeDealsModel: saveResponse.data,
          ));

          // Store products in global wishlist manager
          if (saveResponse.data != null && saveResponse.data!.isNotEmpty) {
            for (final DealsResponseModel deal in saveResponse.data!) {
              final GlobalWishlistManager globalWishlistManager =
                  getIt<GlobalWishlistManager>()
              ..storeProductsFromAPI(deal.productListModel);
              DebugLog.instance.e(globalWishlistManager.wishlistCount.toString());

            }
          }
        } else {
          emit(state.copyWith(
            apiCallForYouMayAlsoLikeDeals: BaseStateStatus.failure,
            msg: saveResponse.error,
          ));
        }
      } else {
        emit(state.copyWith(
          apiCallForYouMayAlsoLikeDeals: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ?? '',
        ));
      }
    }
  }

  /// api call for the  Banners
  Future<void> _callHomeBanners() async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 HOME API TIMING: Home Banners API started at ${startTime.toIso8601String()}');

    emit(state.copyWith(apiCallForHomeBanners: BaseStateStatus.loading));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final LanguageService languageService = getIt<LanguageService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Create category request model
    final BannerRequestModel bannersRequest = BannerRequestModel(
      languageId: int.tryParse(languageService.languageId) ?? 1,
      quoteId: int.tryParse(userProfileService.quoteId.toString()) ?? 0,
      customerToken: userProfileService.customerToken,
      platform: getPlatformName(),
      version: mainConfig.packageInfo.version,
      storeId: countryService.store,
    );

    // Call the repository to get banners list
    final ResponseHandler<BaseResponse<List<BannerResponseModel>>> response =
        await homeRepository.getHomeBannersList(bannersRequest);

    if (response.isFailure()) {
      final OnFailureResponse<BaseResponse<List<BannerResponseModel>>>? error =
          response.getFailureInstance();

      emit(state.copyWith(
        apiCallForHomeBanners: BaseStateStatus.failure,
        msg: error?.error?.errorMessage ?? '',
      ));
      return;
    }

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<BannerResponseModel>>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<BannerResponseModel>> saveResponse =
            successInstance.response;

        // Check if the save operation was successful
        if (saveResponse.success) {
          emit(state.copyWith(
            apiCallForHomeBanners: BaseStateStatus.success,
            bannersModel: saveResponse.data, // Store the banners data in state
          ));

          // Debug log the banner data
          if (saveResponse.data != null && saveResponse.data!.isNotEmpty) {
            for (int i = 0; i < saveResponse.data!.length; i++) {
              final BannerResponseModel banners = saveResponse.data![i];

              if (banners.bannersListModel.isNotEmpty) {
                for (int a = 0; a < banners.bannersListModel.length; a++) {

                  //category fetch from banner
                  // if (bannersListModel.category!.isNotEmpty) {
                  //   for (int j = 0; j < bannersListModel.category!.length; j++) {
                  //     final CategoryBannerModel categoryBannerModel = bannersListModel.category?[j] as CategoryBannerModel;
                  //   }
                  // }

                  //brand fetch from banner
                  // if (bannersListModel.brand!.isNotEmpty) {
                  //   for (int j = 0; j < bannersListModel.brand!.length; j++) {
                  //     final BrandBannerModel brandModel = bannersListModel.brand?[j] as BrandBannerModel;
                  //   }
                  // }

                  //product fetch from banner
                  // if (bannersListModel.productListModel!.isNotEmpty) {
                  //   for (int j = 0; j < bannersListModel.productListModel!.length; j++) {
                  //     final ProductBannerModel productListModel = bannersListModel.productListModel?[j] as ProductBannerModel;
                  //
                  //     if (productListModel.productVariantModel?.isNotEmpty ??
                  //         false) {
                  //       for (int k = 0;
                  //       k < productListModel.productVariantModel!.length;
                  //       k++) {
                  //         final ProductVariantBannerModel? variant =
                  //         productListModel.productVariantModel?[k];
                  //       }
                  //     }
                  //   }
                  // }
                }
              }
            }
          }
        } else {
          emit(state.copyWith(
              apiCallForHomeBanners: BaseStateStatus.failure,
              msg: saveResponse.error ?? saveResponse.message));
        }
      }
    }
  }

  /// Handle cart operations for deals/you may also like sections
  /// This method handles add, increase, decrease, and remove cart operations
  /// Can be called for main product or specific variant
  Future<void> handleCartOperationForDeals({
    required int productIndex,
    required bool isDealsSection,
    required CartOperation operation,
    int? variantIndex, // Optional: specify which variant to use
  }) async {
    // Get the current product list based on section
    final List<ProductListingResponse> currentProducts = isDealsSection
        ? (state.dealsModel?.firstOrNull?.productListModel ??
            <ProductListingResponse>[])
        : (state.youMayAlsoLikeDealsModel?.firstOrNull?.productListModel ??
            <ProductListingResponse>[]);

    // Use the common mixin method
    await handleCartOperation(
        productIndex: productIndex,
        products: currentProducts,
        operation: operation,
        variantIndex: variantIndex,
        updateProductCartQuantity: (int productIndex,
            int cartQuantity,
            BaseStateStatus status,
            String message,
            int? variantIndex,
            int? apiCartCount) async {
          await _updateDealsProductCartQuantity(
            productIndex: productIndex,
            cartQuantity: cartQuantity,
            status: status,
            message: message,
            isDealsSection: isDealsSection,
            variantIndex: variantIndex,
            apiCartCount: apiCartCount,
          );
        },
        addToCartApi: addToCartListApi,
        removeFromCartApi: removeToCartListApi,
        updateToCartApi: updateToCartListApi);
  }

  /// Update product cart quantity in deals/you may also like sections
  Future<void> _updateDealsProductCartQuantity({
    required int productIndex,
    required int cartQuantity,
    required BaseStateStatus status,
    required String message,
    required bool isDealsSection,
    int? variantIndex, // Optional: specify which variant to update
    int? apiCartCount, // Cart count from API response
  }) async {
    // Update cart count from API response if available
    if (status == BaseStateStatus.success && apiCartCount != null) {
      // Use the cart count from API response (this is the correct approach)
      countCubit.updateCount(apiCartCount);
      DebugLog.instance.i('Updated cart count from API in home: $apiCartCount');
    }
    if (isDealsSection) {
      // Update deals section
      final List<DealsResponseModel> currentDealsList =
          state.dealsModel ?? <DealsResponseModel>[];
      if (currentDealsList.isNotEmpty) {
        final DealsResponseModel firstDeal = currentDealsList.first;
        final List<ProductListingResponse> currentProductList =
            firstDeal.productListModel;

        if (productIndex >= 0 && productIndex < currentProductList.length) {
          final List<ProductListingResponse> updatedProductList =
              List<ProductListingResponse>.from(currentProductList);
          final ProductListingResponse product =
              updatedProductList[productIndex];

          ProductListingResponse updatedProduct;

          if (variantIndex != null &&
              product.productVariant != null &&
              variantIndex < product.productVariant!.length) {
            // Update specific variant cart quantity
            final List<ProductVariantDukkan> updatedVariants =
                List<ProductVariantDukkan>.from(product.productVariant!);
            updatedVariants[variantIndex] =
                updatedVariants[variantIndex].copyWith(
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

          // Create updated deals list
          final List<DealsResponseModel> updatedDealsList =
              List<DealsResponseModel>.from(currentDealsList);
          updatedDealsList[0] = DealsResponseModel(
            id: firstDeal.id,
            type: firstDeal.type,
            label: firstDeal.label,
            redirectUrl: firstDeal.redirectUrl,
            productListModel: updatedProductList,
          );

          // Emit the updated state
          emit(
            state.copyWith(
              status: status,
              msg: message,
              dealsModel: updatedDealsList,
            ),
          );
        }
      }
    } else {
      // Update you may also like section
      final List<DealsResponseModel> currentYouMayAlsoLikeList =
          state.youMayAlsoLikeDealsModel ?? <DealsResponseModel>[];
      if (currentYouMayAlsoLikeList.isNotEmpty) {
        final DealsResponseModel firstDeal = currentYouMayAlsoLikeList.first;
        final List<ProductListingResponse> currentProductList =
            firstDeal.productListModel;

        if (productIndex >= 0 && productIndex < currentProductList.length) {
          final List<ProductListingResponse> updatedProductList =
              List<ProductListingResponse>.from(currentProductList);
          final ProductListingResponse product =
              updatedProductList[productIndex];

          ProductListingResponse updatedProduct;

          if (variantIndex != null &&
              product.productVariant != null &&
              variantIndex < product.productVariant!.length) {
            // Update specific variant cart quantity
            final List<ProductVariantDukkan> updatedVariants =
                List<ProductVariantDukkan>.from(product.productVariant!);
            updatedVariants[variantIndex] =
                updatedVariants[variantIndex].copyWith(
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

          // Create updated you may also like list
          final List<DealsResponseModel> updatedYouMayAlsoLikeList =
              List<DealsResponseModel>.from(currentYouMayAlsoLikeList);
          updatedYouMayAlsoLikeList[0] = DealsResponseModel(
            id: firstDeal.id,
            type: firstDeal.type,
            label: firstDeal.label,
            redirectUrl: firstDeal.redirectUrl,
            productListModel: updatedProductList,
          );

          // Emit the updated state
          emit(
            state.copyWith(
              status: status,
              msg: message,
              youMayAlsoLikeDealsModel: updatedYouMayAlsoLikeList,
            ),
          );
        }
      }
    }
  }

  /// Handle like/dislike functionality for wishlist items in deals/you may also like sections
  /// Now uses GlobalWishlistCubit and GlobalHotDealsCubit for consistent state management
  Future<void> handleWishlistLikeDislikeForDeals({
    required String sku,
    required int productIndex,
    required bool isCurrentlyFavorite,
    required bool isDealsSection, // true for deals, false for you may also like
  }) async {
    try {
      // Get product details for global wishlist
      final List<ProductListingResponse> currentProducts = isDealsSection
          ? (state.dealsModel?.firstOrNull?.productListModel ??
              <ProductListingResponse>[])
          : (state.youMayAlsoLikeDealsModel?.firstOrNull?.productListModel ??
              <ProductListingResponse>[]);

      DebugLog.instance.e(currentProducts.toString());
      // Use global wishlist manager for state management
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();

      if (isCurrentlyFavorite) {
        // Remove from wishlist (dislike)
        final ResponseHandler<BaseResponse<void>> response =
            await removeFromWishlistAPI(
          removeWishlistParams: createRemoveWishlistRequest(sku),
        );

        if (response.isSuccess()) {
          final BaseResponse<void>? responseData =
              response.getSuccessInstance()?.response;

          if (responseData?.success ?? false) {
            // Update global wishlist state
            globalWishlistManager.toggleWishlist(sku, false);

            // Update the product's favorite status in the deals/you may also like section
            _updateDealsProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: false,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
              isDealsSection: isDealsSection,
            );
          } else {
            _updateDealsProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: isCurrentlyFavorite,
              // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
              isDealsSection: isDealsSection,
            );
          }
        } else if (response.isFailure()) {
          _updateDealsProductWishlistStatus(
            productIndex: productIndex,
            isFavorite: isCurrentlyFavorite,
            // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ?? '',
            isDealsSection: isDealsSection,
          );
        }
      } else {
        // Add to wishlist (like)
        final ResponseHandler<AddWishlistModel> response =
            await addToWishlistAPI(
          wishListParams: createAddWishlistRequest(sku),
        );

        if (response.isSuccess()) {
          final AddWishlistModel? responseData =
              response.getSuccessInstance()?.response;

          if (responseData?.success ?? false) {
            // Update global wishlist state
            globalWishlistManager.toggleWishlist(sku, true);

            // Update the product's favorite status in the deals/you may also like section
            _updateDealsProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: true,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
              isDealsSection: isDealsSection,
            );
          } else {
            _updateDealsProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: isCurrentlyFavorite,
              // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
              isDealsSection: isDealsSection,
            );
          }
        } else if (response.isFailure()) {
          _updateDealsProductWishlistStatus(
            productIndex: productIndex,
            isFavorite: isCurrentlyFavorite,
            // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ?? '',
            isDealsSection: isDealsSection,
          );
        }
      }
    } on Exception catch (e) {
      DebugLog.instance.e(e.toString());
      _updateDealsProductWishlistStatus(
        productIndex: productIndex,
        isFavorite: isCurrentlyFavorite,
        status: BaseStateStatus.failure,
        message: 'An error occurred while updating wishlist',
        isDealsSection: isDealsSection,
      );
    }
  }

  /// Update product wishlist status in deals/you may also like sections
  void _updateDealsProductWishlistStatus({
    required int productIndex,
    required bool isFavorite,
    required BaseStateStatus status,
    required String message,
    required bool isDealsSection,
  }) {
    if (isDealsSection) {
      // Update deals section
      final List<DealsResponseModel> currentDealsList =
          state.dealsModel ?? <DealsResponseModel>[];
      if (currentDealsList.isNotEmpty) {
        final DealsResponseModel firstDeal = currentDealsList.first;
        final List<ProductListingResponse> currentProductList =
            firstDeal.productListModel;

        if (productIndex >= 0 && productIndex < currentProductList.length) {
          final List<ProductListingResponse> updatedProductList =
              List<ProductListingResponse>.from(currentProductList);
          final ProductListingResponse product =
              updatedProductList[productIndex];

          // Update the product's favorite status
          updatedProductList[productIndex] = product.copyWith(
            isFavorite: isFavorite,
          );

          // Create updated deals list
          final List<DealsResponseModel> updatedDealsList =
              List<DealsResponseModel>.from(currentDealsList);
          updatedDealsList[0] = DealsResponseModel(
            id: firstDeal.id,
            type: firstDeal.type,
            label: firstDeal.label,
            redirectUrl: firstDeal.redirectUrl,
            productListModel: updatedProductList,
          );

          // Emit the updated state
          emit(
            state.copyWith(
              status: status,
              msg: message,
              dealsModel: updatedDealsList,
            ),
          );
        }
      }
    } else {
      // Update you may also like section
      final List<DealsResponseModel> currentYouMayAlsoLikeList =
          state.youMayAlsoLikeDealsModel ?? <DealsResponseModel>[];
      if (currentYouMayAlsoLikeList.isNotEmpty) {
        final DealsResponseModel firstDeal = currentYouMayAlsoLikeList.first;
        final List<ProductListingResponse> currentProductList =
            firstDeal.productListModel;

        if (productIndex >= 0 && productIndex < currentProductList.length) {
          final List<ProductListingResponse> updatedProductList =
              List<ProductListingResponse>.from(currentProductList);
          final ProductListingResponse product =
              updatedProductList[productIndex];

          // Update the product's favorite status
          updatedProductList[productIndex] = product.copyWith(
            isFavorite: isFavorite,
          );

          // Create updated you may also like list
          final List<DealsResponseModel> updatedYouMayAlsoLikeList =
              List<DealsResponseModel>.from(currentYouMayAlsoLikeList);
          updatedYouMayAlsoLikeList[0] = DealsResponseModel(
            id: firstDeal.id,
            type: firstDeal.type,
            label: firstDeal.label,
            redirectUrl: firstDeal.redirectUrl,
            productListModel: updatedProductList,
          );

          // Emit the updated state
          emit(
            state.copyWith(
              status: status,
              msg: message,
              youMayAlsoLikeDealsModel: updatedYouMayAlsoLikeList,
            ),
          );
        }
      }
    }
  }

  /// API call for getting loyalty points
  /*Future<void> _callLoyaltyPointsApi() async {
    emit(state.copyWith(apiCallForLoyaltyPoints: BaseStateStatus.loading));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Create loyalty points request model
    final LoyaltyPointsRequestModel loyaltyPointsRequest =
        LoyaltyPointsRequestModel(
      customerToken: userProfileService.customerToken,
      platform: getPlatformName(),
      version: mainConfig.packageInfo.version,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
    );

    // Call the repository to get loyalty points
    final ResponseHandler<BaseResponse<List<LoyaltyPointsResponseModel>>>
        response = await homeRepository.getLoyaltyPoints(loyaltyPointsRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<LoyaltyPointsResponseModel>>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<LoyaltyPointsResponseModel>>
            loyaltyPointsResponse = successInstance.response;

        // Check if the API call was successful
        if (loyaltyPointsResponse.success) {
          emit(state.copyWith(
            apiCallForLoyaltyPoints: BaseStateStatus.success,
            loyaltyPointsModel: loyaltyPointsResponse,
          ));
        } else {
          emit(state.copyWith(
            apiCallForLoyaltyPoints: BaseStateStatus.failure,
            msg: loyaltyPointsResponse.message,
          ));
        }
      } else {
        emit(state.copyWith(
          apiCallForLoyaltyPoints: BaseStateStatus.failure,
          msg: 'Something went wrong',
        ));
      }
    } else if (response.isFailure()) {
      final OnFailureResponse<BaseResponse<List<LoyaltyPointsResponseModel>>>?
          failureInstance = response.getFailureInstance();
      final String errorMessage =
          failureInstance?.error?.errorMessage ?? 'Something went wrong';

      emit(state.copyWith(
        apiCallForLoyaltyPoints: BaseStateStatus.failure,
        msg: errorMessage,
      ));
    }
  }*/

  /// API call for getting cart listing to retrieve quoteId
  /// This method is called first in initData to get the quoteId,
  /// then chains the deals API calls
  Future<void> _callCartListingApi() async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 HOME API TIMING: Cart Listing API started at ${startTime.toIso8601String()}');

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Create cart listing request model
    final CartListingRequest cartListingRequest = CartListingRequest(
        websiteId: 1,
        // Default website ID
        storeId: countryService.store,
        customerToken: userProfileService.customerToken,
        quoteId:
            userProfileService.quoteId != 0 ? userProfileService.quoteId : 0,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1);

    DebugLog.instance
        .i('CartListingRequest created: ${cartListingRequest.toJson()}');

    // Call the repository to get cart listing
    final ResponseHandler<BaseResponse<CartDetailsListingResponseModel>>
        response = await wishlistCartRepository
            .getCartListing(cartListingRequest, showLoader: false);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<CartDetailsListingResponseModel>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<CartDetailsListingResponseModel>
            cartListingResponse = successInstance.response;

        // Check if the API call was successful
        if (cartListingResponse.success) {
          // Update quoteId in UserProfileService if it's different
          if (cartListingResponse.quoteId != null &&
              cartListingResponse.quoteId!.isNotEmpty) {
            await userProfileService.updateUserProfile(
              quoteId: cartListingResponse.quoteId,
            );
            DebugLog.instance.i(
                'Updated quoteId in UserProfileService: ${cartListingResponse.quoteId}');
          }
          // Update cart count in CartCountCubit
          if (cartListingResponse.cartCount != null) {
            countCubit.updateCount(cartListingResponse.cartCount!);
            DebugLog.instance.i(
                'Updated cart count in CartCountCubit: ${cartListingResponse.cartCount}');
          }
          // Chain the deals API calls after successful cart listing (in parallel)
          await Future.wait(<Future<void>>[
            _callHomeDeals(),
            callYouMayAlsoLikeDeals(),
          ]);

          DebugLog.instance
              .i('Cart listing API successful, chained deals API calls');
        } else {
          DebugLog.instance
              .e('Cart listing API failed: ${cartListingResponse.message}');
          // Still try to call deals APIs even if cart listing fails (in parallel)
          await Future.wait(<Future<void>>[
            _callHomeDeals(),
            callYouMayAlsoLikeDeals(),
          ]);
        }
      } else {
        DebugLog.instance.e('Cart listing API failed: No success instance');
        // Still try to call deals APIs even if cart listing fails (in parallel)
        await Future.wait(<Future<void>>[
          _callHomeDeals(),
          callYouMayAlsoLikeDeals(),
        ]);
      }
    } else if (response.isFailure()) {
      final OnFailureResponse<BaseResponse<CartDetailsListingResponseModel>>?
          failureInstance = response.getFailureInstance();
      final String errorMessage =
          failureInstance?.error?.errorMessage ?? 'Cart listing API failed';

      DebugLog.instance.e('Cart listing API failed: $errorMessage');
      // Still try to call deals APIs even if cart listing fails (in parallel)
      await Future.wait(<Future<void>>[
        _callHomeDeals(),
        callYouMayAlsoLikeDeals(),
      ]);
    }
  }

  /// Clears the redirect route after navigation
  void clearRedirectRoute() {
    emit(state.copyWith());
  }



  @override
  Future<void> close() async {
    await _globalWishlistSubscription?.cancel();
    await super.close();
  }
}
