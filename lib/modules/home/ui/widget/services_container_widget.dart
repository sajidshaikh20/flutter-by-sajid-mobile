import '../../../../utils/exports.dart';

/// Container for All Services section with curved notch background and top drag line.
///
/// Uses ic_white_top_cut_background PNG as the background shape and displays
/// a small centered white drag line at the top for visual separation.
class ServicesContainerWidget extends StatelessWidget {
  /// Creates a services container widget.
  const ServicesContainerWidget({
    super.key,
    required this.child,
  });

  /// Child content (e.g. All Services section).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
