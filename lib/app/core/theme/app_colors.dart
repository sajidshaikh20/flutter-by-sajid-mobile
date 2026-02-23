import '../../../utils/exports.dart';

/// `AppColors` is a utility class designed to centralize and manage the color scheme
/// throughout the application. It provides a comprehensive collection of color constants
/// that are used across different components and screens, ensuring consistency in the
/// visual appearance of the app.
///
/// This class includes a wide array of color definitions, such as shades of white, gray,
/// blue, red, and green, among others. It also defines specific color schemes for different
/// UI elements and states, like text colors, background colors, border colors, and colors
/// for interactive components like buttons and icons.
class AppColors {
  /// Represents a transparent color.
  Color transparent = Colors.transparent;

  /// Represents the color white.
  static const Color whiteColor = Colors.white;

  /// Represents the color black.
  static const Color blackColor = Colors.black;

  /// Represents a shade of white smoke, slightly off-white.
  static const Color whiteShadeOfSmoke = Color(0xFFF6F6F6);

  /// Represents a mercury-like white, a very light gray.
  static const Color whiteMercuryColor = Color(0xFFE5E5E5);

  /// Represents a smoke-like white, a light off-white.
  static const Color whiteSmokeColor = Color(0xFFF9F9F9);

  /// Represents a whisper-like white, an extremely light gray.
  static const Color whiteOfWhisperColor = Color(0xFFECECEC);

  /// Represents a shade of white smoke, slightly off-white.
  static const Color whiteSmokeShade = Color(0xFFF2F2F2);

  /// Represents a light shade of white, very close to pure white.
  static const Color whiteLightColor = Color(0xFFF8F6F6);

  /// Represents a gray color often used for borders.
  static const Color greyBorderColor = Color(0xFFEDEDED);

  /// Represents a gray color often used for dividers or separators.
  static const Color deviderBorderColor = Color(0xFFDAD8DB);

  /// Represents a dark black color, named 'Bastille'.
  static const Color colorBlackBastille = Color(0xFF2D2D2F);
  /// Represents a black color with a darker shade, used for shadows or overlays.
  static const Color blackWithDarkerShade = Color(0x29000000);

  ///grey color
  /// Represents a standard normal gray color.
  static const Color greyNormalColor = Color(0xFF878893);
  /// Represents a lighter shade of gray.
  static const Color greyLightColor = Color(0xFFD3D3D3);
  /// Represents a very light gray color, often used for backgrounds.
  static const Color greyLight = Color(0xFFF3F4F7);
  /// Represents the border color for errors, typically red.
  Color errorBorder = const Color(0xFFEF3D53);
  /// Represents a gray color used for borders.
  static const Color greyBorder = Color(0xFFE8E8E8);
  /// Represents an extra dark shade of gray.
  Color greyExtraDarkColor = const Color(0xFFB1B1B1);
  /// Represents a green color used for text.
  static const Color greenTextColor = Color(0xFF00A503);

  //  greyColor = Color(0xFF6F7A82);
  /// Represents a medium shade of gray.
  static const Color greyMediumColor = Color(0xFF7E7E84);
  /// Represents a dark shade of gray.
  static const Color greyDarkColor = Color(0xFF8D8D8E);
  /// Represents a very dark shade of gray, almost black.
  static const Color greyDarkBlackColor = Color(0xFF101114);
  /// Represents a lighter shade of gray.
  static const Color greyLighter = Color(0xFFDEDEDE);
  /// Represents a standard gray color.
  static const Color grey = Color(0xFFD0D0D0);
  /// Represents a gray color used for shadows.
  static const Color showdowGrey = Color(0x1A000000);
  /// Represents an extra light shade of gray.
  static const Color greyExtraLight = Color(0xFFE6E6E7);
  /// Represents a gray color often used for progress indicators.
  static const Color greyProgressColor = Color(0xFFE7E7E7);
    /// Represents a gray color often used for Dates.
  static const Color greyDateColor = Color(0xFFE7E7E7);
    /// Represents a gray color often used for days.
  static const Color greyDayColor = Color(0xFF5b595c);

