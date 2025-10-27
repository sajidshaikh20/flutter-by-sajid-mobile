 // Ensure this imports Dimens, AppColors, and ScreenType

import '../../../../../utils/exports.dart';

/// [HeaderWidgetShimmer] is a stateless widget that provides a shimmer effect for
/// the header section of the home screen while content is loading.
class HeaderWidgetShimmer extends StatelessWidget {
  /// Determines if padding should be applied around the header.
  final bool isPaddingNeed;

  /// The type of device being used, affects the dimensions and layout.
  final ScreenType? device;

  /// Determines if the "View All" section should be visible.
  final bool isViewAllVisible;

  /// Creates a [HeaderWidgetShimmer] instance.
  ///
  /// [isPaddingNeed] specifies whether to apply padding around the header. Defaults to true.
  ///
  /// [device] specifies the type of device. Defaults to mobile.
  ///
  /// [isViewAllVisible] specifies whether the "View All" section should be visible.
  /// Defaults to true.
  const HeaderWidgetShimmer({
    super.key,
    this.isPaddingNeed = true,
    this.device = ScreenType.mobile,
    this.isViewAllVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    // Define default dimensions
    double headerFontSize = Dimens.fontSize18;
    double viewAllFontSize = Dimens.size14;
    double spaceLeft = Dimens.space16;
    double spaceRight = Dimens.space17;

    // Adjust values for tablet devices
    switch (device) {
      case ScreenType.tablet:
        spaceLeft = Dimens.space24;
        headerFontSize = Dimens.fontSize24;
        viewAllFontSize = Dimens.fontSize17;
        spaceRight = Dimens.space26;

      default:
        break;
    }

    // Placeholder widths can be adjusted as needed.
    const double headerPlaceholderWidth = Dimens.size120;
    const double viewAllPlaceholderWidth = Dimens.size60;

    // Define shimmer colors.
    final Color baseColor = Colors.grey.shade300;
    final Color highlightColor = Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: isPaddingNeed
            ? EdgeInsets.only(left: spaceLeft, right: spaceRight)
            : EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Simulated main header text placeholder
            Container(
              width: headerPlaceholderWidth,
              height: headerFontSize,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: Dimens.radius4.borderRadius , // adjust radius as needed
              ),
            ),
            // Simulated "View All" text placeholder
            if (isViewAllVisible)
              Container(
                width: viewAllPlaceholderWidth,
                height: viewAllFontSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: Dimens.radius4.borderRadius,
                ),
              ),
          ],
        ),
      ),
    );
  }
}