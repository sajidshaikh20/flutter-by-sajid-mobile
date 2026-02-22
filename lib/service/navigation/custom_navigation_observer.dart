import '../../utils/exports.dart';

/// Custom navigation observer to track route changes and log analytics events.
class CustomNavigationObserver extends AutoRouterObserver {
  /// Called when a new route is pushed onto the stack.
  /// Logs the route name and sends an event to the analytics service.
  @override
  Future<void> didPush(
      Route<dynamic> route, Route<dynamic>? previousRoute) async {
    // Only log analytics if Firebase is initialized
    // Log the original route name
    DebugLog.instance.d('New route pushed: ${route.settings.name}');
  }

  /// Called when a route is replaced on the stack.
  /// Logs the new route name.
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    DebugLog.instance.d('did replace :${newRoute?.settings.name}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  /// Called when a route is popped from the stack.
  /// Logs the popped route name.
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    DebugLog.instance.d('did pop :${route.settings.name}');
    super.didPop(route, previousRoute);
  }

  /// Called to observe tab route navigation.
  /// Logs the tab route name and sends an event to the analytics service.
  @override
  Future<void> didInitTabRoute(
      TabPageRoute route, TabPageRoute? previousRoute) async {
    // Only log analytics if Firebase is initialized
    DebugLog.instance.d('Tab route visited: ${route.name}');
  }

  /// Called when a tab route is revisited.
  /// Logs the revisited tab route name.
  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    DebugLog.instance.d('Tab route re-visited: ${route.name}');
  }
}
