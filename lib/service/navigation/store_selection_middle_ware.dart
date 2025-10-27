import '../../utils/exports.dart';

/// Middleware for handling store selection navigation.
/// 
/// This middleware checks if a store is selected and redirects to the
/// store selection page if no store is currently selected.
class StoreSelectionMiddleWare extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver,
      StackRouter router,
      ) async {
    final int? store = getIt<CountryService>().store;

    if (store == null) {
      // If store is null, redirect to SelectAddressRoute
     /* await router.replaceAll(
          <PageRouteInfo>[
      const DashboardRoute(),
        SelectAddressRoute(
        isFromStoreSelection: true,
      )]);*/

      await router.pushAndPopUntil(
        SelectAddressRoute(isFromStoreSelection: true),
        predicate: (Route<dynamic>  route) => route.settings.name == DashboardRoute.name,
      );
    } else {
      // Otherwise, allow navigation to continue
      resolver.next();
    }
  }
}

