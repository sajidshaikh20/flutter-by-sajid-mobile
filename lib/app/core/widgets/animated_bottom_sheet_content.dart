
import '../../../utils/exports.dart';

/// A widget that provides animated content for a bottom sheet,
/// sliding in from the bottom when shown.
class AnimatedBottomSheetContent extends StatefulWidget {
  /// The content to be displayed inside the bottom sheet.
  final Widget child;

  /// Creates an instance of [AnimatedBottomSheetContent].
  ///
  /// The [child] parameter is required and specifies the content of the bottom sheet.
  const AnimatedBottomSheetContent({super.key, required this.child});

  @override

 AnimatedBottomSheetContentState createState() => AnimatedBottomSheetContentState();
}

///AnimatedBottomSheetContentState
class AnimatedBottomSheetContentState extends State<AnimatedBottomSheetContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: Dimens.milliseconds500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // starts off-screen (bottom)
      end: Offset.zero, // ends at its natural position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    unawaited(_controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
