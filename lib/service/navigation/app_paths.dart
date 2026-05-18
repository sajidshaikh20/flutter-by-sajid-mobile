/// A centralized class containing all the route paths used in the application.
///
/// Each constant represents a unique route name used for navigation
/// within the app. Sub-paths (nested routes) **must not** start with a `/`.
///
/// Example usage:
/// ```dart
/// context.router.pushNamed(AppPaths.dashboard);
/// ```
abstract class AppPaths {
  /// Dashboard or main landing page route.
  static const String dashboard = '/dashboard';

  /// Maintenance screen route.
  static const String maintenance = '/maintenance';

  /// Splash screen route.
  static const String splash = '/splash';

  /// Home page route (sub-path).
  static const String home = 'home';

  /// Transaction history page route (sub-path).
  static const String transactionHistory = 'transaction_history';

  /// Watchlist page route (sub-path).
  static const String watchlist = 'watchlist';

  /// Bank transfer page route (sub-path).
  static const String bankTransfer = 'bank_transfer';

  /// Chat support page route (sub-path).
  static const String chatSupport = 'chat_support';

  /// Service details page route.
  static const String serviceDetails = '/service_details';

  /// DMT (Domestic Money Transfer) details screen – beneficiary & customer info tabs.
  static const String dmtDetails = '/dmt_details';

  /// Payment success screen after successful OTP verification.
  static const String paymentSuccess = '/payment_success';

  /// Project Aether — single-screen MMORPG nervous system
  /// (World Pulse + Geo-Raid + Engagement Chat).
  static const String aether = '/aether';
}
