import '../../../../utils/exports.dart';
import '../../model/response/product_listing_response_model.dart';

/// A common widget for displaying product items with image, name, price,
/// quantity controls, and wishlist functionality across different screens.
class ProductCommonItem extends StatelessWidget {
  /// The product data containing image, name, price, and other product information.
  final ProductListingResponse? productListingResponse;

  /// The height of the product item widget.
  final double? heightOfItem;

  /// The width of the product item widget.
  final double? widthOfItem;

  /// Callback function when the plus button is pressed to increase quantity.
  final VoidCallback? onPlusPressed;

  /// Callback function when the minus button is pressed to decrease quantity.
  final VoidCallback? onMinusPressed;

  /// Callback function when the add to cart button is pressed.
  final VoidCallback? onAddPressed;

  /// The current quantity of this product in the cart.
  final int cartCount;

  /// Whether this product is currently in the user's wishlist.
  final bool? isWishList;

  /// Callback function when the remove from wishlist button is pressed.
  final VoidCallback? removeWishListPressed;

  /// Callback function when the like/dislike button is pressed.
  final VoidCallback? likeDislikeItemPressed;

  /// Callback function for variant-specific cart operations.
  /// Receives the variant index and the operation type.
  final Function(int variantIndex, CartOperation operation)? onVariantCartOperation;

  /// Creates a [ProductCommonItem] widget.
  ///
  /// [productListingResponse] must not be null.
  /// [cartCount] defaults to 0. [isWishList] defaults to true.
  /// Other parameters are optional.
  const ProductCommonItem({
    super.key,
    this.productListingResponse,
    this.heightOfItem,
    this.widthOfItem,
    this.onPlusPressed,
    this.onMinusPressed,
    this.cartCount = 0,
    this.onAddPressed,
    this.removeWishListPressed,
    this.isWishList = true,
    this.likeDislikeItemPressed,
    this.onVariantCartOperation,
  }) : assert(productListingResponse != null, '');

  /// Creates a [ProductCommonItem] widget from a product listing response.
  ///
  /// [productListingResponse] is required.
  /// [cartCount] defaults to 0. [isWishList] defaults to true.
  /// Other parameters are optional.
  const ProductCommonItem.fromProductListing({
    super.key,
    required this.productListingResponse,
    this.heightOfItem,
    this.widthOfItem,
    this.onPlusPressed,
    this.onMinusPressed,
    this.cartCount = 0,
    this.onAddPressed,
    this.removeWishListPressed,
    this.isWishList = true,
    this.likeDislikeItemPressed,
    this.onVariantCartOperation,
  }) : assert( productListingResponse != null, '');

  // Helper methods to get data from either model

  /// Gets the product name.
  String get productName =>  productListingResponse?.name ?? '';

  /// Gets the product image URL, preferring thumbnail over large image.
  String get productImage =>  productListingResponse?.thumbNail ?? productListingResponse?.imageLarge ?? '';

  /// Gets the original price of the product.
  double get productOriginalPrice =>  (productListingResponse?.price ?? 0).toDouble();

  /// Gets the final discounted price of the product.
  double get productPrice  =>  (productListingResponse?.finalPrice ?? 0).toDouble();

  /// Gets the unit of measurement for the product.
  String get productUnit =>  productListingResponse?.uom??"" ;

  /// Gets the product rating count parsed as an integer.
  int get productRatingCount => int.tryParse(productListingResponse?.reviewCount ?? '0') ?? 0;

  /// Gets the product rating as a double value.
  double get productRating =>  (productListingResponse?.ratings ?? 0).toDouble();

  /// Gets the discount percentage for the product.
  int get productDiscountPercentage => int.tryParse(productListingResponse?.percentOff ?? '0') ?? 0;

  /// Gets the product ID as a string.
  String get productId =>  productListingResponse?.entityId?.toString() ?? '';

  // Helper method to check if product is available based on variant available quantity
  // Only check product variants availability

  /// Checks if the product is available for purchase based on variant quantities.
  bool get isProductAvailable {
    // Check product variants availability
    if (productListingResponse?.productVariant != null && 
        productListingResponse!.productVariant!.isNotEmpty) {
      // Check if any variant has available quantity > 0
      return productListingResponse!.productVariant!.any((ProductVariantDukkan variant) =>
        (variant.availableQty ?? 0) > 0);
    }
    // If no variants, consider product as not available
    return false;
  }
  

  
  // Helper method to get total available quantity across all variants

  
  /// Helper method to get count of available variants
  int get availableVariantsCount {
    if (productListingResponse?.productVariant == null || 
        productListingResponse!.productVariant!.isEmpty) {
      return 0;
    }
    return productListingResponse!.productVariant!
        .where((ProductVariantDukkan variant) => (variant.availableQty ?? 0) > 0)
        .length;
  }
  
