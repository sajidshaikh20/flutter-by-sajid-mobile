import '../../../../../utils/exports.dart';

/// A page that displays CMS (Content Management System) content in a WebView.
///
/// This page shows a web page based on the provided [url] and displays [title]
/// in the app bar or header.
@RoutePage()
class CommonWebView extends StatefulWidget {
  /// The title to display on the app bar or page header.
  final String title;

  /// The URL of the CMS content to display.
  final String url;

  /// Creates a [CommonWebView] with the given [title] and [url].
  const CommonWebView(this.title, this.url, {super.key});

  @override
  CommonWebViewState createState() => CommonWebViewState();
}
///ViewCmsPageState
class CommonWebViewState extends State<CommonWebView> {
  late final WebViewController _controller;
  bool _isControllerReady = false;
  bool _isLoaderVisible = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initializeController());
  }

  /// Force hide the loader and reset the state
  void _forceHideLoader() {
    if (_isLoaderVisible) {
      _isLoaderVisible = false;
      unawaited(showLoader(value: false));
    }
  }

  @override
  void dispose() {
    // Ensure loader is hidden when the page is disposed
    _forceHideLoader();
    super.dispose();
  }

  Future<void> _initializeController() async {
    // Create the controller instance.
    final WebViewController controller = WebViewController();

    await controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    await controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {

        },
        onPageStarted: (String url) {
          if (mounted) {
            _isLoaderVisible = true;
            unawaited(showLoader(value: true));
          }
        },
        onPageFinished: (String url) {
          if (mounted) {
            _isLoaderVisible = false;
            unawaited(showLoader(value: false));
          }
        },
        onWebResourceError: (WebResourceError error) {
          if (mounted) {
            _isLoaderVisible = false;
            unawaited(showLoader(value: false));
          }
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith(AppConstant.youtubeUrl)) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );

    // Clear previous cache
    await controller.clearCache();

    // Cache-busting URL
    final Uri freshUrl = Uri.parse(widget.url).replace(
      queryParameters: <String, dynamic>{
        ...Uri.parse(widget.url).queryParameters,
        'cacheBuster': DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );
    // Small delay before loading
    await Future<void>.delayed(const Duration(milliseconds: 100));

    if (mounted) {
      await controller.loadRequest(freshUrl);
    }

    // Save the controller to state
    _controller = controller;

    if (mounted) {
      setState(() {
        _isControllerReady = true;
      });
    }
  }

  Widget _buildView(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _forceHideLoader();
        }
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            ProductDetailsAppBar(
              onTap: () {
                _forceHideLoader();
                if (context.mounted) {
                  context.router.back();
                }
              },
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimens.fontSize14,
                color: MainConfig.appColors.redColor,
                height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
              ),
              backgroundProductDetails: MainConfig.appColors.secondaryColor,
              titleColors: MainConfig.appColors.mainColor,
              titleText: widget.title,
              isLastWidgetDisplay: false,
              prefixIcon: Assets.svgs.icBack.svg(
                height: Dimens.size24,
                width: Dimens.size24,
                colorFilter: ColorFilter.mode(
                  MainConfig.appColors.mainColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: _isControllerReady
                  ? SafeArea(
                top: false,
                child: WebViewWidget(controller: _controller),
              )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }
}