  /// Represents a light blue color.
  static const Color lightBlueColor = Color(0xFF40C8F4);

  /// Represents a white blue color.
  static const Color whiteBlueColor = Color(0xFFE9FAFF);

  /// Represents an extra light blue color.
  static const Color extraLightBlueColor = Color(0xFFF9FAFF);

  static const Color defaultInactiveBackgroundColor = Color(0xFFF5F5F0);

  /// Represents a dark sky blue color.
  static const Color skyBlueDarkColor = Color(0xFF0C65FF);

  /// Represents a light dark blue color.
  Color lightBlueDarkColor = const Color(0xFF3D6AD6);

  /// Represents a light sky blue color.
  static const Color lightSkyBlue = Color(0xFFCEF3FF);

  /// Represents a blue ice color.
  static const Color blueIceColor = Color(0xFFECF3FF);

  /// Represents a bright red color.
  static const Color redColorBright = Color(0xFFFF0000);

  /// Represents a normal red color.
  static const Color redColorNormal = Color(0xFFEA4128);

  /// Represents a light red color.
  static const Color redColorLight = Color(0xFFE74646);

  /// Represents a dark redColorDull.
  static final Color redColorDull = Colors.redAccent.shade100;
  /// Represents a dark red color.
  static const Color _clDarkRedColor = Color(0xFFCD3629);


  ///Represents blackShade
  static const Color blackShade = Color(0xff464646);


  ///
  ///
  ///
  ///
  /// DUKAN app color
  ///
  /// Represents the main brand color, typically a shade of dark blue.
  Color mainColor = const Color(0xFF3AB557);
  /// Represents a secondary brand color, often used for accents.
  Color secondaryColor = const Color(0xFFC4618C);
  /// Represents an ice blue color, commonly used for backgrounds or highlights.
  Color iceBlueColor = const Color(0xFFE9FAFF);
  /// Represents a standard gray color, often used for text.
  Color creyColor = const Color(0xFF606060);
  /// Represents a gray color used for buttons or interactive elements.
  Color buttongreyColor = const Color(0xFFF0F0F0);

  /// Represents a light gray color, used for text or backgrounds.
  Color lightGreyColor = const Color(0xFFAFAFAF);
  /// Represents a standard gray color, typically used for text.
  static const Color greyColor = Color(0xFF9D9C95);
  /// Represents a gray color used for image backgrounds.
  Color imageBgColor = const Color(0xFFEDEDED);
  /// Represents a standard red color, used for alerts or important text.
  Color redColor = const Color(0xFFE11C23);
  /// Represents a light red color, often used for backgrounds.
  Color lightredBgColor = const Color(0xFFFFEEEF);

  /// Represents a standard green color, typically used for success indicators.
  Color greenColor = const Color(0xFF07A927);
  /// Represents a light green color, often used for backgrounds.
  Color lightgreenBgColor = const Color(0xFFECFFF0);
  /// Represents a dark green color, used for important text or icons.
  Color darkGreenColor = const Color(0xFF05900E);
  /// Represents a disabled gray color, used for inactive elements.
  Color disablegreyColor = const Color(0xFFEFEFEF);
  /// Represents a dark green color for text, often used for labels.
  Color darkTextGreen = const Color(0xFF167C36);
  /// Represents a gray color for disabled text.
  Color disableTextColor = const Color(0xFFCECECE);
  /// Represents a specific blue color for span text.
  Color spanTextColor = const Color(0xFF27328C);
  /// Represents a gray color for labels.
  Color labelGrey = const Color(0xFF727272);
  /// Represents a gray color for circles or circular elements.
  Color circleGrey = const Color(0xFF737373);
  /// Represents an extremely light gray color, used for backgrounds.
  Color lightestGreyColor = const Color(0xFFF8F8F8);

