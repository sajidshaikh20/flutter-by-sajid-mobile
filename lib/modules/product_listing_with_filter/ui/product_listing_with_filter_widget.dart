import '../../../utils/exports.dart';

/// Widget that displays the main product listing with filter and sorting functionality.
class ProductListingWithFilterWidget extends StatelessWidget {
  /// Creates a product listing with filter widget.
  const ProductListingWithFilterWidget({super.key});

  /// Apply filters to the product list by calling the appropriate API
  Future<void> _applyFiltersToProductList(
    ProductListingWithFilterCubit cubit,
    List<Map<String, dynamic>> filters,
  ) async {
    // Convert filters to FilterData format for API
    final List<FilterData>? filterData = cubit.getSelectedFiltersAsFilterData();

    // Get the currently selected category ID based on the selected tab
    String? currentCategoryId;
    if (cubit.state.selectedSegmentIndex > 0 && 
        cubit.state.tabLabels != null && 
        cubit.state.selectedSegmentIndex < cubit.state.tabLabels!.length) {
      final dynamic selectedCategory = cubit.state.tabLabels![cubit.state.selectedSegmentIndex];
      
      if (selectedCategory is CategoryResponseModel) {
        currentCategoryId = selectedCategory.categoryId?.toString();
      } else if (selectedCategory is ChildCategoryModel) {
        currentCategoryId = selectedCategory.categoryId?.toString();
      }
    }

    // Check the current type and call the appropriate API with filters
    if (cubit.state.type == DealsTagName.bestDeals.name) {
      await cubit.callHomeDeals(
        tagName: DealsTagName.bestDeals,
        filterData: filterData,
        offset: 0,
      );
    } else if (cubit.state.type == DealsTagName.youMayAlsoLike.name) {
      await cubit.callHomeDeals(
        tagName: DealsTagName.youMayAlsoLike,
        filterData: filterData,
        offset: 0,
      );
    } else if (cubit.state.type == DealsTagName.related.name) {
      await cubit.callRelatedProducts(
        filterData: filterData,
        offset: 0,
      );
    } else if (cubit.state.type == DealsTagName.trending.name) {
      await cubit.callTrendingProducts(
        filterData: filterData,
        offset: 0,
      );
    } else {
      // Regular product listing - use current category ID if available, otherwise use original typeId
      final int? typeIdToUse = currentCategoryId != null 
          ? int.tryParse(currentCategoryId) 
          : cubit.state.typeId;
      
      await cubit.getProductListing(
        typeId: typeIdToUse,
        filterData: filterData,
        offset: 0,
      );
    }
  }

