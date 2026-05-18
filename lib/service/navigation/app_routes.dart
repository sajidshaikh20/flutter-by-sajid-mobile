import '../../utils/exports.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        /// Essential routes for base template
        CustomRoute<dynamic>(
            page: ForceUpdateUnderMaintenanceRoute.page,
            path: AppPaths.maintenance,
            opaque: false,
            durationInMilliseconds: 0),
        CustomRoute<dynamic>(
            page: SplashRoute.page,
            path: AppPaths.splash,
            opaque: false,
            guards: <AutoRouteGuard>[MaintenanceMiddleware()],
            reverseDurationInMilliseconds: 0,
            transitionsBuilder: TransitionsBuilders.noTransition,
            durationInMilliseconds: 0),

        /// Project Aether — single-screen nervous system. Guarded by the
        /// same maintenance middleware so force-update / under-maintenance
        /// gating from Firebase Remote Config blocks raid joins too.
        CustomRoute<dynamic>(
          page: AetherRoute.page,
          path: AppPaths.aether,
          initial: true,
          guards: <AutoRouteGuard>[MaintenanceMiddleware()],
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),

      ];
}
