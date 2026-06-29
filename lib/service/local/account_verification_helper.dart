import '../../utils/exports.dart';

/// Account verification status values stored in [PrefsKey.accountVerificationStatusKey].
abstract class AccountVerificationStatus {
  /// Verification is under review.
  static const String pending = 'pending';

  /// Account is fully verified.
  static const String verified = 'verified';
}

/// Reads and writes account verification status for post-login routing.
class AccountVerificationHelper {
  AccountVerificationHelper._();

  /// Marks the account as pending verification (e.g. after login/sign up).
  static Future<void> setPending() async {
    await SharedPref.instance.setValue(
      PrefsKey.accountVerificationStatusKey,
      AccountVerificationStatus.pending,
    );
  }

  /// Marks the account as verified (e.g. after admin approval).
  static Future<void> setVerified() async {
    await SharedPref.instance.setValue(
      PrefsKey.accountVerificationStatusKey,
      AccountVerificationStatus.verified,
    );
  }

  /// Whether the user is logged in but verification is still pending.
  static bool isPending() {
    final String status = SharedPref.instance.getString(
      PrefsKey.accountVerificationStatusKey,
      '',
    );
    return status == AccountVerificationStatus.pending;
  }

  /// Whether the account has passed verification.
  static bool isVerified() {
    return SharedPref.instance.getString(
          PrefsKey.accountVerificationStatusKey,
          '',
        ) ==
        AccountVerificationStatus.verified;
  }

  /// Route to show after a successful login.
  static PageRouteInfo resolvePostLoginRoute() {
    return const DashboardRoute();
  }

  /// Path for splash when user is already logged in.
  static String resolveLoggedInPath() {
    return AppPaths.dashboard;
  }
}
