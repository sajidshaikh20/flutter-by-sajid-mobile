import '../../../../utils/exports.dart';

/// Widget that displays the splash screen UI.
class SplashViewWidget extends StatelessWidget {
  /// Creates a splash view widget.
  const SplashViewWidget({super.key});

  /// Builds the splash view for the specified screen type.
  ///
  /// [screenType] specifies the device screen type for responsive design.
  Widget buildViews(ScreenType screenType) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        // Background SVG
        Positioned.fill(
          child: Assets.svgs.bgSplash.svg(fit: BoxFit.fill),
        ),
        // Foreground content
        Center(
          child: Container(
            alignment: Alignment.center,
            width: Dimens.size282,
            // Set the width of the circle
            height: Dimens.size282,
            // Set the height of the circle
            decoration: const BoxDecoration(
              color: AppColors.whiteColor, // Background color of the circle
              shape: BoxShape.circle, // Makes the container circular
            ),
            child: Assets.png.flutterOriginal512px
                .image(height: Dimens.size114, width: Dimens.size202),
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return buildViews(ScreenType.tablet);
  }
}
