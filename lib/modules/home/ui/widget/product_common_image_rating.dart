import '../../../../utils/exports.dart';

/// A widget that displays a product image with rating, wishlist functionality,
/// and interactive elements for product browsing.
class ProductCommonImageRating extends StatelessWidget {
  /// The product data containing image, rating, and other product information.
  final ProductListingResponse? productListingResponse;

  /// The size (width and height) of the product image to display.
  final double sizeOfTheImage;

  /// Whether this product is currently in the user's wishlist.
  final bool? isWishList;

  /// Callback function when the remove from wishlist button is pressed.
  final VoidCallback? removeWishListPressed;

  /// Callback function when the like/dislike button is pressed.
  final VoidCallback? likeDislikeItemPressed;

  /// Creates a [ProductCommonImageRating] widget.
  ///
  /// [sizeOfTheImage] is required. [productListingResponse] must not be null.
  /// Other parameters are optional.
  const ProductCommonImageRating({
    super.key,
    this.productListingResponse,
    required this.sizeOfTheImage,
    this.isWishList,
    this.removeWishListPressed,
    this.likeDislikeItemPressed,
  }) : assert(productListingResponse != null, '');

  /// Creates a [ProductCommonImageRating] widget from a product listing response.
  ///
  /// [productListingResponse] and [sizeOfTheImage] are required.
  /// Other parameters are optional.
  const ProductCommonImageRating.fromProductListing({
    super.key,
    required this.productListingResponse,
    required this.sizeOfTheImage,
    this.isWishList,
    this.removeWishListPressed,
    this.likeDislikeItemPressed,
  }) : assert(productListingResponse != null, '');

  // Helper methods to get data from either model

  /// Gets the product image URL, preferring thumbnail over large image.
  String get productImage =>
      productListingResponse?.thumbNail ??
      productListingResponse?.imageLarge ??
      '';

  /// Gets the product rating as a double value.
  double get productRating => (productListingResponse?.ratings ?? 0).toDouble();

  /// Gets the product rating count parsed as an integer.
  int get productRatingCount =>
      int.tryParse(productListingResponse?.reviewCount ?? '0') ?? 0;

  /// Checks if the product is available for purchase.
  bool get isProductAvailable => productListingResponse?.isAvailable ?? true;

  /// Checks if the product is marked as favorite by the user.
  bool get isFavorite => productListingResponse?.isFavorite ?? false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            // Background color
            borderRadius: Dimens.radius6.borderRadius, // Rounded corners
          ),
          height: sizeOfTheImage,
          width: sizeOfTheImage,
          child: Stack(
            children: <Widget>[
              CustomNetworkImageWidget(
                imageUrl: productImage,
                fit: BoxFit.fill,
                placeHolderImage: Assets.svgs.icPlaceHolderDukkan.svg(
                  width: Dimens.size200
                ),
                isShowPlaceHolder: true,
              ),
              isWishList ?? false
                  ? Padding(
                padding: Dimens.space8.padding,
                child: Align(
                  alignment: context.isEnglishLanguage
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: GestureDetector(
                    onTap: likeDislikeItemPressed,
                    child: isFavorite
                        ? Assets.svgs.icWishlistSelected.svg(
                        height: Dimens.size18, width: Dimens.size18)
                        : Assets.svgs.icWishlistUnselected.svg(
                        height: Dimens.size18, width: Dimens.size18),
                  ),
                ),
              )
                  : Padding(
                      padding: Dimens.space8.padding,
                      child: Align(
                          alignment: context.isEnglishLanguage
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: removeWishListPressed,
                            child: Container(
                                padding: const EdgeInsets.all(Dimens.space6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.blackColor
                                      .withValues(alpha:Dimens.opacity08),
                                ),
                                child: Assets.svgs.icDCros.svg()),
                          )),
                    ),

              if(productRatingCount>0)
              CommonRatingWidget(
                rating: productRating,
                ratingCount: productRatingCount,
              ),
              // OUT OF STOCK overlay
              Visibility(
                visible: !isProductAvailable,
                child: Container(
                  width: sizeOfTheImage,
                  height: sizeOfTheImage,
                  decoration: BoxDecoration(
                    color: AppColors.blackColor.withValues(alpha:0.23),
                    borderRadius: Dimens.radius6.borderRadius,
                  ),
                  child: Align(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space11, vertical: Dimens.space2),
                      height: Dimens.space23,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.space3),
                          color: AppColors.blackColor.withValues(alpha:0.73)),
                      child: CustomTextLabelWidget(
                        label: context.appString.outOfStockKey,
                        style: context.textTheme.headlineMedium?.copyWith(
                            fontSize: Dimens.space14,
                            color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
