import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../../../app/providers/providers.dart';

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
    // Get the context from the router's navigator key
    final BuildContext? context = router.navigatorKey.currentContext;
    
    // If context is not available yet (e.g., during early navigation),
    // allow navigation to proceed. The maintenance check will happen
    // on subsequent navigations when context is available.
    if (context == null) {
      resolver.next();
      return;
    }

    // Get the ForceUpdate instance to check the app's update or
    // maintenance status using ProviderScope
    final ProviderContainer container = ProviderScope.containerOf(context);
    final ForceUpdateNotifier forceUpdate = container.read(forceUpdateNotifierProvider.notifier);

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