  /// Represents a gray color for text.
  Color greyTextColor = const Color(0xFFA0A0A0);
  /// Represents a gray color for unselected items.
  Color unselectedGreyColor = const Color(0xFFBBBBBB);
  /// Represents a gray color for backgrounds.
  Color backgroundGrayColor = const Color(0xFFF4F4F4);

  Color backgroundSuccessColor = const Color(0xFFFCF8F8);
  /// Represents a pink color for backgrounds.
  Color backgroundPinkColor = const Color(0xFFFFEFF7);
  /// Represents a gray color for dividers.
  Color dividerGreyColor = const Color(0xFFC9C9C9);
  /// Represents a gray color used for backgrounds in rating sections.
  Color backGroundForRatingColor = const Color(0x99080808);
  /// Represents an extra light shade of gray.
  Color greyExtraLightColor = const Color(0xFFDDDDDD);

  /// Represents a color used for backgrounds in filter sections.
  Color backGroundForFilterColor = const Color(0xFFF8F9FE);
  /// Represents a gray color for dividers.
  Color dividerColor = const Color(0xFFD9D9D9);
  /// Represents a light green color.
  Color lightGreen = const Color(0xFFE8FFF0);

  /// Light mint background for service grid cards (gradient start).
  static const Color serviceGridGradientLight = Color(0xFFF4FFF7);

  /// Light mint background for service grid cards (gradient end).
  static const Color serviceGridGradientDark = Color(0xFFDBFDE2);

  /// Represents a color used for the background of search icons.
  Color backgroundSearchIcon = const Color(0xFF555555);
  /// Represents a light pink color for backgrounds.
  Color backgroundLightPinkColor = const Color(0xFFF1D9E6);

  /// Represents a white shade color for backgrounds.
  Color backgroundWhiteShade = const Color(0xFFFFF9F9);
  /// Represents a dark blue color.
  Color darkBlueColor = const Color(0xFF0466DC);
  /// Represents a light blue color for backgrounds.
  Color lightBlueBgColor = const Color(0xFFEBF4FF);
  /// Represents a gray color for hint text in Dukkan app.
  Color dukkanHintGreyColor = greyLight;
  /// Represents a dark yellow color for text.
  Color darkYellowTextColor = const Color(0xFFF4F446);




  // mainColor=Color(0xFF00387B);

  /// Primary color.
  Color primary = const Color(0xFF3AB557);

  /// Dark shade of primary for gradients (e.g. wallet home background).
  Color primaryDark = const Color(0xFF1D542A);

  /// Color on primary color.
  Color onPrimary = whiteColor;

  /// Primary container color.
  Color primaryContainer = blackColor;

  /// Color on primary container.
  Color onPrimaryContainer = blackColor;

  /// Secondary color.
  Color secondary = blackColor;

  /// Color on secondary color.
  Color onSecondary = blackColor;

  /// Color on secondary container.
  Color onSecondaryContainer = blackColor;

  /// Secondary container color.
  Color secondaryContainer = blackColor;

  /// Tertiary color.
  Color tertiary = backgroundLightGrayColor;

  /// Primary background color.
  Color backgroundPrimary = blackColor;

  /// Default background color.
  Color background = whiteColor;

  /// Color on background color.
  Color onBackground = blackColor;

  /// Surface color.
  Color surface = whiteColor;

  /// Color on surface.
  Color onSurface = blackColor;

  /// Extra light blue background color.
  Color backgroundExtraLightBlue = extraLightBlueColor;

  /// Light black text color.
  Color textLightBlackColor = const Color(0xff262626);

