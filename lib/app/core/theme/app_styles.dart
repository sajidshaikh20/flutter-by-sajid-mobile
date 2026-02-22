import '../../../utils/exports.dart';



/// App text styles and theme factory used across the application UI.
 class AppStyles {
  //-----------------------------Light------------------------

  //light with font size 96
   final TextStyle _displayLarge = _textStyle.copyWith(
      fontSize: Dimens.fontSize96, fontWeight: FontWeight.w300);

  //extra-light with font size 60
   final TextStyle _displayMedium = _textStyle.copyWith(
      fontSize: Dimens.fontSize60, fontWeight: FontWeight.w200);

  //thin with font size 48
   final TextStyle _displaySmall = _textStyle.copyWith(
      fontSize: Dimens.fontSize48, fontWeight: FontWeight.w100);

  //------------------------------Semi-Bold--------------------

  //semi-bold with font size 18
   final TextStyle _headlineMedium = _textStyle.copyWith(
      fontSize: Dimens.fontSize18,
      fontWeight: FontWeight.w700,
      color: MainConfig.appColors.textBlackColor);

  //semi-bold with font size 16
   final TextStyle _headlineSmall = _textStyle.copyWith(
      fontSize: Dimens.fontSize16, fontWeight: FontWeight.w600);

  //-----------------------Title------------------------------

  //bold with font size 18
   final TextStyle _titleSmall = _textStyle.copyWith(
      fontSize: Dimens.fontSize18, fontWeight: FontWeight.w500);

  //semi-bold with font size 20
   final TextStyle _titleMedium = _textStyle.copyWith(
      fontSize: Dimens.fontSize20, fontWeight: FontWeight.w600);

  //bold with font size 24
   final TextStyle _titleLarge = _textStyle.copyWith(
    fontSize: Dimens.fontSize24,
    fontWeight: FontWeight.w700,
  );

  //---------------------------body--------------------------
  //regular with font size 16 with light color
   final TextStyle _bodySmall = _textStyle.copyWith(
      fontSize: Dimens.fontSize12, color: MainConfig.appColors.textBlackColor,fontWeight: FontWeight.normal);

  //medium with font size 16
   final TextStyle _bodyMedium = _textStyle.copyWith(
      fontSize: Dimens.fontSize14, fontWeight: FontWeight.normal,color: MainConfig.appColors.textBlackColor);

  //regular with font size 16
   final TextStyle _bodyLarge = _textStyle.copyWith(
    fontSize: Dimens.fontSize16,fontWeight: FontWeight.normal,color: MainConfig.appColors.textBlackColor
  );

  //---------------------------Medium--------------------------
  //regular with font size 16 with black color
   final TextStyle _labelLarge = _textStyle.copyWith(
      fontSize: Dimens.fontSize16, color: MainConfig.appColors.textBlackColor);

  //medium with font size 16 with black color
   final TextStyle _labelMedium = _textStyle.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: Dimens.fontSize16,
      color: MainConfig.appColors.textBlackColor);

  //regular with font size 14 with medium gray color
   final TextStyle _labelSmall = _textStyle.copyWith(
      fontSize: Dimens.fontSize14, color: MainConfig.appColors.textBlackColor);

  //regular with font size 14 with black color
   static final  TextStyle _textStyle = TextStyle(
      color: MainConfig.appColors.textBlackColor,
      fontSize: Dimens.fontSize14,
    fontFamily: AppConstant.interFontFamily
      );

   /// Text style used for error messages.
   TextStyle get errorStyle => _bodyMedium.copyWith(
        color: MainConfig.appColors.textRedColor,
      );

   /// Text style used for input hints and placeholders.
   TextStyle get hintStyle => _textStyle.copyWith(
        color: MainConfig.appColors.textGreyLightColor,
      );

   /// Bold text style with default size 14.
   TextStyle textBold = _boldStyle.copyWith(
    fontSize: Dimens.fontSize14,
  );

   /// Semi-bold text style with default size 14.
   TextStyle textSemiBold = _semiBoldStyle.copyWith(
    fontSize: Dimens.fontSize14,
  );

   /// Regular text style with default size 14.
   TextStyle textNormal = _regularStyle.copyWith(
    fontSize: Dimens.fontSize14,
  );

  /// Medium-weight text style with default size 14.
  static TextStyle textMedium = _mediumStyle.copyWith(
    fontSize: Dimens.fontSize14,
  );

  /// Light-weight text style with default size 14.
  static TextStyle textLight = _lightStyle.copyWith(
    fontSize: Dimens.fontSize14,
  );

  static final TextStyle _lightStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w300,
  );

  static final TextStyle _regularStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w400,
  );

  static final TextStyle _mediumStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w500,
  );

  static final TextStyle _semiBoldStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w600,
  );

  static final TextStyle _boldStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w700,
  );


   /// Builds the application's TextTheme.
   ///
   /// The [isLtr] flag indicates text direction context (currently not altering styles).
   TextTheme  textTheme({required bool isLtr})  {


    return TextTheme(
      bodyLarge: _bodyLarge,
      bodyMedium: _bodyMedium,
      bodySmall: _bodySmall,
      displayLarge: _displayLarge,
      displayMedium: _displayMedium,
      displaySmall: _displaySmall,
      headlineMedium: _headlineMedium,
      headlineSmall: _headlineSmall,
      titleLarge: _titleLarge,
      titleMedium: _titleMedium,
      titleSmall: _titleSmall,
      labelLarge: _labelLarge,
      labelMedium: _labelMedium,
      labelSmall: _labelSmall,
    );
  }
}
