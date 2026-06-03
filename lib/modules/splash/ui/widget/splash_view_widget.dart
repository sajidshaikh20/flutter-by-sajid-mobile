import '../../../../utils/exports.dart';

/// Widget that displays the splash screen UI.
class SplashViewWidget extends StatelessWidget {
  /// Creates a splash view widget.
  const SplashViewWidget({super.key});

  bool _isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Builds the splash view for the specified screen type.
  Widget buildViews(ScreenType screenType, BuildContext context) {
    final bool isDark = _isDarkTheme(context);



    final AssetGenImage backgroundImage = isDark
        ? Assets.webp.icDarkBackgroundSplash
        : Assets.webp.icLightBackgroundSplash;

    final Color textMainColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textMutedColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          backgroundImage.image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Assets.png.icCropWekoIcon.image(
                width: Dimens.size140,
                height: Dimens.size140,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: Dimens.space4),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: 'WEKO',
                        style: TextStyle(
                          fontSize: Dimens.fontSize35,
                          fontWeight: FontWeight.w900,
                          color: textMainColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: <Color>[
                              AppColors.secondaryPurple,
                              AppColors.accentPink,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: const CustomTextLabelWidget(
                          label: '.PRO',
                          style: TextStyle(
                            fontSize: Dimens.fontSize35,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimens.space4),
                  CustomTextLabelWidget(
                    label: 'ALL-IN-ONE TRADING PLATFORM',
                    style: TextStyle(
                      fontSize: Dimens.fontSize10,
                      fontWeight: FontWeight.w700,
                      color: textMutedColor,
                      letterSpacing: 2.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildViews(ScreenType.tablet, context);
  }
}