  /// Alerts colors (Used in Listing)
  /// Border colors
  ///
  /// Represents the primary border color, typically a shade of dark blue.
  Color borderPrimaryColor = const Color(0xFF00387B);
  /// Represents a secondary border color, usually white.
  Color borderSecondaryColor = whiteColor;
  /// Represents a light gray border color.
  Color borderLightGreyColor = greyLightColor;
  /// Represents a transparent border color.
  Color borderTransparentColor = Colors.transparent;
  /// Represents a transparent color for cards.
  Color cardColor = Colors.transparent;
  /// Represents a transparent color for card shadows.
  Color cardShadowColor = Colors.transparent;
  /// Represents a transparent color for default icons.
  Color defaultIconColor = Colors.transparent;
  /// Represents a transparent color for default containers.
  Color defaultContainerColor = Colors.transparent;
  /// Represents a dull red border color.
  Color borderRedColorDull = redColorDull;
  /// Represents a white border color, similar to mercury.
  Color borderColorWhite = whiteMercuryColor;
  /// Represents a light blue border color.
  Color borderLightBlueColor = lightBlueColor;
  /// Represents a dark blue border color.
  Color borderDarkBlueColor = const Color(0xFF0466DC);
  /// Represents a gray border color.
  Color borderGrey = grey;
  /// Represents a gray border color specifically for product lists.
  Color borderGreyProductListColor = greyBorder;
  /// Represents a light white border color, similar to whisper.
  Color borderLightWhiteColor = whiteOfWhisperColor;
  /// Represents a gray border color.
  Color borderGreyColor = greyLight;
  /// Represents a light gray border color specific to Dukkan.
  Color dukkanborderGreyLightColor = greyBorderColor;

  /// Text colors
  ///
  /// Represents the primary text color, typically black.
  Color textPrimaryColor = blackColor;
  /// Represents the text color when it should be white.
  Color textWhiteColor = whiteColor;
  /// Represents the text color when it should be black.
  Color textBlackColor = blackColor;
  /// Represents a gray text color.
  Color textColorGrey = grey;
  /// Represents a red text color.
  Color textRedColor = redColorLight;
  /// Represents a light blue text color.
  Color textLightBlueColor = lightBlueColor;
  /// Represents a dark blue text color.
  Color textDarkBlueColor = const Color(0xFF0466DC);
  /// flutterbysajid main color
  ///
  /// Represents a medium dark blue text color.
  Color textMediumDarkBlueColor = const Color(0xFF00387B);
  /// Represents a dark gray text color.
  Color textGreyDarkColor = greyDarkColor;
  /// Represents a very dark gray text color, almost black.
  Color textDarkBlackColor = greyDarkBlackColor;
  /// Represents a gray text color for labels.
  Color textLabelGreyColor = greyColor;
  /// Represents a medium gray text color.
  Color textGreyMediumColor = greyMediumColor;
  /// Represents a gray text color for days.
  Color textGreyDayColor = greyDayColor;

  /// Background colors

  /// Represents the primary background color, a shade of dark blue.
  Color backgroundPrimaryColor = const Color(0xFF00387B);

  /// Represents a white background color.
  Color backgroundWhiteColor = whiteColor;

  /// Represents a blue background color.
  Color backgroundBlueColor = const Color(0xFF0466DC);

  /// Represents a black background color.
  Color backgroundBlackColor = blackColor;

  /// Represents a light gray background color.
  static const Color backgroundLightGrayColor = greyLightColor;

  /// Represents a light red background color.
  Color backgroundLightRedColor = redColorLight;

  /// Represents a smoke white background color.
  Color backgroundSmokeWhite = whiteShadeOfSmoke;

  /// Represents a white background color.
  Color backgroundWhite = whiteColor;

  /// Represents a grey background color.
  Color backgroundGreyColor = greyLight;

  /// Represents a light sky blue color used for backgrounds.
  Color backgroundLightSkyBlueColor = lightSkyBlue;
  /// Represents an extra light blue color used for backgrounds.
  Color backgroundExtraLightBlueColor = extraLightBlueColor;
  /// Represents a light blue color used for backgrounds.
  Color backgroundLightBlueColor = lightBlueColor;


  // Color backgroundDarkBlueColor = const Color(0xFF0466DC);

