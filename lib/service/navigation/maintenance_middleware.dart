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
    // Get the ForceUpdate instance to check the app's update or
    // maintenance status
    ForceUpdateUnderMaintenanceCubit forceUpdate = ForceUpdateUnderMaintenanceCubit.instance();

    // Determine the type of update or maintenance required
    UpdateMaintenanceType type = forceUpdate.getUpdateOrMaintenanceType(await forceUpdate.readRemoteConfig());

    // If no update or maintenance is needed, continue the navigation
    if (type == UpdateMaintenanceType.none) {
      resolver.next();
    } else {
      // If maintenance or update is required, navigate to the maintenance page
      await router.pushNamed(AppPaths.maintenance);
    }
  }
}
