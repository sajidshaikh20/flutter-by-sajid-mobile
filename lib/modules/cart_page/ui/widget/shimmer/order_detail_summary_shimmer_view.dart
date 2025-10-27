import '../../../../../utils/exports.dart';

/// A placeholder shimmer widget displayed for the order summary section
/// while loading order details.
///
/// This widget can be used on both cart and checkout screens and optionally
/// shows a shimmer for discounts based on [showDiscount].
///
/// The [device] parameter can be used to adjust the layout for mobile, tablet, or desktop.
class OrderDetailSummaryShimmerView extends StatelessWidget {
  /// Indicates if the shimmer is being shown on the cart screen.
  final bool isFromCartScreen;

  /// Whether to show the discount section in the shimmer.
  final bool showDiscount;

  /// The device type for responsive layout adjustments.
  final ScreenType device;

  /// Creates an [OrderDetailSummaryShimmerView] instance.
  const OrderDetailSummaryShimmerView({
    super.key,
    this.isFromCartScreen = false,
    this.showDiscount = false,
    this.device = ScreenType.mobile,
  });
  @override
  Widget build(BuildContext context) {
    double height = Dimens.space8;
    double bottomPadding = Dimens.space16;

    // Instead of InkWell, we just show a Container for the shimmer skeleton
    return ShimmerEffect(

      child: Container(
        // Mimic the same padding logic
        padding: isFromCartScreen
            ? EdgeInsets.symmetric(horizontal: bottomPadding)
            : EdgeInsets.all(height), // height.padding => EdgeInsets.all(height)

        decoration: isFromCartScreen
            ? null
            : BoxDecorationExtension.customDecoration(
                borderRadius: Dimens.radius8.borderRadius,
                border: Border.all(
                  color: MainConfig.appColors.lightGreyColor,
                  width: Dimens.borderWidth05,
                ),
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1) "Order Summary" placeholder if not from cart screen
            if (!isFromCartScreen)
              Container(
                width: Dimens.size120,
                height: Dimens.size16,
                color: Colors.white,
              ),
            if (!isFromCartScreen) const SizedBox(height: Dimens.size17),

            // 2) Four lines for Subtotal, Shipping, Tax, GrandTotal
            // Each line is effectively an "OrderDetailSummaryItemView" placeholder
            // a. Subtotal
            Container(
              height: Dimens.size14,
              margin: const EdgeInsets.only(bottom: Dimens.size9),
              color: Colors.white,
            ),
            // b. Shipping
            Container(
              height: Dimens.size14,
              margin: const EdgeInsets.only(bottom: Dimens.size9),
              color: Colors.white,
            ),
            // c. Tax
            Container(
              height: Dimens.size14,
              margin: const EdgeInsets.only(bottom: Dimens.size13),
              color: Colors.white,
            ),
            // d. Grand Total
            Container(
              height: Dimens.size16, // grand total slightly bigger
              color: Colors.white,
            ),
            // spacing after grand total
            const SizedBox(height: Dimens.size7),

            // 3) Discount Container if showDiscount is true
            if (showDiscount)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: Dimens.space12,
                ),
                decoration: BoxDecorationExtension.customDecoration(
                  color: MainConfig.appColors.lightGreen,
                  borderRadius: Dimens.radius8.borderRadius,
                ),
                child: Container(
                  // text placeholder
                  width: Dimens.size120,
                  height: Dimens.size14,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}