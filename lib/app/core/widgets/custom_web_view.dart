import '../../../utils/exports.dart';

/// A custom widget that renders a web view using the [WebViewController].
///
/// This widget loads HTML content or a URL in a web view. The [WebViewController] is
/// passed optionally to control the web view behavior. If not provided, it is
/// managed internally using [url] or [htmlContent].
class CustomWebView extends StatefulWidget {
  /// Creates a [CustomWebView] widget.
  const CustomWebView({
    super.key,
    this.htmlContent,
    this.url,
    this.webViewController,
  });

  /// The HTML content to be loaded into the web view.
  final String? htmlContent;

  /// The URL to be loaded into the web view.
  final String? url;

  /// The [WebViewController] used to control the web view's behavior.
  final WebViewController? webViewController;

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  WebViewController? _internalController;

  WebViewController get _controller => widget.webViewController ?? _internalController!;

  @override
  void initState() {
    super.initState();
    _initControllerIfNeeded();
  }

  void _initControllerIfNeeded() {
    if (widget.webViewController == null) {
      _internalController = WebViewController();
      unawaited(_internalController!.setJavaScriptMode(JavaScriptMode.unrestricted));
      unawaited(_internalController!.setBackgroundColor(Colors.transparent));
      _loadContent();
    }
  }

  void _loadContent() {
    if (_internalController == null) return;
    if (widget.url != null && widget.url!.isNotEmpty) {
      unawaited(_internalController!.loadRequest(Uri.parse(widget.url!)));
    } else if (widget.htmlContent != null && widget.htmlContent!.isNotEmpty) {
      unawaited(_internalController!.loadHtmlString(widget.htmlContent!));
    }
  }

  @override
  void didUpdateWidget(covariant CustomWebView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.webViewController == null) {
      if (_internalController == null) {
        _initControllerIfNeeded();
      } else {
        if (widget.url != oldWidget.url && widget.url != null && widget.url!.isNotEmpty) {
          unawaited(_internalController!.loadRequest(Uri.parse(widget.url!)));
        } else if (widget.htmlContent != oldWidget.htmlContent && widget.htmlContent != null && widget.htmlContent!.isNotEmpty) {
          unawaited(_internalController!.loadHtmlString(widget.htmlContent!));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _controller,
    );
  }
}
