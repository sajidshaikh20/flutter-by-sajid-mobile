import '../../../../utils/exports.dart';

/// Widget that displays product name with wishlist functionality.
class ProductDetailsNameWidget extends StatelessWidget {
  /// Callback function called when wishlist button is tapped.
  final Future<void> Function()? onWishlistTap;

  /// Whether the product is currently in the wishlist.
  final bool isWishlistSelected;

  /// The name of the product to display.
  final String? productName;

  /// Whether the widget is in a loading state.
  final bool isLoading;

  /// Creates a product details name widget with wishlist functionality.
  const ProductDetailsNameWidget({
    super.key,
    this.onWishlistTap,
    this.isWishlistSelected = false,
    this.productName,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: CustomTextLabelWidget(
            maxLines: Dimens.maxLines03,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            label: productName ?? "",
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: Dimens.fontSize18,
              height: Dimens.lineHeight22.toLineHeight(Dimens.fontSize18),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: context.isEnglishLanguage ? Dimens.space30 : Dimens.space0),
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: isLoading ? null : () async {
                if (onWishlistTap != null) {
                  await onWishlistTap!();
                }
              },
              child: isWishlistSelected
                      ? Assets.svgs.icWishlistSelected.svg()
                      : Assets.svgs.icWishlistUnselected.svg()),
        )
      ],
    );
  }
}
