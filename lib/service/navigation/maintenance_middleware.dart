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
    // If launched via a notification, let navigation continue; maintenance screen can be handled later if needed

    // Get the ForceUpdate instance to check the app's update or
    // maintenance status
    ForceUpdateUnderMaintenanceCubit forceUpdate =
        ForceUpdateUnderMaintenanceCubit.instance();

    final UpdateMaintenanceType type = await forceUpdate.checkAppUpdate();

    if (type == UpdateMaintenanceType.none) {
      resolver.next();
    } else {
      await router.pushPath(AppPaths.maintenance);
      resolver.next(false);
    }
  }
}
