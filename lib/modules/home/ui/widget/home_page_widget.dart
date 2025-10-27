import '../../../../utils/exports.dart';

/// The main home page widget that displays banners, categories, products,
/// and handles navigation and state management for the home screen.
class HomePageWidget extends StatefulWidget {
  /// Creates a [HomePageWidget].
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  bool _hasInitializedHomeCubit = false;
  bool _isNavigatingToSelectAddress = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener<dynamic, dynamic>>[
        BlocListener<HomeCubit, HomeState>(
          listenWhen: (HomeState previous, HomeState current) {
            return previous.addressList.length != current.addressList.length &&
                current.addressList.isEmpty &&
                current.apiCallForAddress == BaseStateStatus.success;
          },
          listener: (BuildContext context, HomeState state) async {
            // Navigate to select address page if address list is empty
            // Only navigate if not already navigating to prevent multiple navigations
            if (state.redirectRoute != null && !_isNavigatingToSelectAddress) {
              _isNavigatingToSelectAddress = true;
              await context.router.push(state.redirectRoute!);
              // Clear the redirect route after navigation
              if (context.mounted) {
                context.read<HomeCubit>().clearRedirectRoute();
                _isNavigatingToSelectAddress = false;
              }
            }
          },
        ),
      ],
      child: _HomePageContent(
        hasInitializedHomeCubit: _hasInitializedHomeCubit,
        onHomeCubitInitialized: () {
          setState(() {
            _hasInitializedHomeCubit = true;
          });
        },
      ),
    );
  }
}

class _HomePageContent extends BaseResponsiveView {
  const _HomePageContent({
    required this.hasInitializedHomeCubit,
    required this.onHomeCubitInitialized,
  });

  final bool hasInitializedHomeCubit;
  final VoidCallback onHomeCubitInitialized;

