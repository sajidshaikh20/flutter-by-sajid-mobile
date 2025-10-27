import '../../../../../utils/exports.dart';

/// A reusable, global AppBar widget for the application.
///
/// This widget is intended to be used at the app level (e.g., in [MyApp])
/// and can be customized with a background color and title.
///
/// Example:
/// ```dart
/// MainAppBarWidget(
///   backgroundColor: Colors.blue,
///   title: 'Home',
/// )
/// ```
class MainAppBarWidget extends StatelessWidget {
  /// The background color for the AppBar.
  ///
  /// If null, the default [AppBar] background color will be used.
  final Color? backgroundColor;

  /// The title text to display in the AppBar.
  ///
  /// This will be passed to [MainAppBarTitleWidget].
  final String? title;

  /// Creates a [MainAppBarWidget] with optional [backgroundColor] and [title].
  const MainAppBarWidget({
    super.key,
    this.backgroundColor,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Prevents Flutter from showing the default back button automatically.
      automaticallyImplyLeading: false,
      toolbarHeight: Dimens.appBarHeight,
      leadingWidth: 0,
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: backgroundColor,
      title: MainAppBarTitleWidget(
        title: title,
      ),
    );
  }
}
