import '../../../../utils/exports.dart';

/// A widget that represents a single timeline entry,
/// typically used to display order or process updates
/// with status, details, time, and date.
class EachTimeLine extends StatelessWidget {
  /// Creates an instance of [EachTimeLine].
  ///
  /// The [status], [statusDetails], [statusTime], and [statusDate]
  /// parameters are required and represent the content of the timeline entry.
  ///
  /// The [device] parameter determines the screen type
  /// (e.g., mobile, tablet, or web) and defaults to [ScreenType.mobile].
  const EachTimeLine({
    required this.status,
    required this.statusDetails,
    required this.statusTime,
    required this.statusDate,
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The current status label for this timeline entry
  /// (e.g., “Order Placed”, “Shipped”, “Delivered”).
  final String status;

  /// Additional details or description about the [status].
  final String statusDetails;

  /// The time at which this [status] occurred.
  final String statusTime;

  /// The date on which this [status] occurred.
  final String statusDate;

  /// Defines the type of device on which this widget is rendered.
  /// Defaults to [ScreenType.mobile].
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomTextLabelWidget(
              label: status,
              style: context.textTheme.titleMedium?.copyWith(
                height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                fontSize: Dimens.fontSize14,
                fontWeight: FontWeight.w700,
                color: MainConfig.appColors.backgroundBlackColor,
              ),
            ),
            Row(

              children: <Widget>[
                statusTime.isEmpty ? const SizedBox.shrink(): Assets.svgs.icClock
                    .svg(width: Dimens.size14, height: Dimens.size14),
                Dimens.size3.widthBox,
                CustomTextLabelWidget(
                  textDirection: TextDirection.ltr,
                  label: statusTime,
                  style: context.textTheme.titleMedium?.copyWith(
                    height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                    fontSize: Dimens.fontSize12,
                    fontWeight: FontWeight.w400,
                    color: MainConfig.appColors.creyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        Dimens.size8.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomTextLabelWidget(
              label: statusDetails,
              style: context.textTheme.titleMedium?.copyWith(
                height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w400,
                color: MainConfig.appColors.creyColor,
              ),
            ),
            CustomTextLabelWidget(
              textDirection: TextDirection.ltr,
              label: statusDate,
              style: context.textTheme.titleMedium?.copyWith(
                height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w700,
                color: MainConfig.appColors.backgroundBlackColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
