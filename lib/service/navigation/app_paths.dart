/// A centralized class containing all the route paths used in the application.
///
/// Each constant represents a unique route name used for navigation
/// within the app. Sub-paths (nested routes) **must not** start with a `/`.
///
/// Example usage:
/// ```dart
/// context.router.pushNamed(AppPaths.login);
/// ```
abstract class AppPaths {
  /// Login screen route.
  static const String login = '/login';

  /// Dashboard or main landing page route.
  static const String dashboard = '/dashboard';

  /// Maintenance screen route.
  static const String maintenance = '/maintenance';

  /// Splash screen route.
  static const String splash = '/splash';

  /// Social login screen route.
  static const String socialLogin = '/socialLogin';

  /// Forgot password page route.
  static const String forgotPassword = '/forgetPassword';

  /// Signup or registration page route.
  static const String signup = '/signup';

  /// Language selection screen route.
  static const String languageSelection = '/selectLanguage';

  /// OTP verification route used for account validation.
  static const String verifyOtp = '/verifyOtp';

  /// Home page route (sub-path).
  static const String home = 'home';

  /// Category page route (sub-path).
  static const String category = 'category';

  /// Account or profile page route (sub-path).
  static const String account = 'account';

  /// Wishlist page route (sub-path).
  static const String wishlist = 'wishlist';

  /// Payment screen route.
  static const String payment = '/payment';

  /// Notification page route (sub-path).
  static const String notification = 'notification';

  /// Data not found placeholder page route.
  static const String dataNotFound = '/dataNotFound';
}
