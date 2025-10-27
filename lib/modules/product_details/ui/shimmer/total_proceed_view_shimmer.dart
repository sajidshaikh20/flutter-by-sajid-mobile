import '../../../../utils/exports.dart';

/// Shimmer version of the TotalProceedView widget.
class TotalProceedViewShimmer extends StatelessWidget {
  /// The screen type for responsive design.
  final ScreenType device;

  /// Creates a shimmer loading widget for total proceed view.
  const TotalProceedViewShimmer({
    super.key,
    this.device = ScreenType.mobile,
  });

  @override
  Widget build(BuildContext context) {
    double btnHeight = Dimens.size44;
    EdgeInsets commonContainerPadding = const EdgeInsets.symmetric(
      vertical: Dimens.space7,
      horizontal: Dimens.space16,
    );

    // Adjust dimensions for tablet devices.
    if (device == ScreenType.tablet) {
      btnHeight = Dimens.size87;
      commonContainerPadding = const EdgeInsets.only(
        top: Dimens.space10,
        bottom: Dimens.space10,
        right: Dimens.space26,
        left: Dimens.space26,
      );
    }

    return Container(
      height: Dimens.size88,
      padding: commonContainerPadding,
      decoration: BoxDecoration(
        color: MainConfig.appColors.backgroundWhite,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha:Dimens.opacity025),
            offset: const Offset(1, 0),
            blurRadius: Dimens.blurRadius4,
          ),
        ],
      ),
      child: ShimmerEffectWidget(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Placeholder for ProceedViewWidget.
            Container(
              width: Dimens.size60,
              height: Dimens.size20,
              color: Colors.white,
            ),
            const SizedBox(width: Dimens.space16),
            // Placeholder for the checkout/quantity button.
            Expanded(
              child: Container(
                height: btnHeight,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
