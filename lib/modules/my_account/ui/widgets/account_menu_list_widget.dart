import '../../../../utils/exports.dart';

/// A widget representing an item in the account menu list.
class AccountMenuListItemWidget extends StatelessWidget {
  /// Creates an [AccountMenuListItemWidget].
  ///
  /// The [title] parameter is required and represents the title of the menu item.
  ///
  /// The [isCountryIconAvailable], [isCountryImageUrlAvailable], and
  /// [isLanguageOrCurrencyAvailable] are flags to indicate the availability of
  /// corresponding elements.
  ///
  /// [countryImage] is the URL of the country image, [languageOrCurrencyName] is the
  /// name of the language or currency, [icon] is the SVG icon, and [titleStyle] is the
  /// style for the title.
  ///
  /// The [device] parameter specifies the screen type (e.g., mobile or tablet)
  /// to adjust the UI accordingly. It defaults to [ScreenType.mobile].
  ///
  const AccountMenuListItemWidget({
    super.key,
    required this.title,
    this.isCountryIconAvailable = false,
    this.isCountryImageUrlAvailable = false,
    this.isLanguageOrCurrencyAvailable = false,
    this.countryImage,
    this.languageOrCurrencyName,
    this.icon,
    this.titleStyle,
    this.device=ScreenType.mobile
  });

  /// The title of the menu item.
  final String title;

  /// Indicates if a country icon is available.
  final bool isCountryIconAvailable;

  /// Indicates if a country image URL is available.
  final bool isCountryImageUrlAvailable;

  /// Indicates if a language or currency name is available.
  final bool isLanguageOrCurrencyAvailable;

  /// The URL of the country image.
  final String? countryImage;

  /// The SVG icon.
  final SvgGenImage? icon;

  /// The style for the title.
  final TextStyle? titleStyle;

  /// The name of the language or currency.
  final String? languageOrCurrencyName;

  /// The type of the device, which can be used to adjust the UI.
  ///
  /// Defaults to [ScreenType.mobile].

  final ScreenType device;

  @override
  Widget build(BuildContext context) {

   double leftPadding= Dimens.space16;
    double rightPadding= Dimens.space12;
    double  topPadding= isCountryImageUrlAvailable ?Dimens.space8 :Dimens.space10;
    double bottomPadding= isCountryImageUrlAvailable?Dimens.space8 :Dimens.space10;
    double titleFontSize=Dimens.fontSize16;
   double languageOrCurrencyFontSize=Dimens.fontSize14;
   double arrowSize=Dimens.size24;
   double countryImageHeight=Dimens.size32;
   double countryImageWidth= Dimens.size52;
   double radius= Dimens.radius5;
   double widthMobTab20_30=Dimens.size20;
    switch(device){

      case ScreenType.tablet:
         leftPadding= Dimens.space30;
         rightPadding= Dimens.space18;
          topPadding= isCountryImageUrlAvailable ?Dimens.space12 :Dimens.space15;
         bottomPadding= isCountryImageUrlAvailable ?Dimens.space12 :Dimens.space15;
         titleFontSize=Dimens.fontSize22;
         languageOrCurrencyFontSize=Dimens.fontSize20;
         arrowSize=Dimens.size30;
         countryImageHeight=Dimens.size42;
         countryImageWidth= Dimens.size72;
         radius= Dimens.radius8;
         widthMobTab20_30=Dimens.size30;

      default:
        break;
    }
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: leftPadding,
        right: rightPadding,
        top: topPadding,
        bottom: bottomPadding,
      ),
      color: MainConfig.appColors.backgroundWhiteColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: CustomTextLabelWidget(
              label: title,
              textAlign: isLanguageAlignmentLTR
                  ? TextAlign.left
                  : TextAlign.right,
              style: titleStyle ??
                  context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: titleFontSize,
                    color: MainConfig.appColors.textMediumDarkBlueColor,
                  ),
            ),
          ),
          Visibility(
            visible: isCountryImageUrlAvailable,
            child: CustomNetworkImageWidget(
              imageUrl: countryImage ?? "",
              placeHolderImage: Assets.svgs.unitedArabEmirates.svg(),
              height: countryImageHeight,
              width: countryImageWidth,
              radius: radius,
            ),
          ),
          Visibility(
            visible: isCountryIconAvailable,
            child: icon?.svg() ?? const SizedBox.shrink(),
          ),
          Visibility(
            visible: isLanguageOrCurrencyAvailable,
            child: CustomTextLabelWidget(
              label: languageOrCurrencyName ?? "",
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: languageOrCurrencyFontSize,
                color: MainConfig.appColors.textMediumDarkBlueColor,
              ),
            ),
          ),
          widthMobTab20_30.widthBox,
          RotatedIcon(
              isLanguageAlignmentLTR:
              isLanguageAlignmentLTR,

              iconWidget: Assets.svgs.icArrowNext.svg(height: arrowSize,width: arrowSize)),
        ],
      ),
    );
  }
}
