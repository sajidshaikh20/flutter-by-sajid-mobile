import '../../../../utils/exports.dart';

/// Widget that displays alternative authentication options like forgot password.
class OtherAuthView extends StatelessWidget {
  /// Creates an other auth view widget.
  const OtherAuthView({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    // Forgot password removed - return empty widget
    return const SizedBox.shrink();
  }
}
