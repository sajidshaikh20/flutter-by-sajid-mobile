import '../utils/exports.dart';

/// A base class for building responsive views that adapt their layout
/// based on the available screen width.
///
/// Subclasses must implement:
/// - [buildMobileWidget] → layout for small screens.
/// - [buildTabletWidget] → layout for medium-sized screens.
/// - [buildDesktopWidget] → layout for large screens.
///
/// This class automatically wraps the content in a [ColorfulSafeArea]
/// to handle safe area insets.
///
/// Example:
/// ```dart
/// class HomePage extends BaseResponsiveView {
///   @override
///   Widget buildMobileWidget(BuildContext context) => MobileHome();
///
///   @override
///   Widget buildTabletWidget(BuildContext context) => TabletHome();
///
///   @override
///   Widget buildDesktopWidget(BuildContext context) => DesktopHome();
/// }
/// ```
abstract class BaseResponsiveView extends StatelessWidget {
  /// Creates a [BaseResponsiveView].
  const BaseResponsiveView({super.key});

  /// Builds the widget for mobile view.
  Widget buildMobileWidget(BuildContext context);

  /// Builds the widget for tablet view.
  Widget buildTabletWidget(BuildContext context);

  /// Builds the widget for desktop/web view.
  Widget buildDesktopWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return mainWidget(context);
  }

  /// Returns the appropriate widget layout based on device width.
  ///
  /// - If [MainConfig.isTabletSupport] is `true`, the layout will adapt
  ///   between mobile, tablet, and web based on screen width.
  /// - Otherwise, only the mobile layout will be shown.
  Widget mainWidget(BuildContext context) {
    return ColorfulSafeArea(
      left: false,
      right: false,
      top: false,
      color: AppColors.whiteColor,
      child: MainConfig.isTabletSupport
          ? LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        if (_isMobileView(constraints.maxWidth)) {
          return buildMobileWidget(context);
        } else if (_isTabletView(constraints.maxWidth)) {
          return buildTabletWidget(context);
        } else if (_isWebView(constraints.maxWidth)) {
          return buildDesktopWidget(context);
        } else {
          return const SizedBox();
        }
      })
          : buildMobileWidget(context),
    );
  }

  /// Returns `true` if the given [width] is considered a web/desktop view.
  /// Web view is detected when the width is greater than or equal to
  /// [AppConstant.webPixelWidth] (e.g., `>= 1200`).
  static bool _isWebView(double width) {
    return width >= AppConstant.webPixelWidth;
  }

  /// Returns `true` if the given [width] is considered a mobile view.
  /// Mobile view is detected when the width is less than
  /// [AppConstant.mobilePixelWidth] (e.g., `< 550`).
  static bool _isMobileView(double width) {
    return width < AppConstant.mobilePixelWidth;
  }

  /// Returns `true` if the given [width] is considered a tablet view.
  /// Tablet view is detected when the width is greater than or equal to
  /// [AppConstant.mobilePixelWidth] and less than
  /// [AppConstant.webPixelWidth] (e.g., `550 <= width < 1200`).
  static bool _isTabletView(double width) {
    return width >= AppConstant.mobilePixelWidth &&
        width < AppConstant.webPixelWidth;
  }
}
