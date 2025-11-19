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
    
    // Only handle URL changes if it's a different tab or different URL
    if (oldWidget.tab.id != widget.tab.id) {
      // Different tab - update controller and load if needed
      _urlController.text = widget.tab.url;
      if (_lastLoadedUrl != widget.tab.url && _webViewController != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          unawaited(_loadUrlForTab(widget.tab.url));
        });
      }
    } else if (oldWidget.tab.url != widget.tab.url && _webViewController != null) {
      // Same tab but URL changed - load new URL
      _urlController.text = widget.tab.url;
        if (_lastLoadedUrl != widget.tab.url) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            unawaited(_loadUrlForTab(widget.tab.url));
          });
      }
    }
    
    // Always update navigation state when switching tabs
    if (oldWidget.tab.id != widget.tab.id && _webViewController != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            unawaited(_updateNavigationState());
          });
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _loadUrlForTab(String url) async {
    if (_webViewController == null) return;

    final String finalUrl = _validateAndFormatUrl(url);

    try {
      await _webViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(finalUrl)),
      );
      _lastLoadedUrl = finalUrl;
    } on Exception catch (e) {
      DebugLog.instance.e('Error loading URL: $e');
      if (mounted) {
        displaySnackBar('Failed to load URL: $e', context);
      }
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
    // On web, show a fallback UI since InAppWebView has CORS limitations
    if (kIsWeb) {
      return _buildWebFallback(context);
    }

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
              // Initialize navigation state
              unawaited(_updateNavigationStateFromController(controller));
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
                // Reset progress when loading starts
                unawaited(widget.cubit.updateTabProgress(widget.tab.id, 0.0));
                unawaited(widget.cubit.updateTabUrl(widget.tab.id, urlString));
                unawaited(widget.cubit
                    .updateTabLoading(widget.tab.id, isLoading: true));
                _urlController.text = urlString;
                // Update navigation state when loading starts
                unawaited(_updateNavigationStateFromController(controller));
              }
            },
            onLoadStop: (InAppWebViewController controller, WebUri? url) async {
              if (url != null) {
                final String urlString = url.toString();
                _lastLoadedUrl = urlString;
                await widget.cubit.updateTabUrl(widget.tab.id, urlString);
                // Reset progress to 0 and set loading to false when page finishes
                await widget.cubit.updateTabProgress(widget.tab.id, 0.0);
                await widget.cubit
                    .updateTabLoading(widget.tab.id, isLoading: false);
                _urlController.text = urlString;

                // Get page title
                final String? title = await controller.getTitle();
                if (title != null && title.isNotEmpty) {
                  await widget.cubit.updateTabTitle(widget.tab.id, title);
                }

                // Update navigation state
                await _updateNavigationStateFromController(controller);
              }
            },
            onUpdateVisitedHistory: (InAppWebViewController controller, WebUri? url, bool? isReload) async {
              // This is called when navigation history is updated (e.g., when clicking links)
              if (url != null) {
                final String urlString = url.toString();
                _lastLoadedUrl = urlString;
                await widget.cubit.updateTabUrl(widget.tab.id, urlString);
                _urlController.text = urlString;
                
                // Update navigation state after history change
                await _updateNavigationStateFromController(controller);
              }
            },
            shouldOverrideUrlLoading: (InAppWebViewController controller, inapp.NavigationAction navigationAction) async {
              // Allow all navigation - don't block any URLs
              final WebUri? uri = navigationAction.request.url;
              if (uri != null) {
                final String urlString = uri.toString();
                DebugLog.instance.d('Navigating to: $urlString');
                // Update URL immediately when navigation is triggered
                unawaited(widget.cubit.updateTabUrl(widget.tab.id, urlString));
              }
              return inapp.NavigationActionPolicy.ALLOW;
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              final double progressValue = progress / 100.0;
              unawaited(widget.cubit.updateTabProgress(
                widget.tab.id,
                progressValue,
              ));
              // Set loading to false and reset progress when progress reaches 100%
              if (progress == 100) {
                unawaited(widget.cubit
                    .updateTabLoading(widget.tab.id, isLoading: false));
                // Update navigation state when page finishes loading
                unawaited(_updateNavigationStateFromController(controller));
                // Reset progress after a short delay to hide the progress bar
                Future<void>.delayed(const Duration(milliseconds: 300), () {
                  unawaited(widget.cubit.updateTabProgress(widget.tab.id, 0.0));
                });
              }
            },
            onReceivedError: (InAppWebViewController controller,
                inapp.WebResourceRequest request,
                inapp.WebResourceError error) {
              // Set loading to false and reset progress when error occurs
              unawaited(widget.cubit
                  .updateTabLoading(widget.tab.id, isLoading: false));
              unawaited(widget.cubit.updateTabProgress(widget.tab.id, 0.0));
              
              // Log error details
              DebugLog.instance.e('WebView error: ${error.description}');
              DebugLog.instance.e('Error type: ${error.type}');
              
              // Show user-friendly error message
              final String errorMessage = _getErrorMessage(error);
              if (errorMessage.isNotEmpty && mounted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    displaySnackBar(errorMessage, context);
                  }
                });
              }
            },
            onReceivedHttpError: (InAppWebViewController controller,
                inapp.WebResourceRequest request,
                inapp.WebResourceResponse errorResponse) {
              // Set loading to false and reset progress when HTTP error occurs
              unawaited(widget.cubit
                  .updateTabLoading(widget.tab.id, isLoading: false));
              unawaited(widget.cubit.updateTabProgress(widget.tab.id, 0.0));
              
              // Log HTTP error
              DebugLog.instance
                  .e('WebView HTTP error: ${errorResponse.statusCode}');
              
              // Show user-friendly error message
              final int? statusCode = errorResponse.statusCode;
              if (statusCode != null) {
                final String errorMessage = _getHttpErrorMessage(statusCode);
                if (errorMessage.isNotEmpty && mounted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      displaySnackBar(errorMessage, context);
                    }
                  });
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> goBack() async {
    if (_webViewController != null) {
      final bool canGoBack = await _webViewController!.canGoBack();
      if (canGoBack) {
        await _webViewController!.goBack();
        // Wait a bit for navigation to complete, then update state
        await Future<void>.delayed(const Duration(milliseconds: 100));
      await _updateNavigationState();
      }
    }
  }

  Future<void> goForward() async {
    if (_webViewController != null) {
      final bool canGoForward = await _webViewController!.canGoForward();
      if (canGoForward) {
        await _webViewController!.goForward();
        // Wait a bit for navigation to complete, then update state
        await Future<void>.delayed(const Duration(milliseconds: 100));
      await _updateNavigationState();
      }
    }
  }

  Future<void> _updateNavigationState() async {
    if (_webViewController != null) {
      await _updateNavigationStateFromController(_webViewController!);
    }
  }

  Future<void> _updateNavigationStateFromController(
      InAppWebViewController controller) async {
    try {
      final bool canGoBack = await controller.canGoBack();
      final bool canGoForward = await controller.canGoForward();
      await widget.cubit.updateNavigationState(
        widget.tab.id,
        canGoBack: canGoBack,
        canGoForward: canGoForward,
      );
    } on Exception catch (e) {
      DebugLog.instance.e('Error updating navigation state: $e');
    }
  }

  Future<void> reload() async {
    await _webViewController?.reload();
  }

  String _validateAndFormatUrl(String url) {
    if (url.isEmpty) return 'https://www.google.com';
    
    String formattedUrl = url.trim();
    
    // Add protocol if missing
    if (!formattedUrl.startsWith('http://') && !formattedUrl.startsWith('https://')) {
      // Check if it looks like a domain
      if (formattedUrl.contains('.') && !formattedUrl.contains(' ')) {
        formattedUrl = 'https://$formattedUrl';
      } else {
        // Treat as search query
        formattedUrl = 'https://www.google.com/search?q=${Uri.encodeComponent(formattedUrl)}';
      }
    }
    
    return formattedUrl;
  }

  Future<void> loadUrl(String url) async {
    if (url.isEmpty) return;
    
    final String finalUrl = _validateAndFormatUrl(url);
    
    try {
    await _webViewController?.loadUrl(
      urlRequest: URLRequest(url: WebUri(finalUrl)),
    );
      _lastLoadedUrl = finalUrl;
    } on Exception catch (e) {
      DebugLog.instance.e('Error loading URL: $e');
      if (mounted) {
        displaySnackBar('Failed to load URL: $e', context);
      }
    }
  }

  Future<String?> extractPageText() async {
    try {
      final String script = '''
        (function() {
          var text = document.body.innerText || document.body.textContent || '';
          return text.trim();
        })();
      ''';
      final dynamic result =
          await _webViewController?.evaluateJavascript(source: script);
      return result?.toString();
    } on Exception catch (e) {
      DebugLog.instance.e('Error extracting page text: $e');
      return null;
    }
  }

  String _getErrorMessage(inapp.WebResourceError error) {
    // Map error types to user-friendly messages
    final String description = error.description.toLowerCase();
    
    if (description.contains('host lookup') || description.contains('dns')) {
      return 'Unable to connect. Please check your internet connection.';
    } else if (description.contains('timeout')) {
      return 'Connection timeout. Please try again.';
    } else if (description.contains('connect') || description.contains('connection')) {
      return 'Failed to connect to server. Please check your internet connection.';
    } else if (description.contains('network') || description.contains('unreachable')) {
      return 'Network error. Please check your internet connection.';
    } else {
      return 'Failed to load page. Please try again.';
    }
  }

  String _getHttpErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. The server could not understand your request.';
      case 401:
        return 'Unauthorized. Please check your credentials.';
      case 403:
        return "Access forbidden. You don't have permission to access this resource.";
      case 404:
        return 'Page not found. The requested page does not exist.';
      case 500:
        return 'Server error. The server encountered an error.';
      case 502:
        return 'Bad gateway. The server is temporarily unavailable.';
      case 503:
        return 'Service unavailable. The server is temporarily down.';
      default:
        return 'HTTP error $statusCode. Please try again later.';
    }
  }

  /// Build fallback UI for web platform
  /// Since InAppWebView on web has CORS limitations, we provide
  /// an option to open URLs in a new browser tab
  Widget _buildWebFallback(BuildContext context) {
    final String url = widget.tab.url;
    final String displayUrl = url.isEmpty ? 'https://www.google.com' : url;
    
    return Column(
      children: <Widget>[
        // Progress indicator (always hidden on web fallback)
        const SizedBox.shrink(),
        // Web fallback content
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.space24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.language,
                    size: Dimens.size64,
                    color: MainConfig.appColors.mainColor,
                  ),
                  const SizedBox(height: Dimens.space24),
                  Text(
                    'In-App Browser on Web',
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: MainConfig.appColors.textBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Dimens.space16),
                  Text(
                    'Due to browser security restrictions, external websites cannot be loaded in an in-app webview on web platforms.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: MainConfig.appColors.textMediumDarkBlueColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Dimens.space32),
                  Container(
                    padding: const EdgeInsets.all(Dimens.space16),
                    decoration: BoxDecoration(
                      color: MainConfig.appColors.backgroundLightPinkColor,
                      borderRadius: BorderRadius.circular(Dimens.radius12),
                      border: Border.all(
                        color: MainConfig.appColors.mainColor.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            displayUrl,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: MainConfig.appColors.textBlackColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimens.space32),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final String finalUrl = _validateAndFormatUrl(displayUrl);
                      try {
                        await launchUrl(
                          Uri.parse(finalUrl),
                          mode: LaunchMode.externalApplication,
                        );
                      } on Exception catch (e) {
                        if (!mounted) return;
                        // Using this.context after mounted check is safe
                        // ignore: use_build_context_synchronously
                        displaySnackBar(
                          'Failed to open URL: $e',
                          this.context,
                        );
                      }
                    },
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open in Browser'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MainConfig.appColors.mainColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.space24,
                        vertical: Dimens.space16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

