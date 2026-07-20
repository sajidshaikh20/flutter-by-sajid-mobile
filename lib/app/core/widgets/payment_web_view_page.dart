import '../../../utils/exports.dart';

/// A page that displays the payment checkout URL inside an embedded In-App WebView
/// and listens exclusively to WebView events & redirections to confirm payment deposition.
@RoutePage()
class PaymentWebViewPage extends StatefulWidget {
  /// The payment checkout URL to load
  final String paymentUrl;

  /// Creates a [PaymentWebViewPage] with the given [paymentUrl].
  const PaymentWebViewPage({
    super.key,
    required this.paymentUrl,
  });

  @override
  PaymentWebViewPageState createState() => PaymentWebViewPageState();
}

/// State for [PaymentWebViewPage]
class PaymentWebViewPageState extends State<PaymentWebViewPage> with WidgetsBindingObserver {
  late final WebViewController _controller;

  bool _hasHandledCallback = false;
  bool _isLoadingPage = true;
  int _loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _initWebViewController();
  }

  void _initWebViewController() {
    _controller = WebViewController();
    unawaited(_controller.setJavaScriptMode(JavaScriptMode.unrestricted));
    unawaited(_controller.setBackgroundColor(Colors.transparent));
    
    // Add JavaScript Channel for web-to-app communication if gateway postMessages
    unawaited(
      _controller.addJavaScriptChannel(
        'PaymentListener',
        onMessageReceived: (JavaScriptMessage message) {
          DebugLog.instance.i('🟢 PaymentWebView JS Message: ${message.message}');
          final String lowerMsg = message.message.toLowerCase();
          if (lowerMsg.contains('success') || lowerMsg.contains('paid') || lowerMsg.contains('complete')) {
            unawaited(_handlePaymentSuccess());
          }
        },
      ),
    );

    unawaited(
      _controller.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                _loadingProgress = progress;
                _isLoadingPage = progress < 100;
              });
            }
          },
          onPageStarted: (String url) {
            DebugLog.instance.i('🔵 PaymentWebView PageStarted: $url');
            if (mounted) {
              setState(() {
                _isLoadingPage = true;
              });
            }
            _checkUrlForSuccess(url);
          },
          onPageFinished: (String url) {
            DebugLog.instance.i('🔵 PaymentWebView PageFinished: $url');
            if (mounted) {
              setState(() {
                _isLoadingPage = false;
              });
            }
            _checkUrlForSuccess(url);
          },
          onUrlChange: (UrlChange change) {
            if (change.url != null) {
              DebugLog.instance.i('🔵 PaymentWebView UrlChange: ${change.url}');
              _checkUrlForSuccess(change.url!);
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            DebugLog.instance.i('🔵 PaymentWebView NavigationRequest: ${request.url}');
            if (_isSuccessRedirectUrl(request.url)) {
              unawaited(_handlePaymentSuccess());
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
    unawaited(_controller.loadRequest(Uri.parse(widget.paymentUrl)));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Checks if the webview URL indicates a successful payment completion or redirect.
  bool _isSuccessRedirectUrl(String url) {
    final String lowerUrl = url.toLowerCase();
    return lowerUrl.contains('payment-success') ||
        lowerUrl.contains('status=success') ||
        lowerUrl.contains('status=completed') ||
        lowerUrl.contains('payment_status=success') ||
        lowerUrl.contains('payment/success') ||
        lowerUrl.contains('deposit/success') ||
        lowerUrl.contains('success_callback') ||
        lowerUrl.contains('thankyou') ||
        lowerUrl.contains('thank-you') ||
        lowerUrl.contains('approved') ||
        lowerUrl.contains('status=active') ||
        lowerUrl.contains('payment_completed');
  }

  void _checkUrlForSuccess(String url) {
    if (_isSuccessRedirectUrl(url)) {
      DebugLog.instance.i('🟢 PaymentWebView: Success URL pattern matched: $url');
      unawaited(_handlePaymentSuccess());
    }
  }

  /// Handles successful payment completion: updates local profile and pops back.
  Future<void> _handlePaymentSuccess() async {
    if (_hasHandledCallback) return;
    _hasHandledCallback = true;

    DebugLog.instance.i('🟢 PaymentWebView: Payment deposition completed! Updating status & popping back...');

    // Update local profile state
    await UserProfileService.instance().updateUserProfile(
      paymentStatus: 'SUCCESS',
      subscriptionStatus: 'ACTIVE',
      isActive: true,
    );

    if (mounted) {
      displaySnackBar('Payment deposited & subscription activated successfully!', context);
      await context.router.maybePop("success");
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color backgroundColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color cardBgColor = isDark ? AppColors.surfaceDark : Colors.white;
    final Color textColor = isDark ? Colors.white : AppColors.textPrimaryLight;

    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (_hasHandledCallback) return;
        _hasHandledCallback = true;
        if (mounted) {
          await context.router.maybePop("Goback");
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // Top Bar
              CustomAppBar(
                title: 'Deposit & Payment',
                onTap: () async {
                  if (_hasHandledCallback) return;
                  _hasHandledCallback = true;
                  await context.router.maybePop("Goback");
                },
              ),

              // Web Loading Indicator
              if (_isLoadingPage)
                LinearProgressIndicator(
                  value: _loadingProgress > 0 ? _loadingProgress / 100.0 : null,
                  backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
                  minHeight: 3,
                ),

              // Embedded In-App WebView
              Expanded(
                child: CustomWebView(
                  webViewController: _controller,
                ),
              ),

              // Bottom Status & Manual Completion Bar (No API Polling)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: cardBgColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Listening for payment deposition...',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: textColor.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _handlePaymentSuccess,
                      child: const Text(
                        'Payment Done',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
