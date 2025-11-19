import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;
import '../../../../utils/exports.dart' hide WebResourceResponse;
import '../../cubit/tabs_cubit.dart';
import '../../model/browser_tab_model.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({
    super.key,
    required this.tab,
    required this.cubit,
  });
  final BrowserTabModel tab;
  final TabsCubit cubit;

  @override
  State<WebViewContainer> createState() => WebViewContainerState();
}

class WebViewContainerState extends State<WebViewContainer> {
  InAppWebViewController? _webViewController;
  final TextEditingController _urlController = TextEditingController();
  String _lastLoadedUrl = '';

  @override
  void initState() {
    super.initState();
    _urlController.text = widget.tab.url;
    _lastLoadedUrl = widget.tab.url;
  }

  @override
  void didUpdateWidget(WebViewContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When tab changes, load the new URL if different
    if (oldWidget.tab.id != widget.tab.id || oldWidget.tab.url != widget.tab.url) {
      _urlController.text = widget.tab.url;
      // Load URL if it's different from what's currently loaded
      if (_webViewController != null && _lastLoadedUrl != widget.tab.url) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          unawaited(_loadUrlForTab(widget.tab.url));
        });
      }
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _loadUrlForTab(String url) async {
    if (_webViewController == null) return;
    
    String finalUrl = url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      if (url.contains('.') && !url.contains(' ')) {
        finalUrl = 'https://$url';
      } else {
        finalUrl = 'https://www.kuvaka.io/search?q=${Uri.encodeComponent(url)}';
      }
    }
    
    try {
      await _webViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(finalUrl)),
      );
      _lastLoadedUrl = finalUrl;
    } on Exception catch (e) {
      DebugLog.instance.e('Error loading URL: $e');
    }
  }

  InAppWebViewSettings _getPlatformSettings() {
    if (kIsWeb) {
      // Web/PWA settings
      return InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        useShouldOverrideUrlLoading: true,
        useOnLoadResource: true,
        allowsInlineMediaPlayback: true,
        mediaPlaybackRequiresUserGesture: false,
      );
    } else if (Platform.isAndroid) {
      // Android (Chromium-based) settings
      return InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        useHybridComposition: true,
        allowsInlineMediaPlayback: true,
        mediaPlaybackRequiresUserGesture: false,
        thirdPartyCookiesEnabled: true,
        supportMultipleWindows: true,
        javaScriptCanOpenWindowsAutomatically: true,
        useShouldOverrideUrlLoading: true,
        useOnLoadResource: true,
        builtInZoomControls: false,
        displayZoomControls: false,
      );
    } else if (Platform.isIOS) {
      // iOS (WebKit) settings
      return InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        allowsInlineMediaPlayback: true,
        mediaPlaybackRequiresUserGesture: false,
        allowsBackForwardNavigationGestures: true,
        isFraudulentWebsiteWarningEnabled: false,
        useShouldOverrideUrlLoading: true,
        useOnLoadResource: true,
        suppressesIncrementalRendering: false,
      );
    } else {
      // Default settings for other platforms
      return InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        allowsInlineMediaPlayback: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Progress indicator
        if (widget.tab.progress > 0 && widget.tab.progress < 1)
          LinearProgressIndicator(
            value: widget.tab.progress,
            backgroundColor: MainConfig.appColors.backgroundLightPinkColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              MainConfig.appColors.mainColor,
            ),
          ),
        // WebView
        Expanded(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.tab.url)),
            initialSettings: _getPlatformSettings(),
            onWebViewCreated: (InAppWebViewController controller) {
              _webViewController = controller;
              _lastLoadedUrl = widget.tab.url;
              // Load URL if it's different from initial
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_lastLoadedUrl != widget.tab.url) {
                  unawaited(_loadUrlForTab(widget.tab.url));
                }
              });
            },
            onLoadStart: (InAppWebViewController controller, WebUri? url) {
              if (url != null) {
                final String urlString = url.toString();
                _lastLoadedUrl = urlString;
                unawaited(widget.cubit.updateTabUrl(widget.tab.id, urlString));
                unawaited(widget.cubit.updateTabLoading(widget.tab.id, isLoading: true));
                _urlController.text = urlString;
              }
            },
            onLoadStop: (InAppWebViewController controller, WebUri? url) async {
              if (url != null) {
                await widget.cubit.updateTabUrl(widget.tab.id, url.toString());
                await widget.cubit.updateTabLoading(widget.tab.id, isLoading: false);
                _urlController.text = url.toString();

                // Get page title
                final String? title = await controller.getTitle();
                if (title != null) {
                  await widget.cubit.updateTabTitle(widget.tab.id, title);
                }

                // Update navigation state
                final bool canGoBack = await controller.canGoBack();
                final bool canGoForward = await controller.canGoForward();
                await widget.cubit.updateNavigationState(
                  widget.tab.id,
                  canGoBack: canGoBack,
                  canGoForward: canGoForward,
                );
              }
            },
            onProgressChanged: (InAppWebViewController controller, int progress) {
              final double progressValue = progress / 100.0;
              unawaited(widget.cubit.updateTabProgress(
                widget.tab.id,
                progressValue,
              ));
              // Set loading to false when progress reaches 100%
              if (progress == 100) {
                unawaited(widget.cubit.updateTabLoading(widget.tab.id, isLoading: false));
              }
            },
            onReceivedError: (InAppWebViewController controller, inapp.WebResourceRequest request, inapp.WebResourceError error) {
              // Set loading to false when error occurs
              unawaited(widget.cubit.updateTabLoading(widget.tab.id, isLoading: false));
              DebugLog.instance.e('WebView error: ${error.description}');
            },
            onReceivedHttpError: (InAppWebViewController controller, inapp.WebResourceRequest request, inapp.WebResourceResponse errorResponse) {
              // Set loading to false when HTTP error occurs
              unawaited(widget.cubit.updateTabLoading(widget.tab.id, isLoading: false));
              DebugLog.instance.e('WebView HTTP error: ${errorResponse.statusCode}');
            },
          ),
        ),
      ],
    );
  }

  Future<void> goBack() async {
    if (await _webViewController?.canGoBack() ?? false) {
      await _webViewController?.goBack();
    }
  }

  Future<void> goForward() async {
    if (await _webViewController?.canGoForward() ?? false) {
      await _webViewController?.goForward();
    }
  }

  Future<void> reload() async {
    await _webViewController?.reload();
  }

  Future<void> loadUrl(String url) async {
    String finalUrl = url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      // Check if it's a search query or domain
      if (url.contains('.') && !url.contains(' ')) {
        finalUrl = 'https://$url';
      } else {
        // Use kuvaka.io for search queries
        finalUrl = 'https://www.kuvaka.io/search?q=${Uri.encodeComponent(url)}';
      }
    }
    await _webViewController?.loadUrl(
      urlRequest: URLRequest(url: WebUri(finalUrl)),
    );
  }

  Future<String?> extractPageText() async {
    try {
      final String script = '''
        (function() {
          var text = document.body.innerText || document.body.textContent || '';
          return text.trim();
        })();
      ''';
      final dynamic result = await _webViewController?.evaluateJavascript(source: script);
      return result?.toString();
    } on Exception catch (e) {
      DebugLog.instance.e('Error extracting page text: $e');
      return null;
    }
  }
}