  Widget buildViews(BuildContext context, ScreenType device) {
    double viewportFraction = (context.width - Dimens.space20) / context.width;

    return NoInternetWidget(
      childWidget: Scaffold(
        backgroundColor: Colors.white,
        body: MultiBlocListener(
          listeners: <BlocListener<dynamic, dynamic>>[
            BlocListener<HomeCubit, HomeState>(
              listenWhen: (HomeState previous, HomeState current) {
                // Only listen when message changes and is not empty
                return previous.msg != current.msg &&
                    (current.msg?.isNotEmpty ?? false);
              },
              listener: (BuildContext context, HomeState state) {
                if (state.msg != null && state.msg!.isNotEmpty) {
                  displaySnackBar(state.msg!, context);
                }
              },
            ),
          ],
          child: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (HomeState previous, HomeState current) {
              // Only rebuild when relevant home data changes
              return previous.apiCallForHomeBanners !=
                      current.apiCallForHomeBanners ||
                  previous.apiCallForHomeCategory !=
                      current.apiCallForHomeCategory ||
                  previous.apiCallForHomeDeals != current.apiCallForHomeDeals ||
                  previous.apiCallForYouMayAlsoLikeDeals !=
                      current.apiCallForYouMayAlsoLikeDeals ||
                  previous.apiCallForLoyaltyPoints !=
                      current.apiCallForLoyaltyPoints ||
                  previous.bannersModel != current.bannersModel ||
                  previous.categoriesModel != current.categoriesModel ||
                  previous.dealsModel != current.dealsModel ||
                  previous.youMayAlsoLikeDealsModel !=
                      current.youMayAlsoLikeDealsModel ||
                  previous.loyaltyPointsModel != current.loyaltyPointsModel ||
                  previous.brandsList != current.brandsList ||
                  previous.cartCount != current.cartCount ||
                  previous.msg != current.msg;
            },
            builder: (BuildContext context, HomeState homeState) {
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const HomeAppbar(),
                      homeState.apiCallForAddress != BaseStateStatus.success
                          ? const HomeAddressSelectionShimmer()
                          : const HomeAddressSelection(),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            DebugLog.instance.d('Pull to refresh triggered');
                            context.read<HomeCubit>().refreshHomeData();
                            // Wait for a short time to show the refresh indicator
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Dimens.size16),
                                  child: isBannerShimmerDisplay(homeState)
                                      ? (() {
                                          final List<String> images =
                                              _getBannerImagesByType(
                                                  homeState,
                                                  homeState.bannersModel?.first
                                                      .type);
                                          final List<int> ids =
                                              _getBannerIdsListByType(
                                                  homeState,
                                                  homeState.bannersModel?.first
                                                      .type);

                                          return BannerCarouselWidget(
                                            imagesList: images,
                                            idsList: ids,
                                            onImageClick: (String imageUrl,
                                                int index, int id) async {
                                              DebugLog.instance.d(
                                                  'First banner clicked: image=$imageUrl, index=$index, id=$id');
                                              // Handle banner click based on banner type
                                              await _handleBannerClick(
                                                  context,
                                                  homeState,
                                                  homeState
                                                      .bannersModel?.first.type,
                                                  index);
                                            },
                                          );
                                        })()
                                      : const ProductDetailsCarouselShimmer(),
                                ),
                                /* const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimens.size16),
                                    child: HomeLoyaltyPointsWidget(),
                                  ),
                                  const SizedBox(
                                    height: Dimens.size25,
                                  ),*/
                                homeState.apiCallForAddress !=
                                        BaseStateStatus.success
                                    ? const HeaderWidgetShimmer()
                                    : HeaderWidget(
                                        viewAllOnclick: () async {
                                          await context.router
                                              .push(const HomeCategoryRoute());
                                        },
                                        device: device,
                                        mainHeader:
                                            context.appString.shopByCategoryKey,
                                        viewAll: context.appString.viewAllKey,
                                        isPaddingNeed: true,
                                      ),
                                const SizedBox(
                                  height: Dimens.size16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.space16),
                                  child: homeState.apiCallForHomeCategory !=
                                          BaseStateStatus.success
                                      ? const CommonCategoryShimmer()
                                      : const CommonCategoryWidget(),
                                ),
                                const SizedBox(
                                  height: Dimens.size24,
                                ),
                                homeState.apiCallForHomeBanners !=
                                        BaseStateStatus.success
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Dimens.size16),
                                        child: ProductDetailsCarouselShimmer(
                                          height: Dimens.size123,
                                        ),
                                      )
                                    : Container(
                                        color: MainConfig
                                            .appColors.backgroundPinkColor,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: Dimens.size16),
                                        child: BannerCarouselWidget(
                                          imagesList: _getBannerImagesByType(
                                              homeState,
                                              homeState
                                                  .bannersModel?.last.type),
                                          idsList: _getBannerIdsListByType(
                                              homeState,
                                              homeState
                                                  .bannersModel?.last.type),
                                          imageBgColor: MainConfig
                                              .appColors.backgroundPinkColor,
                                          isViewPortActionRequired: true,
                                          viewportFraction: viewportFraction,
                                          height: Dimens.size123,
                                          onImageClick: (String imageUrl,
                                              int index, int id) async {
                                            DebugLog.instance.d(
                                                'Second banner clicked: image=$imageUrl, index=$index, id=$id');
                                            // Handle banner click based on banner type
                                            await _handleBannerClick(
                                                context,
                                                homeState,
                                                homeState
                                                    .bannersModel?.last.type,
                                                index);
                                          },
                                        ),
                                      ),
                                if (homeState
                                    .brandsList.isNotEmpty) ...<Widget>[
                                  commonHeaderWithSizeBox(
                                      context.appString.shopByBrandsKey,
                                      isViewAllVisible:
                                      false,
                                     viewAllOnclick:  () async {
                                    // await context.router.push(const ProductListingWithFilterRoute());
                                  },context:  context,
                                      device: device,state:  homeState),
                                  homeState.apiCallForAddress !=
                                          BaseStateStatus.success
                                      ? const ShopByBrandsShimmer()
                                      : ShopByBrands(
                                          brandsList: homeState.brandsList,
                                          onBrandTap: (int brandId,
                                              String brandName) async {
                                            List<CategoryResponseModel>
                                                listCategoryAll =
                                                <CategoryResponseModel>[
                                              CategoryResponseModel(
                                                  categoryName:
                                                      context.appString.allKey),
                                            ];
                                            await context.router.push(
                                                ProductListingWithFilterRoute(
                                                    typeId: brandId,
                                                    type:
                                                        ProductType.brand.name,
                                                    label: brandName,
                                                    tabLabels:
                                                        listCategoryAll));
                                          },
                                        ),
                                ],
                                // Only show header if there's data in dealsModel
                                _getDealsProducts(homeState).isNotEmpty
                                    ? commonHeaderWithSizeBox(
                                        context.appString.hotDealsKey,
                                    isViewAllVisible:
                                    true,
                                     viewAllOnclick:    () async {
                                        List<CategoryResponseModel>
                                            listCategoryAll =
                                            <CategoryResponseModel>[
                                          CategoryResponseModel(
                                              categoryName:
                                                  context.appString.allKey),
                                        ];
                                        await context.router.push(
                                            ProductListingWithFilterRoute(
                                                type:
                                                    DealsTagName.bestDeals.name,
                                                label: context
                                                    .appString.hotDealsKey,
                                                tabLabels: listCategoryAll));
                                      },
                                    context:
                                    context,
                                    device: device,state:  homeState)
                                    : const SizedBox.shrink(),
                                // Only show deals widget if there's data
                                _getDealsProducts(homeState).isNotEmpty
                                    ? (homeState.apiCallForHomeDeals !=
                                            BaseStateStatus.success
                                        ? const HotDealsShimmer()
                                        : HotDealsWidget(
                                            products:
                                                _getDealsProducts(homeState),
                                            cartCount: homeState.cartCount ?? 0,
                                            onVariantCartOperation: (int
                                                    productIndex,
                                                int variantIndex,
                                                CartOperation operation) async {
                                              // Handle variant cart operations for deals section
                                              await context
                                                  .read<HomeCubit>()
                                                  .handleCartOperationForDeals(
                                                    productIndex: productIndex,
                                                    isDealsSection: true,
                                                    operation: operation,
                                                    variantIndex: variantIndex,
                                                  );
                                            },
                                            onAddPressed: (int index) async {
                                              final List<ProductListingResponse>
                                                  products =
                                                  _getDealsProducts(homeState);
                                              if (index < products.length &&
                                                  products[index].sku != null) {
                                                final ProductListingResponse
                                                    product = products[index];
                                                // Check if product has variants
                                                if (product.productVariant !=
                                                        null &&
                                                    product.productVariant!
                                                            .length >
                                                        1) {
                                                  // Show SelectUnit for variants - handled by ProductCommonItem
                                                  // The variant cart operations will be handled through the onVariantCartOperation callback
                                                } else {
                                                  // Handle main product cart operation
                                                  await context
                                                      .read<HomeCubit>()
                                                      .handleCartOperationForDeals(
                                                        productIndex: index,
                                                        isDealsSection: true,
                                                        operation:
                                                            CartOperation.add,
                                                      );
                                                }
                                              }
                                            },
                                            onPlusPressed: (int index) async {
                                              final List<ProductListingResponse>
                                                  products =
                                                  _getDealsProducts(homeState);
                                              if (index < products.length &&
                                                  products[index].sku != null) {
                                                await context
                                                    .read<HomeCubit>()
                                                    .handleCartOperationForDeals(
                                                      productIndex: index,
                                                      isDealsSection: true,
                                                      operation: CartOperation
                                                          .increase,
                                                    );
                                              }
                                            },
                                            onMinusPressed: (int index) async {
                                              final List<ProductListingResponse>
                                                  products =
                                                  _getDealsProducts(homeState);
                                              if (index < products.length &&
                                                  products[index].sku != null) {

                                                await context
                                                    .read<HomeCubit>()
                                                    .handleCartOperationForDeals(
                                                      productIndex: index,
                                                      isDealsSection: true,
                                                      operation: CartOperation
                                                          .decrease,
                                                    );
                                              }
                                            },
                                            likeDislikeItemPressed:
                                                (int index) async {
                                              final List<ProductListingResponse>
                                                  products =
                                                  _getDealsProducts(homeState);
                                              if (index < products.length &&
                                                  products[index].sku != null) {
                                                final ProductListingResponse
                                                    product = products[index];
                                                await context
                                                    .read<HomeCubit>()
                                                    .handleWishlistLikeDislikeForDeals(
                                                      sku: product.sku!,
                                                      productIndex: index,
                                                      isCurrentlyFavorite:
                                                          product.isFavorite ??
                                                              false,
                                                      isDealsSection: true,
                                                    );
                                              }
                                            },
                                          ))
                                    : const SizedBox.shrink(),
                                // Only show header if there's data in youMayAlsoLikeDealsModel
                                _getYouMayAlsoLikeProducts(homeState).isNotEmpty
                                    ? commonHeaderWithSizeBox(
                                        context.appString.youMayAlsoLikeKey,
                                        isViewAllVisible: true,
                                        viewAllOnclick: () async {
                                        List<CategoryResponseModel>
                                            listCategoryAll =
                                            <CategoryResponseModel>[
                                          CategoryResponseModel(
                                              categoryName:
                                                  context.appString.allKey),
                                        ];
                                        await context.router.push(
                                            ProductListingWithFilterRoute(
                                                type: DealsTagName
                                                    .youMayAlsoLike.name,
                                                label: context.appString
                                                    .youMayAlsoLikeKey,
                                                tabLabels: listCategoryAll));
                                      },
                                        context: context,
                                        device: device,
                                        state: homeState)
                                    : const SizedBox.shrink(),
                                // Only show deals widget if there's data
                                _getYouMayAlsoLikeProducts(homeState).isNotEmpty
                                    ? (homeState.apiCallForYouMayAlsoLikeDeals !=
                                            BaseStateStatus.success
                                        ? const HotDealsShimmer()
                                        : HotDealsWidget(
                                            onVariantCartOperation: (int
                                                    productIndex,
                                                int variantIndex,
                                                CartOperation operation) async {
                                              // Handle variant cart operations for "You May Also Like" section
                                              await context
                                                  .read<HomeCubit>()
                                                  .handleCartOperationForDeals(
                                                    productIndex: productIndex,
                                                    isDealsSection: false,
                                                    operation: operation,
                                                    variantIndex: variantIndex,
                                                  );
                                            },
                                            onAddPressed: (int index) async {
                                              final List<ProductListingResponse>
                                                  products =
                                                  _getYouMayAlsoLikeProducts(
                                                      homeState);
                                              if (index < products.length &&
                                                  products[index].sku != null) {

                                                await context
                                                    .read<HomeCubit>()
                                                    .handleCartOperationForDeals(
                                                      productIndex: index,
                                                      isDealsSection: false,
                                                      operation:
                                                          CartOperation.add,
                                                    );
                                              }
                                            },
                                            products:
                                                _getYouMayAlsoLikeProducts(
                                                    homeState),
                                            cartCount: homeState.cartCount ?? 0,
                                            onPlusPressed: (int index) async {
                                              final List<ProductListingResponse>
                                                  products =
                                                  _getYouMayAlsoLikeProducts(
                                                      homeState);
                                              if (index < products.length &&
                                                  products[index].sku != null) {

                                                await context
                                                    .read<HomeCubit>()
                                                    .handleCartOperationForDeals(
                                                      productIndex: index,
                                                      isDealsSection: false,
                                                      operation: CartOperation
                                                          .increase,
                                                    );
                                              }
                                            },
                                            onMinusPressed: (int index) async {
                                              final List<ProductListingResponse>
                                                  products =
                                                  _getYouMayAlsoLikeProducts(
                                                      homeState);
                                              if (index < products.length &&
                                                  products[index].sku != null) {
                                                await context
                                                    .read<HomeCubit>()
                                                    .handleCartOperationForDeals(
                                                      productIndex: index,
                                                      isDealsSection: false,
                                                      operation: CartOperation
                                                          .decrease,
                                                    );
                                              }
                                            },
                                            likeDislikeItemPressed:
                                                (int index) async {
                                              final List<ProductListingResponse>
                                                  products =
                                                  _getYouMayAlsoLikeProducts(
                                                      homeState);
                                              if (index < products.length &&
                                                  products[index].sku != null) {
                                                final ProductListingResponse
                                                    product = products[index];
                                                await context
                                                    .read<HomeCubit>()
                                                    .handleWishlistLikeDislikeForDeals(
                                                      sku: product.sku!,
                                                      productIndex: index,
                                                      isCurrentlyFavorite:
                                                          product.isFavorite ??
                                                              false,
                                                      isDealsSection: false,
                                                    );
                                              }
                                            },
                                          ))
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: Dimens.size25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Positioned(
                      bottom: Dimens.size16,
                      right: Dimens.size16,
                      child: HomeFaqWidget())
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  bool isBannerShimmerDisplay(HomeState homeState) {
    final bool isSuccess =
        homeState.apiCallForHomeBanners == BaseStateStatus.success;
    DebugLog.instance.d('=== BANNER SHIMMER CHECK ===');
    DebugLog.instance.d('API call status: ${homeState.apiCallForHomeBanners}');
    DebugLog.instance.d('Is success: $isSuccess');
    DebugLog.instance.d('Banner model: ${homeState.bannersModel != null}');
    DebugLog.instance
        .d('Banner data length: ${homeState.bannersModel?.length ?? 0}');
    return isSuccess;
  }

  List<ProductListingResponse> _getDealsProducts(HomeState homeState) {
    try {
      if (homeState.dealsModel == null || homeState.dealsModel!.isEmpty) {
        return <ProductListingResponse>[];
      }
      return homeState.dealsModel?.firstOrNull?.productListModel ??
          <ProductListingResponse>[];
    } on Exception catch (e) {
      DebugLog.instance.e('Error in _getDealsProducts: $e');
      return <ProductListingResponse>[];
    }
  }

  List<ProductListingResponse> _getYouMayAlsoLikeProducts(HomeState homeState) {
    try {
      if (homeState.youMayAlsoLikeDealsModel == null ||
          homeState.youMayAlsoLikeDealsModel!.isEmpty) {
        return <ProductListingResponse>[];
      }
      return homeState
              .youMayAlsoLikeDealsModel?.firstOrNull?.productListModel ??
          <ProductListingResponse>[];
    } on Exception catch (e) {
      DebugLog.instance.e('Error in _getYouMayAlsoLikeProducts: $e');
      return <ProductListingResponse>[];
    }
  }

  /// Get banner images by type (full_width or secondary)
  List<String> _getBannerImagesByType(HomeState homeState, String? type) {
    try {
      // Return empty list if banners not found
      if (homeState.bannersModel == null || homeState.bannersModel!.isEmpty) {
        return <String>[];
      }

      // Initialize bannerGroup as nullable and assign default null
      BannerResponseModel? bannerGroup;

      if (type == BannerType.fullWidth.value) {
        bannerGroup = homeState.bannersModel
            ?.where((BannerResponseModel banner) => banner.type == type)
            .firstOrNull;
      } else if (type == BannerType.secondary.value) {
        bannerGroup = homeState.bannersModel
            ?.where((BannerResponseModel banner) => banner.type == type)
            .lastOrNull;
      }

      // Return empty list if banner group not found
      if (bannerGroup == null || bannerGroup.bannersListModel.isEmpty) {
        return <String>[];
      }

      // Extract non-empty mobile URLs
      final List<String> bannerImages = bannerGroup.bannersListModel
          .where((BannersListModel banner) =>
              banner.mobileUrl?.isNotEmpty ?? false)
          .map((BannersListModel banner) => banner.mobileUrl!)
          .toList();

      // Return extracted images or fallback
      return bannerImages.isNotEmpty ? bannerImages : AppConstant.carousalImage;
    } on Exception catch (e) {
      DebugLog.instance.e('Error in _getBannerImagesByType: $e');
      return AppConstant.carousalImage;
    }
  }

  /// Handle banner click based on banner type and index
  Future<void> _handleBannerClick(BuildContext context, HomeState homeState,
      String? type, int index) async {
    try {
      if (homeState.bannersModel == null || homeState.bannersModel!.isEmpty) {
        DebugLog.instance.d('No banner data available');
        return;
      }

      // Find the correct banner group based on type
      BannerResponseModel? bannerGroup;
      if (type == BannerType.fullWidth.value) {
        bannerGroup = homeState.bannersModel
            ?.where((BannerResponseModel banner) => banner.type == type)
            .firstOrNull;
      } else if (type == BannerType.secondary.value) {
        bannerGroup = homeState.bannersModel
            ?.where((BannerResponseModel banner) => banner.type == type)
            .lastOrNull;
      }

      if (bannerGroup == null ||
          bannerGroup.bannersListModel.isEmpty ||
          index >= bannerGroup.bannersListModel.length) {
        DebugLog.instance.d(
            'Invalid banner group or index: group=${bannerGroup != null}, length=${bannerGroup?.bannersListModel.length}, index=$index');
        return;
      }

      final BannersListModel clickedBanner =
          bannerGroup.bannersListModel[index];
      DebugLog.instance.d('=== BANNER CLICK DETAILS ===');
      DebugLog.instance.d('Banner type: ${clickedBanner.bannerType}');
      DebugLog.instance.d('Banner index: $index');
      DebugLog.instance.d('Banner ID: ${clickedBanner.id}');
      DebugLog.instance.d('Banner URL: ${clickedBanner.url}');

      // Handle navigation based on banner type
      switch (clickedBanner.bannerType) {
        case "category":
          if (clickedBanner.category != null &&
              clickedBanner.category is List &&
              (clickedBanner.category as List<dynamic>).isNotEmpty) {
            final List<dynamic> categoryList =
                clickedBanner.category as List<dynamic>;
            if (categoryList.first is CategoryResponseModel) {
              final CategoryResponseModel categoryResponse =
                  categoryList.first as CategoryResponseModel;
              DebugLog.instance.d('=== CATEGORY BANNER CLICKED ===');
              DebugLog.instance
                  .d('Category ID: ${categoryResponse.categoryId}');
              DebugLog.instance
                  .d('Category Name: ${categoryResponse.categoryName}');
              DebugLog.instance
                  .d('Category Image: ${categoryResponse.categoryImage}');
              DebugLog.instance
                  .d('Has Children: ${categoryResponse.hasChildren}');
              await context.router.push(ProductListingWithFilterRoute(
                typeId: categoryResponse.categoryId,
                type: ProductType.category.name,
                label: categoryResponse.categoryName,
                tabLabels: categoryResponse.childCategories,
              ));
            }
          } else {
            DebugLog.instance.d('Category banner: no category data available');
          }

        case "product":
          if (clickedBanner.productListModel != null &&
              clickedBanner.productListModel is List &&
              (clickedBanner.productListModel as List<dynamic>).isNotEmpty) {
            final List<dynamic> productList =
                clickedBanner.productListModel as List<dynamic>;
            if (productList.first is ProductListingResponse) {
              final ProductListingResponse productResponse =
                  productList.first as ProductListingResponse;
              DebugLog.instance.d('=== PRODUCT BANNER CLICKED ===');
              DebugLog.instance.d('Product ID: ${productResponse.entityId}');
              DebugLog.instance.d('Product Name: ${productResponse.name}');
              DebugLog.instance
                  .d('Product Price: ${productResponse.formattedPrice}');
              DebugLog.instance.d('Product SKU: ${productResponse.sku}');
              DebugLog.instance.d('Product URL: ${productResponse.url}');
              await context.router.push(
                  ProductDetailsRoute(entityId: productResponse.entityId ?? 0));
            }
          } else {
            DebugLog.instance.d('Product banner: no product data available');
          }

        case "brand":
          if (clickedBanner.brand != null &&
              clickedBanner.brand is List &&
              (clickedBanner.brand as List<dynamic>).isNotEmpty) {
            final List<dynamic> brandList =
                clickedBanner.brand as List<dynamic>;
            if (brandList.first is ListOfBrandsResponse) {
              final ListOfBrandsResponse brandResponse =
                  brandList.first as ListOfBrandsResponse;
              DebugLog.instance.d('=== BRAND BANNER CLICKED ===');
              DebugLog.instance.d('Brand ID: ${brandResponse.id}');
              DebugLog.instance.d('Brand Label: ${brandResponse.brandLabel}');
              DebugLog.instance.d('Brand Image: ${brandResponse.brandImage}');
              List<CategoryResponseModel> listCategoryAll =
                  <CategoryResponseModel>[
                CategoryResponseModel(categoryName: context.appString.allKey),
              ];
              await context.router.push(ProductListingWithFilterRoute(
                  typeId: brandResponse.id,
                  type: ProductType.brand.name,
                  label: brandResponse.brandLabel,
                  tabLabels: listCategoryAll));
            }
          } else {
            DebugLog.instance.d('Brand banner: no brand data available');
          }

        case "url":
          if (clickedBanner.url != null &&
              clickedBanner.url!.isNotEmpty &&
              clickedBanner.url != 'null') {
            DebugLog.instance.d('=== URL BANNER CLICKED ===');
            DebugLog.instance.d('URL: ${clickedBanner.url}');

            // Ensure URL has proper scheme
            String urlToOpen = clickedBanner.url!;
            if (!urlToOpen.startsWith('http://') &&
                !urlToOpen.startsWith('https://')) {
              urlToOpen = 'https://$urlToOpen';
            }

            try {
              final Uri uri = Uri.parse(urlToOpen);
              if (await canLaunchUrl(uri)) {
                await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                );
                DebugLog.instance.d('URL opened successfully: $urlToOpen');
              } else {
                DebugLog.instance.e('Could not launch URL: $urlToOpen');
                // Show error message to user
                if (context.mounted) {
                  displaySnackBar('Could not open URL: $urlToOpen', context);
                }
              }
            } on Exception catch (e) {
              DebugLog.instance.e('Error opening URL: $e');
              if (context.mounted) {
                displaySnackBar('Error opening URL: $urlToOpen', context);
              }
            }
          } else {
            DebugLog.instance.d('URL banner: no URL data available');
          }

        default:
          DebugLog.instance
              .d('Unknown banner type: ${clickedBanner.bannerType}');
      }

      DebugLog.instance.d('=== END BANNER CLICK DETAILS ===');
    } on Exception catch (e) {
      DebugLog.instance.e('Error handling banner click: $e');
    }
  }

  /// Get banner IDs list by type and banner type (category, product, brand, url)
  List<int> _getBannerIdsListByType(HomeState homeState, String? type) {
    try {
      // Return empty list if banners not found
      if (homeState.bannersModel == null || homeState.bannersModel!.isEmpty) {
        return <int>[];
      }

      // Find the correct banner group based on type
      BannerResponseModel? bannerGroup;
      if (type == BannerType.fullWidth.value) {
        bannerGroup = homeState.bannersModel
            ?.where((BannerResponseModel banner) => banner.type == type)
            .firstOrNull;
      } else if (type == BannerType.secondary.value) {
        bannerGroup = homeState.bannersModel
            ?.where((BannerResponseModel banner) => banner.type == type)
            .lastOrNull;
      }

      // If banner group is null or has no banners → return empty list
      if (bannerGroup == null || bannerGroup.bannersListModel.isEmpty) {
        return <int>[];
      }

      final List<int> bannerIds = <int>[];

      // Loop through banners and fetch ID based on bannerType
      for (final BannersListModel banner in bannerGroup.bannersListModel) {
        DebugLog.instance
            .d('Processing banner: type=${banner.bannerType}, id=${banner.id}');

        switch (banner.bannerType) {
          case "category":
            if (banner.category != null &&
                banner.category is List &&
                (banner.category as List<dynamic>).isNotEmpty) {
              final List<dynamic> categoryList =
                  banner.category as List<dynamic>;
              if (categoryList.first is CategoryResponseModel) {
                final CategoryResponseModel categoryResponse =
                    categoryList.first as CategoryResponseModel;
                final int categoryId = categoryResponse.categoryId ?? 0;
                bannerIds.add(categoryId);
                DebugLog.instance.d('Category banner: categoryId=$categoryId');
              }
            } else {
              bannerIds.add(0);
              DebugLog.instance.d('Category banner: no category data');
            }

          case "product":
            if (banner.productListModel != null &&
                banner.productListModel is List &&
                (banner.productListModel as List<dynamic>).isNotEmpty) {
              final List<dynamic> productList =
                  banner.productListModel as List<dynamic>;
              if (productList.first is ProductListingResponse) {
                final ProductListingResponse productResponse =
                    productList.first as ProductListingResponse;
                final int productId = productResponse.entityId ?? 0;
                bannerIds.add(productId);
                DebugLog.instance.d('Product banner: productId=$productId');
              }
            } else {
              bannerIds.add(0);
              DebugLog.instance.d('Product banner: no product data');
            }

          case "brand":
            if (banner.brand != null &&
                banner.brand is List &&
                (banner.brand as List<dynamic>).isNotEmpty) {
              final List<dynamic> brandList = banner.brand as List<dynamic>;
              if (brandList.first is ListOfBrandsResponse) {
                final ListOfBrandsResponse brandResponse =
                    brandList.first as ListOfBrandsResponse;
                final int brandId = brandResponse.id ?? 0;
                bannerIds.add(brandId);
                DebugLog.instance.d('Brand banner: brandId=$brandId');
              }
            } else {
              bannerIds.add(0);
              DebugLog.instance.d('Brand banner: no brand data');
            }

          case "url":
            bannerIds.add(0); // No ID for URLs
            DebugLog.instance.d('URL banner: no ID needed');

          default:
            bannerIds.add(0); // Add 0 for unknown types
            DebugLog.instance.d('Unknown banner type: ${banner.bannerType}');
        }
      }

      DebugLog.instance.d('Final banner IDs list: $bannerIds');
      return bannerIds;
    } on Exception catch (e) {
      DebugLog.instance.e('Error in _getBannerIdsListByType: $e');
      return <int>[];
    }
  }

  Widget commonHeaderWithSizeBox(
    String title, {
    required bool isViewAllVisible,
    Function()? viewAllOnclick,
    required BuildContext context,
    required ScreenType device,
    required HomeState state,
  }) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: Dimens.size25,
        ),
        HeaderWidget(
          device: device,
          mainHeader: title,
          viewAll: context.appString.viewAllKey,
          isPaddingNeed: true,
          isViewAllVisible: isViewAllVisible,
          viewAllOnclick: viewAllOnclick,
        ),
        const SizedBox(
          height: Dimens.size18,
        ),
      ],
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildViews(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildViews(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildViews(context, ScreenType.tablet);
  }
}