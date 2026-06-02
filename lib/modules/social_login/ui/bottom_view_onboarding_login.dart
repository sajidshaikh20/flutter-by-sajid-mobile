import '../../../../utils/exports.dart';

/// Widget that displays the bottom view for onboarding login screens.
class BottomViewOnboardingLogin extends StatelessWidget {
  /// Creates a bottom view for onboarding login.
  const BottomViewOnboardingLogin({
    super.key,
    this.device = ScreenType.mobile,
    required this.childWidget,
  });

  /// The screen type for responsive design.
  final ScreenType device;

  /// The child widget to display in the center of the background.
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          // Background SVG

          // Foreground content
          Center(child: childWidget),
        ],
      ),
    );
  }
}
