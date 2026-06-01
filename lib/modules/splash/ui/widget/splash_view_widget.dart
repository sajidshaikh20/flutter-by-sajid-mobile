import 'dart:math' as math;
import 'dart:ui' as ui;
import '../../../../utils/exports.dart';

/// Widget that displays the splash screen UI.
class SplashViewWidget extends StatelessWidget {
  /// Creates a splash view widget.
  const SplashViewWidget({super.key});

  /// Helper to determine dark mode styling dynamically.
  /// This prevents compiler dead code warnings when forcing dark theme.
  bool _checkDarkTheme() {
    // By default, we use dark theme splash (as requested "for dark as of now").
    // In the future, this can easily be modified to:
    // return Theme.of(context).brightness == Brightness.dark;
    return true;
  }

  /// Builds the splash view for the specified screen type.
  ///
  /// [screenType] specifies the device screen type for responsive design.
  Widget buildViews(ScreenType screenType, BuildContext context) {
    final bool isDark = _checkDarkTheme();

    // Define theme constants
    final Color backgroundColorStart = isDark
        ? const Color(0xFF070014)
        : const Color(0xFFFFFFFF);
    final Color backgroundColorMid = isDark
        ? const Color(0xFF0F0024)
        : const Color(0xFFFAF9FC);
    final Color backgroundColorEnd = isDark
        ? const Color(0xFF05000F)
        : const Color(0xFFF5EFFF);

    final Color textMainColor = isDark ? Colors.white : const Color(0xFF000000);
    final Color textMutedColor = isDark ? Colors.white54 : Colors.black45;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              backgroundColorStart,
              backgroundColorMid,
              backgroundColorEnd,
            ],
            stops: const <double>[0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // Static Logo Image
              Assets.png.icWeko.image(
                  width: Dimens.size160,
                  height: Dimens.size160,
                  fit: BoxFit.fitWidth),
              // Static Text & Loading Content
              Column(
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label:
                        "WEKO",
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
                              Color(0xFF8A2BE2), // Neon Purple
                              Color(0xFFFF4FD8), // Hot Pink
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: const CustomTextLabelWidget(
                          label:
                          ".PRO",
                          style: TextStyle(
                            fontSize: Dimens.fontSize35,
                            fontWeight: FontWeight.w900,
                            color: Colors.white, // Mask overrides this
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimens.space4),
                  // Slogan "ALL-IN-ONE TRADING PLATFORM"
                  CustomTextLabelWidget(
                    label:
                    "ALL-IN-ONE TRADING PLATFORM",
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildViews(ScreenType.tablet, context);
  }
}