import '../../../../utils/exports.dart';

/// A wrapper widget that keeps its [child] alive across tab/page switches.
///
/// Useful in carousels or tab views where you want to preserve the widget's
/// state and avoid rebuilding when it goes off-screen.
class KeepAlivePage extends StatefulWidget {
  /// The widget subtree to keep alive.
  final Widget child;

  /// Creates a [KeepAlivePage] that preserves the state of its [child].
  const KeepAlivePage({required this.child, super.key});

  @override

  /// Creates the mutable state for this widget.
  KeepAlivePageState createState() => KeepAlivePageState();
}

/// The mutable state for [KeepAlivePage] that preserves its child widget.
///
/// Uses [AutomaticKeepAliveClientMixin] to keep the child alive when
/// switching between tabs or pages.
class KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin<KeepAlivePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return widget.child;
  }

  @override

  /// Determines whether to keep the widget alive when it's not visible.
  bool get wantKeepAlive => true;
}
