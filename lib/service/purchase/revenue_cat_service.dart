import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import '../../utils/exports.dart';

/// Centralized configuration for RevenueCat identifiers and product mapping.
class RevenueCatConfig {
  /// Entitlement ID for Pro features
  static const String proEntitlementId = "Weko Global Markets Ltd. Pro";

  /// Map representing local plan IDs/billing cycles mapped to Google Play/RevenueCat package identifiers
  /// Format: 'local_plan_id_billing_cycle' -> 'revenuecat_package_identifier'
  static const Map<String, String> planToPackageMap = <String, String>{
    'plan_elite_monthly': 'monthly',
    'plan_elite_yearly': 'yearly',
    'plan_crypto_monthly': 'monthly',
    'plan_crypto_yearly': 'yearly',
    'plan_forex_monthly': 'monthly',
    'plan_forex_yearly': 'yearly',
    'lifetime': 'lifetime',
  };
}

/// Service responsible for managing RevenueCat In-App Purchases & Subscriptions.
class RevenueCatService {
  /// Reactive status of whether the user is currently pro
  final ValueNotifier<bool> isPro = ValueNotifier<bool>(false);

  /// Platform-specific API key for RevenueCat
  static String get apiKey {
    final String envKey = configRevenueCatApiKey;
    if (envKey.isNotEmpty) {
      return envKey;
    }
    
    if (Platform.isIOS) {
      return 'test_RSEVRvYEwgagOBaaNXTlbOuEgkS';
    } else if (Platform.isAndroid) {
      return 'test_RSEVRvYEwgagOBaaNXTlbOuEgkS';
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }

  /// Initialize RevenueCat SDK
  Future<void> init() async {
    try {
      if (kDebugMode) {
        await Purchases.setLogLevel(LogLevel.debug);
      }

      final PurchasesConfiguration configuration = PurchasesConfiguration(apiKey);
      await Purchases.configure(configuration);

      DebugLog.instance.i("RevenueCatService: SDK initialized successfully.");

      // Set listener for real-time customer info changes
      Purchases.addCustomerInfoUpdateListener((CustomerInfo customerInfo) async {
        await _updateSubscriptionStatus(customerInfo);
      });

      // Load initial customer info
      final CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      await _updateSubscriptionStatus(customerInfo);
    } on Exception catch (e, stackTrace) {
      DebugLog.instance.e("RevenueCatService: Initialization failed: $e\n$stackTrace");
    }
  }

  /// Sync subscription status with local UserProfileService
  Future<void> _updateSubscriptionStatus(CustomerInfo customerInfo) async {
    final EntitlementInfo? activeEntitlement = customerInfo.entitlements.active[RevenueCatConfig.proEntitlementId];
    final bool isActive = activeEntitlement != null;
    isPro.value = isActive;

    DebugLog.instance.i("RevenueCatService: Subscription status isPro = $isActive");

    final UserProfileService userProfile = UserProfileService.instance();
    if (userProfile.isDataLoaded) {
      final bool currentLocalStatus = userProfile.isSubscriptionActive;
      if (currentLocalStatus != isActive) {
        await userProfile.updateUserProfile(
          isActive: isActive,
          subscriptionStatus: isActive ? 'ACTIVE' : 'INACTIVE',
          paymentStatus: isActive ? 'PAID' : 'UNPAID',
        );
        DebugLog.instance.i("RevenueCatService: Synced status with UserProfileService. active=$isActive");
      }
    }
  }

  /// Log in to RevenueCat with user's customer ID
  Future<void> logIn(String userId) async {
    try {
      final LogInResult logInResult = await Purchases.logIn(userId);
      await _updateSubscriptionStatus(logInResult.customerInfo);
      DebugLog.instance.i("RevenueCatService: User logged in: $userId");
    } on Exception catch (e) {
      DebugLog.instance.e("RevenueCatService: Login failed for $userId: $e");
    }
  }

  /// Log out of RevenueCat
  Future<void> logOut() async {
    try {
      final CustomerInfo customerInfo = await Purchases.logOut();
      await _updateSubscriptionStatus(customerInfo);
      DebugLog.instance.i("RevenueCatService: User logged out.");
    } on Exception catch (e) {
      DebugLog.instance.e("RevenueCatService: Logout failed: $e");
    }
  }

  /// Get available offerings/packages configured in the RevenueCat dashboard
  Future<Offerings?> getOfferings() async {
    try {
      return await Purchases.getOfferings();
    } on Exception catch (e) {
      DebugLog.instance.e("RevenueCatService: Failed to retrieve offerings: $e");
      return null;
    }
  }

  /// Purchase a package (Lifetime, Yearly, Monthly)
  Future<bool> purchasePackage(Package package) async {
    try {
      final PurchaseParams purchaseParams = PurchaseParams.package(package);
      final PurchaseResult result = await Purchases.purchase(purchaseParams);
      final CustomerInfo customerInfo = result.customerInfo;
      await _updateSubscriptionStatus(customerInfo);
      return customerInfo.entitlements.active[RevenueCatConfig.proEntitlementId] != null;
    } on PlatformException catch (e) {
      final PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        DebugLog.instance.w("RevenueCatService: Purchase cancelled by user.");
      } else {
        DebugLog.instance.e("RevenueCatService: Purchase failed (code $errorCode): ${e.message}");
      }
      return false;
    } on Exception catch (e) {
      DebugLog.instance.e("RevenueCatService: Purchase failed: $e");
      return false;
    }
  }

  /// Restore previous purchases
  Future<bool> restorePurchases() async {
    try {
      final CustomerInfo customerInfo = await Purchases.restorePurchases();
      await _updateSubscriptionStatus(customerInfo);
      return customerInfo.entitlements.active[RevenueCatConfig.proEntitlementId] != null;
    } on Exception catch (e) {
      DebugLog.instance.e("RevenueCatService: Restore purchases failed: $e");
      return false;
    }
  }

  /// Present the pre-built Paywall UI from RevenueCat
  Future<void> presentPaywall() async {
    try {
      await RevenueCatUI.presentPaywall();
    } on Exception catch (e) {
      DebugLog.instance.e("RevenueCatService: Failed to present paywall: $e");
    }
  }

  /// Present the Paywall UI if the user does not have the active entitlement
  Future<void> presentPaywallIfNeeded() async {
    try {
      await RevenueCatUI.presentPaywallIfNeeded(RevenueCatConfig.proEntitlementId);
    } on Exception catch (e) {
      DebugLog.instance.e("RevenueCatService: Failed to present paywall if needed: $e");
    }
  }

  /// Present the Customer Center UI for managing subscriptions (managing billing, restores, refunds)
  Future<void> presentCustomerCenter() async {
    try {
      await RevenueCatUI.presentCustomerCenter();
    } on Exception catch (e) {
      DebugLog.instance.e("RevenueCatService: Failed to present customer center: $e");
    }
  }
}
