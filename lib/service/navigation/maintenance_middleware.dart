import '../../../utils/exports.dart';

/// Middleware to check if the app is under maintenance or requires an update.
/// If maintenance or update is required, navigates to the maintenance page.
class MaintenanceMiddleware extends AutoRouteGuard {
  /// Called on navigation to check if the app requires an update or
  /// is under maintenance.
  /// If maintenance or update is required, the user is redirected to
  /// the maintenance page.
  /// Otherwise, the navigation continues as usual.
  @override
  Future<void> onNavigation(
      NavigationResolver resolver,
      StackRouter router,
      ) async {
    // Do not block first paint on Remote Config (network can take several seconds).
    resolver.next();
    unawaited(_checkMaintenanceInBackground(router));
  }

  Future<void> _checkMaintenanceInBackground(StackRouter router) async {
    try {
      final ForceUpdateUnderMaintenanceCubit forceUpdate =
          ForceUpdateUnderMaintenanceCubit.instance();
      final ForceUpdateConfigModel? config = await forceUpdate
          .readRemoteConfig()
          .timeout(const Duration(seconds: 3), onTimeout: () => null);
      final UpdateMaintenanceType type =
          forceUpdate.getUpdateOrMaintenanceType(config);

      if (type != UpdateMaintenanceType.none &&
          router.navigatorKey.currentContext?.mounted == true) {
        await router.pushPath(AppPaths.maintenance);
      }
    } on Exception catch (e) {
      DebugLog.instance.i('MaintenanceMiddleware: remote config skipped: $e');
    }
  }
}
