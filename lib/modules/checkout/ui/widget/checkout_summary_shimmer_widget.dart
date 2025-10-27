import '../../../../utils/exports.dart';

/// A widget that displays a shimmer effect for the checkout summary section.
/// This widget is typically used as a placeholder while data is loading.
class CheckoutSummaryShimmerWidget extends StatelessWidget {
  /// Constructor for the `CheckoutSummaryShimmerWidget` widget.
  const CheckoutSummaryShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Returns a shimmer effect wrapped with padding and a column
    // of placeholder containers
    return ShimmerEffect(
      child: Padding(
        padding: Dimens.space10.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Placeholder for the first item in the summary
             CommonContainer(
              padding: EdgeInsets.zero,
              height: Dimens.space20,
              width: Dimens.space80,
              backgroundColor: MainConfig.appColors.backgroundWhiteColor,
            ),
            Dimens.space12.heightBox,
            // Placeholder for the second item in the summary
             CommonContainer(
              padding: EdgeInsets.zero,
              height: Dimens.space10,
              width: double.maxFinite,
              backgroundColor: MainConfig.appColors.backgroundWhiteColor,
            ),
            Dimens.space12.heightBox,
            // Placeholder for the third item in the summary
             CommonContainer(
              padding: EdgeInsets.zero,
              height: Dimens.space10,
              width: double.maxFinite,
              backgroundColor: MainConfig.appColors.backgroundWhiteColor,
            ),
            Dimens.space12.heightBox,
            // Placeholder for the fourth item in the summary
             CommonContainer(
              padding: EdgeInsets.zero,
              height: Dimens.space10,
              width: double.maxFinite,
              backgroundColor: MainConfig.appColors.backgroundWhiteColor,
            ),
            Dimens.space10.heightBox,
          ],
        ),
      ),
    );
  }
}
