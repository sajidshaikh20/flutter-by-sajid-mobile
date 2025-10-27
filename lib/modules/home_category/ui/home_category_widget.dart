import '../../../utils/exports.dart';

/// Widget that displays the home categories in a grid layout with refresh functionality.
class HomeCategoryWidget extends StatelessWidget {
  /// Creates a home category widget.
  ///
  /// [device] The screen type for responsive design.
  const HomeCategoryWidget({super.key,this.device =ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return NoInternetWidget(
      childWidget: Scaffold(
      backgroundColor: AppColors.whiteColor,
        body: Column(
          children: <Widget>[
            HomeAppbar(isShadowDisplay: true,title: context.appString.navCategoriesKey,),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await context.read<HomeCategoryCubit>().refreshCategories();
                },
                child: _buildCategoryGrid(context, device),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext ctx,ScreenType device) {

    return BlocBuilder<HomeCategoryCubit, HomeCategoryState>(
      buildWhen: (HomeCategoryState previous, HomeCategoryState current) {
        return (previous.categoryData != current.categoryData) ||
            (previous.status != current.status) ||
            (previous.categoriesModel != current.categoriesModel) ||
            (previous.categoryList != current.categoryList) ||
            (previous.isLoadingMore != current.isLoadingMore);
      },
      builder: (BuildContext context, HomeCategoryState state) {
        final List<CategoryResponseModel> categoryResponseModels = _getCategoryResponseModelsFromHomeState(state);

        if (state.status == BaseStateStatus.success) {
          // ✅ Show No Data Widget if list is empty or null
          if (categoryResponseModels.isEmpty) {
            return CustomNoDataWidget(
              key: ValueKey<String>('empty_categories_${state.hashCode}'),
              message: context.appString.noCategoriesKey,
              description: context.appString.noCategoriesDescKey,
              buttonText: context.appString.tryAgainKey,
              onButtonPressed: () async {
                await context.read<HomeCategoryCubit>().refreshCategories();
              },
            );
          }

          // ✅ Show Category Grid when data exists
          return _buildCategoryGridView(context, state);
        }

        // ✅ Show shimmer when loading
        return const ShimmerCategoryWidget();
      },
    );
  }

  /// Builds the category grid view using API data
  Widget _buildCategoryGridView(BuildContext context, HomeCategoryState state) {
    final List<CategoryResponseModel> categoryResponseModels = _getCategoryResponseModelsFromHomeState(state);

    double deviceWidth = context.width;
    const int totalHorizontalSpacing = 10 * (4 - 1); // Total spacing for 4 columns
    final double itemWidth = (deviceWidth - totalHorizontalSpacing) / Dimens.crossAxisCount4;
    const double itemHeight = Dimens.size130;

    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimens.space16,
              right: Dimens.space17,
              top: Dimens.space17,
            ),
            child: GridView.builder(
              controller: state.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: categoryResponseModels.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: itemWidth / itemHeight,
                crossAxisCount: Dimens.crossAxisCount4,
                crossAxisSpacing: Dimens.space10,
                mainAxisSpacing: Dimens.space10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return HomeCategoryItem(
                  categoryModel: categoryResponseModels[index],
                  onTap: () => _onCategoryTap(context, categoryResponseModels, index),
                );
              },
            ),
          ),
        ),
        // Loading indicator for pagination
        BlocBuilder<HomeCategoryCubit, HomeCategoryState>(
          builder: (BuildContext context, HomeCategoryState state) {
            return Visibility(
              visible: state.isLoadingMore,
              child: const CustomPaginationLoaderWidget(),
            );
          },
        ),
      ],
    );
  }

  /// Handles category tap navigation
  Future<void> _onCategoryTap(BuildContext context, List<CategoryResponseModel> categoryResponseModels, int index) async {
    if (index < categoryResponseModels.length) {
      final CategoryResponseModel categoryResponse = categoryResponseModels[index];
      final int? categoryId = categoryResponse.categoryId;
      DebugLog.instance.d('category: ${categoryResponse.categoryName} (ID: ${categoryResponse.categoryId})');


      if (categoryId != null) {
        DebugLog.instance.d('Navigating to category: ${categoryResponse.categoryName} (ID: $categoryId)');


        // Navigate to product listing page with child categories as tab labels
        await context.router.push(ProductListingWithFilterRoute(
          typeId: categoryId,
          type: ProductType.category.name,
          label: categoryResponse.categoryName,
          tabLabels: categoryResponse.childCategories,
        ));
      } else {
        DebugLog.instance.e('Category ID is null for category: ${categoryResponse.categoryName}');
      }
    }
  }


  /// Extracts category response models from HomeCategoryState for navigation
  List<CategoryResponseModel> _getCategoryResponseModelsFromHomeState(HomeCategoryState state) {
    // Use the paginated category list if available
    if (state.categoryList.isNotEmpty) {
      return state.categoryList;
    }
    
    // Fallback to API response data for backward compatibility
    if (state.status == BaseStateStatus.success &&
        state.categoriesModel?.data != null &&
        state.categoriesModel!.data!.isNotEmpty) {

      // Return main categories (not child categories)
      return state.categoriesModel!.data!;
    }

    // Return empty list if no API data is available
    return <CategoryResponseModel>[];
  }
}
