import '../../../utils/exports.dart';


/// A page that launches the payment URL in the system's external browser
/// and monitors app lifecycle state to check payment status when the user returns.
@RoutePage()
class PaymentWebViewPage extends StatefulWidget {
  /// The payment URL to load
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
  bool _hasHandledCallback = false;
  bool _isCheckingStatus = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Auto-launch the external browser after the UI renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_launchExternalBrowser());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      DebugLog.instance.i('🔵 PaymentWebView: App resumed. Checking subscription status...');
      unawaited(_checkPaymentStatus(showFeedbackOnPending: false));
    }
  }

  Future<void> _launchExternalBrowser() async {
    final Uri uri = Uri.parse(widget.paymentUrl);
    try {
      DebugLog.instance.i('🔵 PaymentWebView: Launching payment URL: ${widget.paymentUrl}');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        DebugLog.instance.e('🔴 PaymentWebView: Could not launch $uri');
      }
    } on Object catch (e) {
      DebugLog.instance.e('🔴 PaymentWebView: Error launching external browser: $e');
    }
  }

  /// Verifies the payment/subscription status with the backend.
  Future<void> _checkPaymentStatus({required bool showFeedbackOnPending}) async {
    if (_isCheckingStatus || _hasHandledCallback) return;

    setState(() {
      _isCheckingStatus = true;
    });

    try {
      // Call the API to fetch latest client profile data
      final ResponseHandler<Map<String, dynamic>?> rawResponse = await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
        endUrl: Apis.getClientProfile,
        showLoader: true,
      );

      if (rawResponse.isSuccess()) {
        final Map<String, dynamic>? responseData = rawResponse.getSuccessInstance()?.response;
        if (responseData != null) {
          final Map<String, dynamic>? dataMap = responseData['data'] as Map<String, dynamic>?;
          if (dataMap != null) {
            final Map<String, dynamic>? activeSub = dataMap['activeSubscription'] as Map<String, dynamic>?;
            final bool isSubActive = dataMap['isActive'] == true || 
                                    (activeSub != null && activeSub['isActive'] == true) ||
                                    (activeSub != null && activeSub['subscriptionStatus']?.toString().toUpperCase() == 'ACTIVE');

            DebugLog.instance.i('🔵 PaymentWebView: Checked status. isSubActive = $isSubActive');

            if (isSubActive) {
              // Update the local UserProfileService
              await UserProfileService.instance().updateUserProfile(
                paymentStatus: activeSub?['paymentStatus']?.toString() ?? 'SUCCESS',
                subscriptionStatus: activeSub?['subscriptionStatus']?.toString() ?? 'ACTIVE',
                isActive: true,
                subscriptionPublicId: activeSub?['subscriptionPublicId']?.toString() ?? dataMap['subscriptionPublicId']?.toString(),
                planName: activeSub?['planName']?.toString() ?? dataMap['planName']?.toString(),
                planCode: activeSub?['planCode']?.toString() ?? dataMap['planCode']?.toString(),
                category: activeSub?['category']?.toString() ?? dataMap['category']?.toString(),
                billingCycle: activeSub?['billingCycle']?.toString() ?? dataMap['billingCycle']?.toString(),
                amount: activeSub?['amount'] != null 
                    ? double.tryParse(activeSub!['amount'].toString()) 
                    : (dataMap['amount'] != null ? double.tryParse(dataMap['amount'].toString()) : null),
                currencyCode: activeSub?['currencyCode']?.toString() ?? dataMap['currencyCode']?.toString(),
                startDate: activeSub?['startDate']?.toString() ?? dataMap['startDate']?.toString(),
                endDate: activeSub?['endDate']?.toString() ?? dataMap['endDate']?.toString(),
                durationDays: activeSub?['durationDays'] != null 
                    ? int.tryParse(activeSub!['durationDays'].toString()) 
                    : (dataMap['durationDays'] != null ? int.tryParse(dataMap['durationDays'].toString()) : null),
              );

              if (mounted) {
                _hasHandledCallback = true;
                displaySnackBar('Subscription activated successfully!', context);
                unawaited(context.router.maybePop("success"));
              }
              return;
            }
          }
        }
      }

      if (showFeedbackOnPending && mounted) {
        displaySnackBar(
          "We couldn't verify your active subscription yet. Crypto payments can take 1-3 minutes to confirm.",
          context,
        );
      }
    } on Object catch (e) {
      DebugLog.instance.e('🔴 PaymentWebView: Error checking status: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingStatus = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color backgroundColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color textColor = isDark ? Colors.white : AppColors.textPrimaryLight;
    final Color subTextColor = isDark ? Colors.grey[400]! : Colors.grey[600]!;

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
              CustomAppBar(
                title: 'Crypto Payment',
                onTap: () async {
                  if (_hasHandledCallback) return;
                  _hasHandledCallback = true;
                  await context.router.maybePop("Goback");
                },
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Card(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // Decorative pulsing icons or progress indicator
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: AppColors.primaryPurple.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.open_in_browser_rounded,
                                size: 48,
                                color: AppColors.primaryPurple,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Complete Payment in Browser',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'We have opened the Match2Pay checkout page in your default browser. Please complete your transaction there.',
                              style: TextStyle(
                                fontSize: 14,
                                color: subTextColor,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Crypto transactions typically take 1 to 3 minutes to confirm.',
                              style: TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                color: AppColors.primaryPurple.withValues(alpha: 0.8),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            // Primary Action Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryPurple,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: _isCheckingStatus
                                    ? null
                                    : () => _checkPaymentStatus(showFeedbackOnPending: true),
                                child: _isCheckingStatus
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : const Text(
                                        'Check Payment Status',
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Reopen Browser Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppColors.primaryPurple),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: _isCheckingStatus ? null : _launchExternalBrowser,
                                child: const Text(
                                  'Reopen Checkout Page',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryPurple),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextButton(
                              onPressed: () async {
                                if (_hasHandledCallback) return;
                                _hasHandledCallback = true;
                                await context.router.maybePop("Goback");
                              },
                              child: Text(
                                'Cancel & Go Back',
                                style: TextStyle(
                                  color: Colors.red[400],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
