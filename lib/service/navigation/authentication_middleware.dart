import '../../utils/exports.dart';

/// Middleware for handling authentication-based navigation.
/// 
/// This middleware checks if the user is logged in and redirects accordingly.
/// If logged in, it navigates to the dashboard; otherwise, it allows normal navigation.
class AuthenticationMiddleWare extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    bool isLogin = SharedPref.instance.getBool(
      PrefsKey.isLoggedInKey,
      defValue: false,
    );
    if (isLogin) {
      // await router.pushNamed(AppPaths.dashboard);
      await router.replaceAll(<PageRouteInfo>[ AetherRoute()]);
    } else {
      resolver.next();
    }
  }
}