  /// **Dukkan Main Color:**
  /// Represents the medium dark blue color used in the Dukkan app.
  Color backgroundMediumDarkBlueColor = const Color(0xFF00387B);
  /// Represents the standard grey color used in the background.
  Color backgroundGrey = grey;
  /// Represents the lighter shade of grey used in the background.
  Color backgroundGreyLighter = greyLighter;
  /// Represents the white smoke color used in the background.
  Color backgroundWhiteSmokeColor = whiteSmokeColor;
  /// Represents the dark red color used in the background.
  Color backgroundDarkRedColor = _clDarkRedColor;
  /// Represents the shimmer effect color used in the background.
  MaterialColor backgroundShimmerGreyColor = Colors.grey;
  /// Represents the base color used for background shimmer.
  Color backGroundShimmerBaseColor = shimmerBaseColor;

  /// **Icon Colors:**
  ///
  /// Represents the dark blue color used for icons.
  Color iconDarkBlueColor = const Color(0xFF0466DC);

  /// **Unrated Star Color:**
  ///
  /// Represents the color of an unrated star, typically a shade of white smoke.
  Color unratedStarColor = whiteSmokeShade;

  /// **Text Colors:**
  ///
  /// Represents the grey-black color used for text.
  Color textColorGreyBlack = colorBlackBastille;

  /// **Box Decoration Colors:**
  ///
  /// Represents the black border color used for box decorations.
  Color boxDecorationBlackBorder = colorBlackBastille;

  /// **Line Color:**
  ///
  /// Represents the color used for lines, typically black.
  Color lineColor = colorBlackBastille;

  /// **Shadow Colors:**
  ///
  /// Represents the black color used for shadows.
  Color shadowBlackColor = blackWithDarkerShade;
  /// Represents the light grey color used for shadows.
  Color shadowGreyLightColor = greyLightColor;
    /// **Box Decoration Colors:**
  ///
  /// Represents the black color used for box decoration.
  Color boxDecorationBlack = blackWithDarkerShade;
   /// **Dotted Line Color:**
  ///
  /// Represents the black color used for dotted lines.
  Color dottedLineColor = blackWithDarkerShade;

   /// Represents a disabled gray color, used for inactive elements.
  Color disableColor = greyLightColor;
   /// Represents a light gray color, used for text.
  Color textGreyLightColor = greyLightColor;

   /// **Divider Colors:**
  ///
  /// Represents a gray color used for dividers.
  Color dividerGrey = grey;
    /// Represents an extra light shade of gray used for dividers.
  Color dividerGreyExtraLight = greyExtraLight;
    /// Represents a whisper-like white used for dividers.
  Color dividerWhiteOfWhisperColor = whiteOfWhisperColor;
    /// Represents a smoke-like white used for dividers.
  Color dividerWhiteShadeOfSmoke = whiteShadeOfSmoke;

  /// Represents a gray color for filling radio button.
  Color radioFillGrey = grey;

  /// Represents a black color for filling radio button.
  Color radioFillBlack = blackColor;

  /// Represents a dark black color for filling radio button.
  Color radioFillDarkBlackColor = greyDarkBlackColor;

    /// Represents a gray color for icons.
  Color iconGrey = grey;

    /// Represents a light gray color for icons.
  Color iconLightGreyColor = whiteOfWhisperColor;

    /// Represents a light blue color for indicators.
  Color indicatorLightBlueColor = lightBlueColor;

  /// Represents the base color for shimmer effects, a light shade of gray.
  static final Color shimmerBaseColor = Colors.grey.shade300;

    /// Represents the base color for dark shimmer effects, a slightly darker shade of gray.
  static final Color shimmerBaseDarkColor = Colors.grey.shade400;

    /// Represents the highlight color for shimmer effects, a very light shade of gray.
  static final Color shimmerHighlightColor = Colors.grey.shade100;

    /// Represents a standard yellow color.
  Color yellowColor = const Color(0xFFFFBB00);

  /// Represents a yellow color used for ratings.
  Color ratingYellowColor = const Color(0xFFFFC316);

    /// Represents a light shade of yellow.
  Color yellowColorLight = const Color(0xFFFFF3CB);

  /// Represents a dark shade of grey.
  Color greyDark = const Color(0xFF1D1D1C);
}