  /// Reset the product list to show all products without filters
  Future<void> _resetProductListWithoutFilters(
      ProductListingWithFilterCubit cubit) async {
    // Get the currently selected category ID based on the selected tab
    String? currentCategoryId;
    if (cubit.state.selectedSegmentIndex > 0 && 
        cubit.state.tabLabels != null && 
        cubit.state.selectedSegmentIndex < cubit.state.tabLabels!.length) {
      final dynamic selectedCategory = cubit.state.tabLabels![cubit.state.selectedSegmentIndex];
      
      if (selectedCategory is CategoryResponseModel) {
        currentCategoryId = selectedCategory.categoryId?.toString();
      } else if (selectedCategory is ChildCategoryModel) {
        currentCategoryId = selectedCategory.categoryId?.toString();
      }
    }

    // Check the current type and call the appropriate API without filters
    if (cubit.state.type == DealsTagName.bestDeals.name) {
      await cubit.callHomeDeals(
        tagName: DealsTagName.bestDeals,
        offset: 0,
      );
    } else if (cubit.state.type == DealsTagName.youMayAlsoLike.name) {
      await cubit.callHomeDeals(
        tagName: DealsTagName.youMayAlsoLike,

        offset: 0,
      );
    } else if (cubit.state.type == DealsTagName.related.name) {
      await cubit.callRelatedProducts(

        offset: 0,
      );
    } else if (cubit.state.type == DealsTagName.trending.name) {
      await cubit.callTrendingProducts(
        offset: 0,
      );
    } else {
      // Regular product listing - use current category ID if available, otherwise use original typeId
      final int? typeIdToUse = currentCategoryId != null 
          ? int.tryParse(currentCategoryId) 
          : cubit.state.typeId;
      
      await cubit.getProductListing(
        typeId: typeIdToUse,
        offset: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double crossAxisSpacing = Dimens.space11;
    double paddingForView = Dimens.space10;
    final double itemWidth =
        (context.width - crossAxisSpacing - (paddingForView * 2)) /
            2; // Width of each item
    final double itemHeight =
        itemWidth + Dimens.heightOfTheBottomContentWithOutImagePadding;
    return Scaffold(
      backgroundColor: MainConfig.appColors.backgroundWhite,
      body: BlocListener<ProductListingWithFilterCubit,
          ProductListingWithFilterState>(
        listenWhen: (ProductListingWithFilterState previous, ProductListingWithFilterState current) {// Only listen when message changes and is not empty
          return previous.msg != current.msg &&
              (current.msg?.isNotEmpty ?? false);
        },
        listener: (BuildContext context, ProductListingWithFilterState state) {
          if (state.msg != null && state.msg!.isNotEmpty) {
            displaySnackBar(state.msg!, context);
          }
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
           // displaySnackBar(state.errorMessage!, context);
          }
        },
        child: Column(
          children: <Widget>[
            BlocBuilder<ProductListingWithFilterCubit,
                ProductListingWithFilterState>(
              builder:
                  (BuildContext context, ProductListingWithFilterState state) {
                return ProductDetailsAppBar(
                  onTapOfTheTabBar: (int value) async {
                    DebugLog.instance.w('Tab tapped with value: $value');
                    // Call the cubit method to handle tab selection
                    context.read<ProductListingWithFilterCubit>().onTabSelected(value);
                  },
                  tabLabels: state.tabLabels,
                  titleText: state.label ?? "",
                );
              },
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await context
                      .read<ProductListingWithFilterCubit>()
                      .refreshProducts();
                },
                child: ProductListingContentWidget(
                  itemWidth: itemWidth,
                  itemHeight: itemHeight,
                  crossAxisSpacing: crossAxisSpacing,
                  paddingForView: paddingForView,
                ),
              ),
            ),
            BlocBuilder<ProductListingWithFilterCubit,
                ProductListingWithFilterState>(
              builder:
                  (BuildContext context, ProductListingWithFilterState state) {
                // Show filter/sort buttons when there are products or during loading (sorting)
                final bool hasProducts =
                    (state.status == BaseStateStatus.success &&
                            state.productList != null &&
                            state.productList!.isNotEmpty) ||
                        (state.status == BaseStateStatus.loading &&
                            state.productList != null &&
                            state.productList!.isNotEmpty);

                if (!hasProducts &&
                    !(state.selectedFilters?.isNotEmpty ?? false)) {
                  return const SizedBox.shrink();
                }
                return Container(
                  height: Dimens.size80,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha:Dimens.opacity025),
                        // Shadow color with opacity
                        offset: const Offset(1, 0),
                        // x: 1, y: 0
                        blurRadius: Dimens.blurRadius4, // Blur radius
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FilterSortWidget(
                        label: context.appString.sortKey,
                        image: Assets.svgs.icSort,
                        rightPosition: Dimens.space5,
                        onTap: () async {
                          await showCustomBottomSheetView(
                            backgroundColor:
                                MainConfig.appColors.backgroundWhite,
                            context: context,
                            title: context.appString.sortByKey,
                            child: BlocProvider<
                                ProductListingWithFilterCubit>.value(
                              value:
                                  context.read<ProductListingWithFilterCubit>(),
                              child: const SortListScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: Dimens.size28,
                        child: VerticalDivider(
                          thickness: Dimens.borderWidth05,
                          width: Dimens.size2,
                          color: AppColors.deviderBorderColor,
                        ),
                      ),
                      BlocBuilder<ProductListingWithFilterCubit,
                          ProductListingWithFilterState>(
                        builder: (BuildContext context,
                            ProductListingWithFilterState state) {
                          return FilterSortWidget(
                            label: context.appString.filterKey,
                            image: Assets.svgs.icFilter,
                            rightPosition: Dimens.space5,
                            showIndicator:
                                state.selectedFilters?.isNotEmpty ?? false,
                            onTap: () async {
                              final ProductListingWithFilterCubit cubit =
                                  context.read<ProductListingWithFilterCubit>();
                              final GetFilterData? filterData = cubit.state.filterData;
                              final List<Map<String, dynamic>>?selectedFilters = state.selectedFilters;
                              if (filterData != null) {
                                final Object? filterSelections =
                                    await context.router.push(FilterRoute(
                                        filterData: filterData,
                                        selectedFilters: selectedFilters
                                            ?.cast<Map<String, dynamic>>()));

                                if (filterSelections != null) {
                                  // Store the selected filters in PLP state
                                  final Map<String, dynamic> result =
                                      filterSelections as Map<String, dynamic>;
                                  final List<Map<String, dynamic>>? newFilters =
                                      result['filterData']
                                          as List<Map<String, dynamic>>?;
                                  if (newFilters != null &&
                                      newFilters.isNotEmpty) {
                                    cubit.storeSelectedFilters(newFilters);

                                    // Apply filters by calling the appropriate API with filter data
                                    await _applyFiltersToProductList(
                                        cubit, newFilters);
                                  } else {
                                    // Clear filters if empty or null
                                    cubit.clearSelectedFilters();
                                    // Reset to show all products without filters
                                    await _resetProductListWithoutFilters(
                                        cubit);
                                  }
                                }
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