  /// Helper method to get cart quantity from first variant
  int get cartQuantity {
    if (productListingResponse?.productVariant != null && 
        productListingResponse!.productVariant!.isNotEmpty) {
      // Get cart quantity from first variant
      final int firstVariantQuantity = productListingResponse!.productVariant![0].cartQuantity ?? 0;
      DebugLog.instance.e('ProductCommonItem - Using first variant cart quantity: $firstVariantQuantity for product: ${productListingResponse?.name}');
      return firstVariantQuantity;
    }
    // Fallback to main product cart quantity if no variants
    final int mainProductQuantity = productListingResponse?.cartQuantity ?? 0;
    DebugLog.instance.e('ProductCommonItem - Using main product cart quantity: $mainProductQuantity for product: ${productListingResponse?.name} (no variants)');
    return mainProductQuantity;
  }
  /// Helper method to check if product is new
  bool get isFavorite => productListingResponse?.isFavorite ?? false;
  /// Helper method to check if product is new
  bool get isProductNew => productListingResponse?.isNew != null && productListingResponse!.isNew!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    double widthOfTheCell = widthOfItem ?? Dimens.widthOfTheCell;
    double heightOfTheCell = heightOfItem ?? Dimens.heightOfTheCell;
    return Stack(children: <Widget>[
      Container(
        padding: Dimens.paddingOfCell.padding,
        height: heightOfTheCell,
        width: widthOfTheCell,
        decoration: BoxDecoration(
          color: AppColors.whiteColor, // Background color
          border: Border.all(
            color: AppColors.greyBorderColor, // Border color
          ),
          borderRadius: Dimens.radius8.borderRadius, // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
              //  await context.router.push(ProductDetailsRoute(entityId: int.tryParse(productId) ?? 1));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  const SizedBox(
                    height: Dimens.size5,
                  ),
                  Visibility(
                    visible: productUnit.isNotEmpty,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      height: Dimens.size22,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space4, vertical: Dimens.space3),
                      decoration: BoxDecorationExtension.customDecoration(
                        color: MainConfig.appColors.iceBlueColor, // Background color
                        borderRadius:
                        Dimens.radius4.borderRadius, // Rounded corners
                      ),
                      child: CustomTextLabelWidget(
                        textDirection: TextDirection.ltr,
                        maxLines: Dimens.maxLines01,
                        overflow: TextOverflow.ellipsis,
                        label: productUnit,
                        style: context.textTheme.headlineMedium?.copyWith(
                            height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                            fontSize: Dimens.fontSize12,
                            color: MainConfig.appColors.mainColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.size6,
                  ),
                  SizedBox(
                    height: Dimens.size41,
                    child: TextWithMinLines(
                      textDirection: TextDirection.ltr,
                      productName,
                      maxLines: Dimens.maxLines02,
                      minLines: Dimens.maxLines02,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: getTextAlign(context),
                      style: context.textTheme.headlineMedium?.copyWith(
                          height: Dimens.lineHeight18
                              .toLineHeight(Dimens.fontSize14),
                          fontSize: Dimens.fontSize14,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Dimens.size4.heightBox,
                  CustomTextLabelWidget(
                    textDirection: TextDirection.ltr,
                    maxLines: Dimens.maxLines01,
                    overflow: TextOverflow.ellipsis,
                    label: '$productOriginalPrice ${getIt<LanguageService>().defaultCurrency}',
                    style: context.textTheme.headlineMedium?.copyWith(
                        height:
                        Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                        fontSize: Dimens.fontSize14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: Dimens.size1,
                  ),
                  Visibility(
                    visible: productPrice > 0 && productPrice != productOriginalPrice,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: SizedBox(
                      height: Dimens.size18,
                      child: Row(
                        children: <Widget>[
                          CustomTextLabelWidget(
                            textDirection: TextDirection.ltr,
                            maxLines: Dimens.maxLines01,
                            overflow: TextOverflow.ellipsis,
                              label: '$productPrice ${getIt<LanguageService>().defaultCurrency}',
                            style: context.textTheme.headlineMedium?.copyWith(
                                height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                                fontSize: Dimens.fontSize14,
                                decoration: TextDecoration.lineThrough,
                                color: MainConfig.appColors.creyColor,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: Dimens.size8,
                          ),
                          if(productDiscountPercentage>0)
                          CustomTextLabelWidget(
                            maxLines: Dimens.maxLines01,
                            overflow: TextOverflow.ellipsis,
                            label:
                            '$productDiscountPercentage % ${context.appString.oFFKey}',
                            style: context.textTheme.headlineMedium?.copyWith(
                                height: Dimens.lineHeight14
                                    .toLineHeight(Dimens.fontSize12),
                                fontSize: Dimens.fontSize12,
                                color: MainConfig.appColors.greenColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: Dimens.size3,
                  ),
                ],
              ),
            ),
            cartQuantity == 0
                ? CustomGradientButtonWidget(
                titleTextStyle: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isProductAvailable? AppColors.whiteColor: MainConfig.appColors.creyColor,
                    fontSize: Dimens.fontSize14,
                    height: Dimens.lineHeight16
                        .toLineHeight(Dimens.fontSize14)),
                height: Dimens.size32,
                isButtonEnabled: isProductAvailable,
                title: !isProductAvailable ? context.appString.outOfStockKey : context.appString.addButtonKey,
                onTap: () async {
                  // Check if there are multiple product variants
                  if (productListingResponse?.productVariant != null && 
                      productListingResponse!.productVariant!.length > 1) {
                    // Show SelectUnit bottom sheet for multiple variants

                  } else {
                    // Call original onAddPressed for single variant or no variants
                    onAddPressed?.call();
                  }
                })
                : ProductCommonQtyButton(
              cartQty: cartQuantity,
              onMinusPressed: onMinusPressed,
              onPlusPressed: onPlusPressed,
            )
            //
          ],
        ),
      ),
      // NEW indicator - conditionally displayed based on backend data
      Visibility(
        visible: isProductNew,
        child: Positioned(
          top: -2,
          child: ProductCommonNewWidget(label: productListingResponse?.isNew),
        ),
      ),
    ]);
  }
}