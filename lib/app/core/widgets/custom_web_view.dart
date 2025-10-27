import '../../../utils/exports.dart';

/// A custom widget that renders a web view using the [WebViewController].
///
/// This widget loads HTML content in a web view. The [WebViewController] is
/// passed as a parameter to control the web view behavior. The HTML content
/// can be provided optionally.
class CustomWebView extends StatelessWidget {
  /// Creates a [CustomWebView] widget.
  ///
  /// [htmlContent] is an optional parameter for the HTML content to be loaded
  /// into the web view. If null, the web view will load without content.
  /// [webViewController] is required and is used to control the behavior
  /// of the web view.
  const CustomWebView({
    super.key,
    this.htmlContent,
    this.webViewController,
  });

  /// The HTML content to be loaded into the web view. If null, no content is
  /// loaded initially.
  final String? htmlContent;

  /// The [WebViewController] used to control the web view's behavior.
  final WebViewController? webViewController;

  @override
  Widget build(BuildContext context) => WebViewWidget(
    controller: webViewController ?? WebViewController(),
  );
}
