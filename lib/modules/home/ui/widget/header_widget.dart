import '../../../../utils/exports.dart';

/// Widget that displays a header with main title and optional view all functionality.
class HeaderWidget extends StatelessWidget {
  /// The main header text to display.
  final String? mainHeader;

  /// The text for the view all button.
  final String? viewAll;

  /// Whether padding is needed around the widget.
  final bool? isPaddingNeed;

  /// Callback function when view all is clicked.
  final Function()? viewAllOnclick;

  /// The screen type for responsive design.
  final ScreenType? device;

  /// Whether the view all button should be visible.
  final bool? isViewAllVisible;

  /// Creates a header widget.
  ///
  /// [mainHeader] The main header text to display.
  /// [viewAll] The text for the view all button.
  /// [isPaddingNeed] Whether padding is needed around the widget.
  /// [viewAllOnclick] Callback function when view all is clicked.
  /// [device] The screen type for responsive design.
  /// [isViewAllVisible] Whether the view all button should be visible.
  const HeaderWidget({
    super.key,
    this.mainHeader,
    this.viewAll,
    this.isPaddingNeed,
    this.viewAllOnclick,
    this.isViewAllVisible=true,
    this.device =ScreenType.mobile

  });

  @override
  Widget build(BuildContext context) {
    double headerFontSize=Dimens.fontSize18;
    double viewAllFontSize=Dimens.size14;
    double spaceMobTab1624=Dimens.space16;
    double spaceMobTab1726=Dimens.space17;
    double lineHeightMobTab1826=Dimens.lineHeight18;
    double lineHeightMobTab2230=Dimens.lineHeight22;

    switch(device){
      case ScreenType.tablet:
        spaceMobTab1624=Dimens.space24;
        headerFontSize=Dimens.fontSize24;
        viewAllFontSize=Dimens.fontSize17;
        spaceMobTab1726=Dimens.space26;
         lineHeightMobTab1826=Dimens.lineHeight26;
         lineHeightMobTab2230=Dimens.lineHeight30;

      default:
        break;
    }
    return Padding(
      padding: isPaddingNeed ?? true
          ?   EdgeInsets.only(left: spaceMobTab1624,right: spaceMobTab1726)
          : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomTextLabelWidget(
            label: mainHeader ?? '',
            style: context.textTheme.headlineMedium?.copyWith(
              height: lineHeightMobTab2230.toLineHeight(headerFontSize),
                fontSize: headerFontSize, color: AppColors.blackColor,fontWeight: FontWeight.bold),
          ),
          Visibility(
            visible: isViewAllVisible ?? false,
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              splashColor: MainConfig.appColors.transparent,
              highlightColor: MainConfig.appColors.transparent,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              onTap: viewAllOnclick,
              child: CustomTextLabelWidget(
                label: viewAll ?? '',
                style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                    fontSize: viewAllFontSize,
                    height: lineHeightMobTab1826.toLineHeight(viewAllFontSize),
                    color: MainConfig.appColors.mainColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
