import '../../../utils/exports.dart';

/// A custom timeline tile widget for displaying order tracking events.
class MyTimelineTile extends StatelessWidget {
  /// Creates a timeline tile for order tracking.
  const MyTimelineTile({
    required this.isFirst,
    required this.isLast,
    required this.isBeforeLinePast, // New flag for before line styling
    required this.isAfterLinePast, // New flag for after line styling
    required this.isTopCirclePast, // New flag for the top indicator
    required this.child,
    this.device = ScreenType.mobile,
    super.key,
  });

  /// The screen type for responsive design.
  final ScreenType device;

  /// Whether this is the first tile in the timeline.
  final bool isFirst;

  /// Whether this is the last tile in the timeline.
  final bool isLast;

  /// Whether the line before this tile represents a past event.
  final bool isBeforeLinePast;

  /// Whether the line after this tile represents a past event.
  final bool isAfterLinePast;

  /// Whether the top circle indicator represents a past event.
  final bool isTopCirclePast;

  /// The child widget to display in the timeline tile.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isBeforeLinePast
              ? MainConfig.appColors.mainColor
              : MainConfig.appColors.imageBgColor,
          thickness: Dimens.thick1,
        ),
        afterLineStyle: LineStyle(
          color: isAfterLinePast
              ? MainConfig.appColors.mainColor
              : MainConfig.appColors.imageBgColor,
          thickness: Dimens.thick1,
        ),
        indicatorStyle: IndicatorStyle(
          width: Dimens.size37,
          height: Dimens.size37, // Indicator container size
          indicator: Container(
            height: Dimens.size37,
            width: Dimens.size37,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isTopCirclePast
                  ? MainConfig.appColors.mainColor
                  : MainConfig.appColors.dukkanborderGreyLightColor,
            ),
            child: Center(
              child: Visibility(
                visible: isTopCirclePast,
                child: Assets.svgs.icRightDvg
                    .svg(width: Dimens.size20, height: Dimens.size14),
              ),
            ),
          ),
        ),
        endChild: EventCard(device: device, child: child),
      ),
    );
  }
}
