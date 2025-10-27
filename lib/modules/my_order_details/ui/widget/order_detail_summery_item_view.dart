import '../../../../utils/exports.dart';

/// A widget that displays a summary item in an order detail view.
///
/// This widget shows a [title] on the left and a [price] on the right,
/// with optional custom text styles and responsive font sizing based on
/// the device type ([ScreenType]).
class OrderDetailSummaryItemView extends StatelessWidget {
  /// The title text to display on the left.
  final String title;

  /// The price text to display on the right.
  final String price;

  /// Optional custom text style for the [title].
  final TextStyle? titleStyle;

  /// Optional custom text style for the [price].
  final TextStyle? priceStyle;

  /// The type of device to adjust styling (e.g., font size) accordingly.
  ///
  /// Defaults to [ScreenType.mobile].
  final ScreenType device;

  /// Creates an [OrderDetailSummaryItemView].
  ///
  /// The [title] and [price] are required. Optional [titleStyle], [priceStyle],
  /// and [device] can be provided for customization.
  const OrderDetailSummaryItemView({
    super.key,
    required this.title,
    required this.price,
    this.titleStyle,
    this.priceStyle,
    this.device = ScreenType.mobile,
  });

  @override
  Widget build(BuildContext context) {
    // Default font size for mobile.
    double fontSizeMobTab14_20 = Dimens.fontSize14;

    // Adjust font size for tablet devices.
    switch (device) {
      case ScreenType.tablet:
        fontSizeMobTab14_20 = Dimens.fontSize20;
      default:
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: CustomTextLabelWidget(
            maxLines: Dimens.maxLines01,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            label: title,
            style: titleStyle ??
                context.textTheme.bodySmall?.copyWith(
                  fontSize: fontSizeMobTab14_20,
                  fontWeight: FontWeight.w600,
                  height: Dimens.lineHeight18
                      .toLineHeight(fontSizeMobTab14_20),
                  color: MainConfig.appColors.textBlackColor,
                ),
          ),
        ),
        CustomTextLabelWidget(
          textDirection: TextDirection.ltr,
          label: price,
          style: priceStyle ??
              context.textTheme.headlineMedium?.copyWith(
                  fontSize: fontSizeMobTab14_20,
                  height: Dimens.lineHeight26
                      .toLineHeight(fontSizeMobTab14_20),
                  color: MainConfig.appColors.textColorGreyBlack,
                  fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
