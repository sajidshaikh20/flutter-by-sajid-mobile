import '../../../utils/exports.dart';

/// A class that provides  theme configurations for the app.
///
/// This class contains predefined color schemes, text styles, and theme data
/// for both light and dark themes. It simplifies the management of app themes
/// by centralizing theme-related configurations in one place, making it easier
/// to maintain a consistent look and feel across the entire app.
///
/// The light and dark themes include:
/// - Primary, accent, background, and text colors.
/// - Text styles for title and body text.
/// - ThemeData configurations for each theme,
/// including brightness and text styling.
class MyAppTheme {
  final ColorScheme _appColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: MainConfig.appColors.primary,
    primaryContainer: MainConfig.appColors.primaryContainer,
    onPrimaryContainer: MainConfig.appColors.onPrimaryContainer,
    onPrimary: MainConfig.appColors.onPrimary,
    secondary: MainConfig.appColors.secondary,
    onSecondary: MainConfig.appColors.onSecondary,
    onSecondaryContainer: MainConfig.appColors.onSecondaryContainer,
    secondaryContainer: MainConfig.appColors.secondaryContainer,
    tertiary: MainConfig.appColors.tertiary,
    error: MainConfig.appColors.redColor,
    onError: MainConfig.appColors.redColor,
    errorContainer: MainConfig.appColors.borderRedColorDull,
    onErrorContainer: MainConfig.appColors.redColor,
    surface: MainConfig.appColors.surface,
    // onBackground: MainConfig.appColors.onBackground,
    // background: MainConfig.appColors.surface,
    onSurface: MainConfig.appColors.onSurface,
    outline: MainConfig.appColors.borderLightGreyColor,
    shadow: MainConfig.appColors.shadowBlackColor,
  );
  bool _isEnglishLan = true;

  /// Returns the appropriate [ThemeData] based on t
  /// he
  ///  text direction (LTR or RTL).
  ///
  /// This method adjusts the theme's font family and styling based on the
  /// provided [isLtr] flag to ensure proper
  /// display
  /// of text for different languages.
  ThemeData theme({required bool isLtr}) {
    _isEnglishLan = isLtr;
    return ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.standard,
      appBarTheme: _getAppBarTheme(),
      primaryTextTheme: MainConfig.appStyle.textTheme(isLtr: _isEnglishLan),
      colorScheme: _appColorScheme,

      splashColor:
          _appColorScheme.onPrimary.withValues(alpha: Dimens.opacity03),
      iconTheme: IconThemeData(color: _appColorScheme.onSurface),
      scaffoldBackgroundColor: _appColorScheme.surface,
      buttonTheme: _getButtonTheme(),
      textButtonTheme: _getTextButtonThemeData(),
      elevatedButtonTheme: _getElevatedButtonThemeData(),
      outlinedButtonTheme: _getOutlinedButtonThemeData(),
      floatingActionButtonTheme: _getFloatingActionButtonThemeData(),
      textTheme: MainConfig.appStyle.textTheme(isLtr: _isEnglishLan),
      inputDecorationTheme: _getInputDecorationTheme(),
      cardTheme: _getCardTheme(),
      dialogTheme: _getDialogTheme(),
      bottomSheetTheme: _getBottomSheetThemeData(),
      bottomNavigationBarTheme: _getBottomNavigationBarThemeData(),
      dividerColor: _appColorScheme.outline,
      drawerTheme: _getDrawerThemeData(),
      tabBarTheme: _getTabBarTheme(),
      switchTheme: _getSwitchThemeData(),
      snackBarTheme: _getSnackBarThemeData(),
      radioTheme: _getRadioThemeData(),
      progressIndicatorTheme: _getProgressIndicatorThemeData(),
      popupMenuTheme: _getPopupMenuThemeData(),
      useMaterial3: true,
    );
  }

  AppBarTheme _getAppBarTheme() => AppBarTheme(
        // backgroundColor: _appColorScheme.secondary,
        backgroundColor: _appColorScheme.primary,
        centerTitle: true,
        actionsIconTheme: IconThemeData(
          color: _appColorScheme.onPrimary,
          size: Dimens.size25,
        ),
        shadowColor: MainConfig.appColors.shadowGreyLightColor,
        shape: Border(
          bottom: BorderSide(
            color: MainConfig.appColors.borderLightGreyColor,
          ),
        ),
        iconTheme: IconThemeData(color: _appColorScheme.onPrimary),
        titleTextStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .titleLarge
            ?.copyWith(
              fontSize: Dimens.fontSize20,
              color: _appColorScheme.primary,
            ),
        systemOverlayStyle: systemOverlay(),
      );

  /// Returns the appropriate [SystemUiOverlayStyle]
  ///  for
  /// configuring the system's
  /// status bar and navigation bar colors.
  ///
  /// This method customizes the system UI's
  /// overlay
  /// styles to match the app's theme
  /// for both light and dark modes.

  SystemUiOverlayStyle systemOverlay() {
    return SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: MainConfig.appColors.primary,
      systemNavigationBarColor: AppColors.whiteColor,
      systemNavigationBarDividerColor: AppColors.whiteColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: false,
    );
  }

  ButtonThemeData _getButtonTheme() => ButtonThemeData(
        buttonColor: _appColorScheme.primary,
        disabledColor: _appColorScheme.outline,
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.space10,
          horizontal: Dimens.space20,
        ),
        colorScheme: _appColorScheme,
        textTheme: ButtonTextTheme.primary,
        splashColor:
            _appColorScheme.onPrimary.withValues(alpha: Dimens.opacity03),
        shape: RoundedRectangleBorder(
          borderRadius: Dimens.radius20.borderRadius,
          side: Dimens.borderWidth3.borderSide(
            color: _appColorScheme.primary,
            style: BorderStyle.solid,
          ),
        ),
      );

  TextButtonThemeData _getTextButtonThemeData() => TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return MainConfig.appColors.backgroundMediumDarkBlueColor
                    .withValues(alpha: Dimens.opacity03);
              }

              return null;
            },
          ),
          // If you want to set textStyle for button with color, first you have
          // remove foreground color, so giving null as value.
          foregroundColor:
              WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return _appColorScheme.tertiary;
            }
            return MainConfig.appColors.backgroundMediumDarkBlueColor;
          }),
          // Setting textStyle for text of button
          textStyle: WidgetStatePropertyAll<TextStyle?>(
            MainConfig.appStyle
                .textTheme(isLtr: _isEnglishLan)
                .titleLarge
                ?.copyWith(
                  fontSize: Dimens.fontSize20,
                  color: _appColorScheme.surface,
                ),
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder?>(
            RoundedRectangleBorder(
              borderRadius: Dimens.radius6.borderRadius,
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return _appColorScheme.outline;
              }
              return null;
            },
          ),
        ),
      );

  ElevatedButtonThemeData _getElevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return _appColorScheme.onPrimary
                    .withValues(alpha: Dimens.opacity03);
              }
              return null;
            },
          ),
          shadowColor: WidgetStatePropertyAll<Color?>(
            _appColorScheme.shadow,
          ),

          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return _appColorScheme.tertiary;
              }
              return null;
            },
          ),
          // If you want to set textStyle for button with color, first you have
          // remove foreground color, so giving null as value.
          foregroundColor:
              WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return _appColorScheme.tertiary;
            }
            return _appColorScheme.surface;
          }),
          // Setting textStyle for text of button
          textStyle: WidgetStatePropertyAll<TextStyle?>(
            MainConfig.appStyle
                .textTheme(isLtr: _isEnglishLan)
                .titleLarge
                ?.copyWith(
                  fontSize: Dimens.fontSize20,
                  color: _appColorScheme.surface,
                ),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry?>(
            EdgeInsets.only(
              left: Dimens.space36,
              right: Dimens.space36,
              top: Dimens.space18,
              bottom: Dimens.space18,
            ),
          ),
          side: WidgetStatePropertyAll<BorderSide?>(
            Dimens.borderWidth05.borderSide(
              color: MainConfig.appColors.borderLightGreyColor,
              style: BorderStyle.solid,
              strokeAlign: Dimens.borderWidth1,
            ),
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder?>(
            RoundedRectangleBorder(
              borderRadius: Dimens.radius6.borderRadius,
            ),
          ),
        ),
      );

  OutlinedButtonThemeData _getOutlinedButtonThemeData() =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return _appColorScheme.primary
                    .withValues(alpha: Dimens.opacity03);
              }
              return null;
            },
          ),
          backgroundColor: WidgetStatePropertyAll<Color?>(
            _appColorScheme.surface,
          ),
          // If you want to set textStyle for button with color, first you have
          // remove foreground color, so giving null as value.
          foregroundColor:
              WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return _appColorScheme.tertiary;
            }
            return _appColorScheme.surface;
          }),
          // Setting textStyle for text of button
          textStyle: WidgetStatePropertyAll<TextStyle?>(
            MainConfig.appStyle
                .textTheme(isLtr: _isEnglishLan)
                .titleLarge
                ?.copyWith(
                  fontSize: Dimens.fontSize20,
                  color: _appColorScheme.surface,
                ),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry?>(
            EdgeInsets.symmetric(
              horizontal: Dimens.space30,
              vertical: Dimens.space10,
            ),
          ),
          side: WidgetStatePropertyAll<BorderSide?>(
            Dimens.borderWidth1.borderSide(
              color: _appColorScheme.surface,
              style: BorderStyle.solid,
              strokeAlign: Dimens.borderWidth1,
            ),
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder?>(
            RoundedRectangleBorder(
              borderRadius: Dimens.radius27.borderRadius,
            ),
          ),
        ),
      );

  FloatingActionButtonThemeData _getFloatingActionButtonThemeData() =>
      FloatingActionButtonThemeData(
        elevation: Dimens.space4,
        backgroundColor: _appColorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: Dimens.radius20.borderRadius,
        ),
        disabledElevation: Dimens.zero,
        extendedIconLabelSpacing: Dimens.space20,
        splashColor:
            _appColorScheme.primary.withValues(alpha: Dimens.opacity03),
      );

  InputDecorationTheme _getInputDecorationTheme() => InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.space10,
        ),
        hintStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .bodyMedium
            ?.copyWith(color: MainConfig.appColors.textColorGrey),
        labelStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .bodyMedium
            ?.copyWith(
              color: MainConfig.appColors.textColorGrey,
            ),
        hoverColor: Colors.transparent,
        errorStyle: MainConfig.appStyle.errorStyle.copyWith(
          fontSize: Dimens.fontSize12,
        ),
        alignLabelWithHint: true,
        errorMaxLines: Dimens.maxLines03,
        enabledBorder: Dimens.radius0.underlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderGrey,
          ),
        ),
        focusedBorder: Dimens.radius0.underlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderPrimaryColor,
          ),
        ),
        border: Dimens.radius0.underlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderGrey,
          ),
        ),
        errorBorder: Dimens.radius0.underlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderRedColorDull,
          ),
        ),
        focusedErrorBorder: Dimens.radius0.underlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderRedColorDull,
          ),
        ),
        disabledBorder: Dimens.radius0.underlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: _appColorScheme.outline.withValues(alpha: Dimens.opacity05),
          ),
        ),
      );

  /// Returns a customized [InputDecorationTheme] for a search bar input field.
  ///
  /// This theme provides styling for the search bar,
  /// including border, hint text,
  /// and icon customization to match the app's design.
  InputDecorationTheme getSearchBarInputDecorationTheme() =>
      InputDecorationTheme(
        filled: true,
        fillColor: MainConfig.appColors.backgroundSmokeWhite,
        // contentPadding:
        // const EdgeInsets.only(top: Dimens.space10),
        hintStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .bodySmall
            ?.copyWith(
              fontSize: Dimens.fontSize16,
              color: MainConfig.appColors.textGreyMediumColor,
            ),
        labelStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .bodyMedium
            ?.copyWith(
              color: MainConfig.appColors.textColorGrey,
            ),
        hoverColor: Colors.transparent,
        errorStyle: MainConfig.appStyle.errorStyle.copyWith(
          fontSize: Dimens.fontSize12,
        ),
        alignLabelWithHint: true,
        errorMaxLines: Dimens.maxLines03,
        isDense: true,
        enabledBorder: Dimens.radius10.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.backgroundSmokeWhite,
          ),
        ),
        focusedBorder: Dimens.radius10.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.backgroundSmokeWhite,
          ),
        ),
        border: Dimens.radius10.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderGrey,
          ),
        ),
        errorBorder: Dimens.radius10.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderRedColorDull,
          ),
        ),
        focusedErrorBorder: Dimens.radius10.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderRedColorDull,
          ),
        ),
        disabledBorder: Dimens.radius10.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: _appColorScheme.outline.withValues(
              alpha: Dimens.opacity05,
            ),
          ),
        ),
      );

  /// Returns a customized [InputDecorationTheme]
  /// for the
  /// 'My Order Cancel Review' input field.
  ///
  /// This theme defines the styling for
  /// input fields related
  /// to order cancellation reviews,
  /// including the border style, hint text, and
  /// icon customization
  /// for a consistent look.
  InputDecorationTheme getMyOrderCancelReviewInputDecorationTheme() =>
      InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: Dimens.space8,
          horizontal: Dimens.space13,
        ),
        hintStyle: MainConfig.appStyle.textNormal.copyWith(
          fontSize: Dimens.fontSize16,
          color: MainConfig.appColors.textColorGrey,
        ),
        hoverColor: Colors.transparent,
        errorMaxLines: Dimens.maxLines03,
        enabledBorder: Dimens.radius6.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderLightWhiteColor,
          ),
        ),
        focusedBorder: Dimens.radius6.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderGreyProductListColor,
          ),
        ),
        border: Dimens.radius6.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderGrey,
          ),
        ),
        errorBorder: Dimens.radius6.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderRedColorDull,
          ),
        ),
        focusedErrorBorder: Dimens.radius6.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: MainConfig.appColors.borderRedColorDull,
          ),
        ),
        disabledBorder: Dimens.radius6.outlineInputBorder(
          borderSide: Dimens.borderWidth1.borderSide(
            color: _appColorScheme.outline.withValues(alpha: Dimens.opacity05),
          ),
        ),
      );

  CardThemeData _getCardTheme() => CardThemeData(
        color: MainConfig.appColors.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: Dimens.radius10.borderRadius,
        ),
        shadowColor: MainConfig.appColors.cardShadowColor,
        elevation: Dimens.space4,
      );

  DialogThemeData _getDialogTheme() => DialogThemeData(
        backgroundColor: _appColorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: Dimens.radius20.borderRadius,
        ),
        elevation: Dimens.space4,
        titleTextStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .titleLarge
            ?.copyWith(color: _appColorScheme.onSurface),
        contentTextStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .bodyMedium
            ?.copyWith(
              color: _appColorScheme.onSurface,
            ),
      );

  BottomSheetThemeData _getBottomSheetThemeData() => BottomSheetThemeData(
        backgroundColor: _appColorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Dimens.radius24.circularRadius,
            topRight: Dimens.radius24.circularRadius,
          ),
        ),
        modalBackgroundColor: _appColorScheme.surface,
        elevation: Dimens.space4,
        modalElevation: Dimens.space4,
      );

  BottomNavigationBarThemeData _getBottomNavigationBarThemeData() =>
      BottomNavigationBarThemeData(
        elevation: Dimens.space4,
        backgroundColor: _appColorScheme.surface,
        selectedIconTheme: IconThemeData(
          color: _appColorScheme.surface,
          size: Dimens.size28,
        ),
        selectedItemColor: _appColorScheme.surface,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedIconTheme: IconThemeData(color: _appColorScheme.tertiary),
        unselectedItemColor: _appColorScheme.tertiary,
        selectedLabelStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .bodyMedium
            ?.copyWith(fontSize: Dimens.fontSize12),
        unselectedLabelStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .bodyMedium
            ?.copyWith(
              fontSize: Dimens.fontSize12,
            ),
      );

  DrawerThemeData _getDrawerThemeData() => DrawerThemeData(
        backgroundColor: _appColorScheme.surface,
      );

  TabBarThemeData _getTabBarTheme() => TabBarThemeData(
    indicatorColor: _appColorScheme.surface,
        overlayColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return _appColorScheme.surface
                  .withValues(alpha: Dimens.opacity03);
            }
            return null;
          },
        ),
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: const EdgeInsets.symmetric(
          vertical: Dimens.space6,
          horizontal: Dimens.space10,
        ),
        labelColor: _appColorScheme.surface,
        unselectedLabelColor: _appColorScheme.tertiary,
        labelStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .bodyMedium
            ?.copyWith(fontSize: Dimens.fontSize20),
        unselectedLabelStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .bodyMedium
            ?.copyWith(fontSize: Dimens.fontSize20),
      );

  SwitchThemeData _getSwitchThemeData() => SwitchThemeData(
        thumbColor: WidgetStatePropertyAll<Color?>(_appColorScheme.surface),
        trackColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected) ||
                states.contains(WidgetState.pressed)) {
              return _appColorScheme.surface;
            }
            return _appColorScheme.tertiary;
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return _appColorScheme.surface
                  .withValues(alpha: Dimens.opacity03);
            }
            return null;
          },
        ),
        splashRadius: Dimens.radius10,
      );

  SnackBarThemeData _getSnackBarThemeData() => SnackBarThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: Dimens.radius6.borderRadius,
        ),
        backgroundColor: _appColorScheme.onSurface,
        actionTextColor: _appColorScheme.surface,
        contentTextStyle: MainConfig.appStyle
            .textTheme(isLtr: _isEnglishLan)
            .bodyMedium
            ?.copyWith(color: _appColorScheme.surface),
      );

  RadioThemeData _getRadioThemeData() => RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return _appColorScheme.primary;
          }
          return MainConfig.appColors.radioFillGrey;
        }),
        splashRadius: Dimens.radius10,
      );

  ProgressIndicatorThemeData _getProgressIndicatorThemeData() =>
      ProgressIndicatorThemeData(
        circularTrackColor: Colors.transparent,
        color: _appColorScheme.tertiary,
        linearMinHeight: Dimens.size2,
        linearTrackColor: Colors.transparent,
      );

  PopupMenuThemeData _getPopupMenuThemeData() => PopupMenuThemeData(
        color: _appColorScheme.surface,
        elevation: Dimens.elevation4,
        shape: RoundedRectangleBorder(
          borderRadius: Dimens.radius10.borderRadius,
        ),
        textStyle:
            MainConfig.appStyle.textTheme(isLtr: _isEnglishLan).bodySmall,
      );
}
