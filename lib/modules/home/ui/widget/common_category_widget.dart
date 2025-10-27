
import '../../../../utils/exports.dart';

/// A reusable widget that displays categories in a grid layout with customizable
/// spacing and scroll physics for different screen requirements.
class CommonCategoryWidget extends StatelessWidget {
  /// The spacing between items along the cross axis (horizontal spacing).
  final double crossAxisSpacing;

  /// The spacing between items along the main axis (vertical spacing).
  final double mainAxisSpacing;

  /// The scroll physics to use for the grid view.
  final ScrollPhysics? physics;

  /// Whether the grid should shrink-wrap its contents.
  final bool shrinkWrap;

  /// Creates a [CommonCategoryWidget].
  ///
  /// [crossAxisSpacing] and [mainAxisSpacing] default to [Dimens.space10].
  /// [shrinkWrap] defaults to true. [physics] is optional.
  const CommonCategoryWidget({
    super.key,
    this.crossAxisSpacing = Dimens.space10,
    this.mainAxisSpacing = Dimens.space10,
    this.physics,
    this.shrinkWrap = true,
  });


  @override
  Widget build(BuildContext context) {
   double deviceWidth=context.width;
    // Calculate the width of each item
    const int totalHorizontalSpacing = 10 * (4 - 1); // Total spacing for 4 columns
    final double itemWidth =
        (deviceWidth - totalHorizontalSpacing) / Dimens.crossAxisCount4; // Width of each item
   const double itemHeight = Dimens.size130;
   
   return BlocBuilder<HomeCubit, HomeState>(
     buildWhen: (HomeState previous, HomeState current) {
       // Only rebuild when category API status or categories data changes
       return previous.apiCallForHomeCategory != current.apiCallForHomeCategory ||
              previous.categoriesModel != current.categoriesModel;
     },
     builder: (BuildContext context, HomeState state) {
       // Get categories from HomeCubit state
       final List<CategoryResponseModel> categoryResponseModels = _getCategoryResponseModelsFromHomeState(state);
       
       return GridView.builder(
         shrinkWrap: true,
         physics: physics?? const NeverScrollableScrollPhysics(),
         padding: EdgeInsets.zero,
         itemCount: categoryResponseModels.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           childAspectRatio: itemWidth / itemHeight,
           crossAxisCount: Dimens.crossAxisCount4, // Fixed number of columns
           crossAxisSpacing: crossAxisSpacing,
           mainAxisSpacing: mainAxisSpacing, // Vertical space between items
         ),
         itemBuilder: (BuildContext context, int index) {
           return HomeCategoryItem(
             categoryModel: categoryResponseModels[index],
             onTap: () => _onCategoryTap(context, categoryResponseModels, index),
           );
         },
       );
     },
   );
  }

  /// Handles category tap navigation
  Future<void> _onCategoryTap(BuildContext context, List<CategoryResponseModel> categoryResponseModels, int index) async {
    if (index < categoryResponseModels.length) {
      final CategoryResponseModel categoryResponse = categoryResponseModels[index];
      final int? categoryId = categoryResponse.categoryId;
      
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



  /// Extracts category response models from HomeCubit state for navigation
  List<CategoryResponseModel> _getCategoryResponseModelsFromHomeState(HomeState state) {
    // Check if categories are loaded from API
    if (state.apiCallForHomeCategory == BaseStateStatus.success && 
        state.categoriesModel != null &&
        state.categoriesModel!.isNotEmpty) {
      
      // Return main categories (not child categories)
      return state.categoriesModel!;
    }
    
    // Return empty list if no API data is available
    return <CategoryResponseModel>[];
  }
}


