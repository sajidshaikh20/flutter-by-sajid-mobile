import '../../../../utils/exports.dart';
/// A widget that displays a tappable row with a share icon and optional label text.
///
/// This widget is commonly used to represent a share action in a product or content
/// details page. It supports different layouts for mobile and web based on [device].
///
/// Example usage:
/// ```dart
/// ShareIconFreeTextRow(
///   label: 'Share Product',
///   onTap: () => print('Share clicked'),
///   device: ScreenType.web,
/// )
/// ```
class ShareIconFreeTextRow extends StatelessWidget {
  /// The optional text label displayed next to the share icon.
  final String? label;

  /// The callback that is triggered when the row is tapped.
  final VoidCallback? onTap;

  /// The type of screen the widget is being displayed on.
  ///
  /// Used to adjust spacing, font size, or layout depending on whether
  /// it’s rendered on mobile, tablet, or web.
  final ScreenType device;

  /// Creates a [ShareIconFreeTextRow].
  const ShareIconFreeTextRow({
    super.key,
    this.label,
    this.onTap,
    this.device = ScreenType.mobile,
  });

  @override
  Widget build(BuildContext context) {
    double productFontSize=Dimens.fontSize18;
    double shareIconSize=Dimens.size24;

    switch(device){

      case ScreenType.tablet:
         productFontSize=Dimens.fontSize25;
         shareIconSize=Dimens.size30;

      default:
        break;
    }
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomTextLabelWidget(
            maxLines: Dimens.maxLines02,
            overflow: TextOverflow.ellipsis,
            label: label ?? '',
            style: context.textTheme.headlineMedium?.copyWith(
              fontSize: productFontSize,
              color: MainConfig.appColors.textColorGreyBlack,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Dimens.size18.widthBox,
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: Dimens.space7.padding,
            child:  Assets.svgs.icShareIcon.svg(
              height: shareIconSize,
              width: shareIconSize,
            ) ,
          ),
        ),
      ],
    );
  }
}
