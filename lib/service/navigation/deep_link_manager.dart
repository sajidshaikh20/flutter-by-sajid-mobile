import '../../utils/exports.dart';

/// A manager class to handle deep link navigation from notifications.
class DeepLinkManager {
  DeepLinkManager._internal();

  /// Singleton instance of DeepLinkManager.
  static final DeepLinkManager instance = DeepLinkManager._internal();

  bool _isProcessing = false;
  Map<String, dynamic>? _pendingDeepLink;

  /// Handles deep link navigation using payload data.
  Future<void> handleDeepLink(Map<String, dynamic> data) async {
    final bool isLoggedIn = SharedPref.instance.getBool(PrefsKey.isLoggedInKey, defValue: false);
    if (!isLoggedIn) {
      DebugLog.instance.w('DeepLinkManager: User not logged in. Saving deep link and redirecting to login.');
      _pendingDeepLink = data;

      final AppRouter router = getIt<AppRouter>();
      final String currentPath = router.currentPath;
      if (currentPath != AppPaths.login &&
          currentPath != AppPaths.socialLogin &&
          currentPath != AppPaths.whatsappLogin) {
        unawaited(router.push(LoginRoute()));
      }
      return;
    }

    final bool isReady = getIt.isRegistered<AppRouter>() &&
        getIt<AppRouter>().navigatorKey.currentContext != null &&
        getIt<TabRouterService>().tabsRouterContext != null;

    if (!isReady) {
      DebugLog.instance.i('DeepLinkManager: App not fully ready yet. Saving deep link as pending.');
      _pendingDeepLink = data;
      return;
    }

    if (_isProcessing) return;
    _isProcessing = true;

    try {
      DebugLog.instance.i('DeepLinkManager: Handling deep link with data: $data');

      final String type = (data['notificationType'] ?? data['type'])?.toString().toLowerCase() ?? '';
      final String tradePublicId = data['tradePublicId']?.toString() ??
          data['id']?.toString() ??
          data['tradeId']?.toString() ??
          '';



      DebugLog.instance.i('DeepLinkManager: Parsed type = "$type", entityId = "$tradePublicId"');
      DebugLog.instance.i('DeepLinkManager: Parsed type = "$type", entityId = "$tradePublicId"');


      if (type == 'trade' ||
          type == 'signal' ||
          type == 'trade_alert' ||
          type == 'trade_signal' ||
          type.contains('trade') ||
          type.contains('signal')) {
        if (tradePublicId.isEmpty) {
          DebugLog.instance.w('DeepLinkManager: Empty trade entity ID. Aborting.');
          _isProcessing = false;
          return;
        }
        DebugLog.instance.i('DeepLinkManager: Showing EasyLoading...');
        DebugLog.instance.i('DeepLinkManager: Fetching trade details for tradeId = $tradePublicId');
        final TradesRepositoryImpl repository = TradesRepositoryImpl();
        final ResponseHandler<BaseResponse<TradeResponse>> response = await repository.getTradeDetails(tradePublicId);

        DebugLog.instance.i('DeepLinkManager: API finished. Dismissing EasyLoading...');

        DebugLog.instance.i('DeepLinkManager: API response success status = ${response.isSuccess()}');

        if (response.isSuccess()) {
          final TradeResponse? tradeResponse = response.getSuccessInstance()?.response.data;
          DebugLog.instance.i('DeepLinkManager: Trade response data exists = ${tradeResponse != null}');
          if (tradeResponse != null) {
            final TradingSignalModel signal = tradeResponse.toTradingSignalModel();
            DebugLog.instance.i('DeepLinkManager: Mapped TradingSignalModel publicId = "${signal.publicId}"');
            final AppRouter router = getIt<AppRouter>();
            DebugLog.instance.i('DeepLinkManager: Pushing TradingOverviewRoute...');
            await router.push(TradingOverviewRoute(signal: signal));
            DebugLog.instance.i('DeepLinkManager: Route pushed successfully.');
          } else {
            DebugLog.instance.e('DeepLinkManager: Trade response data is null');
          }
        } else {
          final String errorMsg =
              response.getFailureInstance()?.error?.errorMessage ?? 'Failed to load trade';
          DebugLog.instance.e('DeepLinkManager: Error fetching trade details: $errorMsg');
        }
      } else if (type == 'notification' || type == 'general') {
        final AppRouter router = getIt<AppRouter>();
        DebugLog.instance.i('DeepLinkManager: Pushing NotificationRoute...');
        await router.push(const NotificationRoute());
        DebugLog.instance.i('DeepLinkManager: NotificationRoute pushed successfully.');
      } else {
        DebugLog.instance.w('DeepLinkManager: Unknown type "$type". No navigation matches.');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('DeepLinkManager: Exception handling deep link: $e');
    } finally {
      _isProcessing = false;
    }
  }

  /// Checks and processes any pending deep link that was saved.
  void checkAndProcessPendingDeepLink() {
    if (_pendingDeepLink != null) {
      final Map<String, dynamic> data = _pendingDeepLink!;
      _pendingDeepLink = null;
      DebugLog.instance.i('DeepLinkManager: Processing pending deep link.');
      unawaited(handleDeepLink(data));
    }
  }
}
