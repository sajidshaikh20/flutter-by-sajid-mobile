import '../../../../utils/exports.dart';

/// A widget that displays a section of products on the home or cart page.
///
/// The section has a [headerText] title and a list of [ProductListingResponse]s
/// to display. It can also use [state] to access cart or UI-specific information.
class ProductSectionWidget extends StatelessWidget {
  /// The title text for the product section.
  final String headerText;

  /// The list of products to display in this section.
  final List<ProductListingResponse> products;

  /// The current cart page state used to determine UI interactions.
  final BaseStateStatus state;

  /// Whether this section represents Deals (true) or You May Also Like (false)
  final bool isDealsSection;

  /// The type of deals section (e.g., 'bestDeals', 'youMayAlsoLike')
  final String? dealsType;

  /// Creates a [ProductSectionWidget] instance.
  const ProductSectionWidget({
    super.key,
    required this.headerText,
    required this.products,
    required this.state,
    required this.isDealsSection,
    this.dealsType,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Dimens.size24.heightBox,
       state==BaseStateStatus.success ? HeaderWidget(

          mainHeader: headerText,
          viewAll: context.appString.viewAllKey,
          viewAllOnclick: () async {
            // Handle navigation based on deal type
            if (isDealsSection && dealsType != null) {
              // For deals section, use the specific deal type
              List<CategoryResponseModel> listCategoryAll = <CategoryResponseModel>[
                CategoryResponseModel(categoryName: context.appString.allKey),


              ];
              await context.router.push(ProductListingWithFilterRoute(
                type: dealsType!,
                label: headerText,
                tabLabels: listCategoryAll,
              ));
            } else if (!isDealsSection && dealsType != null) {
              // For "You May Also Like" section, use the specific deal type
              List<CategoryResponseModel> listCategoryAll = <CategoryResponseModel>[
                CategoryResponseModel(categoryName: context.appString.allKey),
              ];
              await context.router.push(ProductListingWithFilterRoute(
                type: dealsType!,
                label: headerText,
                tabLabels: listCategoryAll,
              ));
            } else {
              // For other sections, use default navigation
              await context.router.push(ProductListingWithFilterRoute(
                typeId: 0, // All products
                type: 'all',
                label: headerText,
              ));
            }
          },
          isPaddingNeed: true,
        ): const HeaderWidgetShimmer(),
        Dimens.size16.heightBox,
        state==BaseStateStatus.success ? HotDealsWidget(
          products: products,
          onAddPressed: (int index) async {
            await context.read<CartPageCubit>().handleCartOperationForDeals(
              productIndex: index,
              isDealsSection: isDealsSection,
              operation: CartOperation.add,
            );
          },
          onPlusPressed: (int index) async {
            await context.read<CartPageCubit>().handleCartOperationForDeals(
              productIndex: index,
              isDealsSection: isDealsSection,
              operation: CartOperation.increase,
            );
          },
          onMinusPressed: (int index) async {
            await context.read<CartPageCubit>().handleCartOperationForDeals(
              productIndex: index,
              isDealsSection: isDealsSection,
              operation: CartOperation.decrease,
            );
          },
          likeDislikeItemPressed: (int index) async {
            final ProductListingResponse product = products[index];
            if (product.sku != null) {
              await context.read<CartPageCubit>().handleWishlistLikeDislikeForDeals(
                sku: product.sku!,
                productIndex: index,
                isCurrentlyFavorite: product.isFavorite ?? false,
                isDealsSection: isDealsSection,
              );
            }
          },
          onVariantCartOperation: (int productIndex, int variantIndex, CartOperation operation) async {
            await context.read<CartPageCubit>().handleCartOperationForDeals(
              productIndex: productIndex,
              isDealsSection: isDealsSection,
              operation: operation,
              variantIndex: variantIndex,
            );
          },
        ): const HotDealsShimmer(),

      ],
    );
  }
}
