/// A centralized class containing all the route paths used in the application.
///
/// Each constant represents a unique route name used for navigation
/// within the app. Sub-paths (nested routes) **must not** start with a `/`.
///
/// Example usage:
/// ```dart
/// context.router.pushPath(AppPaths.dashboard);
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

  /// My trades tab (sub-path).
  static const String myTrades = 'my_trades';

  /// Trades tab (sub-path).
  static const String trades = 'trades';

  /// Tool tab (sub-path).
  static const String tool = 'tool';

  /// Settings tab (sub-path).
  static const String settings = 'settings';

  /// Transaction history page route (sub-path) — legacy.
  static const String transactionHistory = 'transaction_history';

  /// Bank transfer page route (sub-path) — legacy.
  static const String bankTransfer = 'bank_transfer';

  /// Chat support page route (sub-path) — legacy.
  static const String chatSupport = 'chat_support';

  /// Service details page route.
  static const String serviceDetails = '/service_details';

  /// DMT (Domestic Money Transfer) details screen – beneficiary & customer info tabs.
  static const String dmtDetails = '/dmt_details';

  /// Payment success screen after successful OTP verification.
  static const String paymentSuccess = '/payment_success';

  /// Social login screen route.
  static const String socialLogin = '/social_login';

  /// Login screen route.
  static const String login = '/login';

  /// Forgot password screen route.
  static const String forgotPassword = '/forgot_password';

  /// Sign up screen route.
  static const String signUp = '/signup';

  /// Sign up step 1 – basic info (sub-path).
  static const String signUpBasicInfo = 'basic_info';

  /// Sign up step 2 – verification (sub-path).
  static const String signUpVerification = 'verification';

  /// Sign up step 3 – complete profile (sub-path).
  static const String signUpCompleteProfile = 'complete_profile';

  /// Account verification pending screen (post-login).
  static const String verificationPending = '/verification_pending';
}
