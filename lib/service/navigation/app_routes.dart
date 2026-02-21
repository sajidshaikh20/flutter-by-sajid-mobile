import '../../utils/exports.dart';

@AutoRouterConfig()
///AppRouter
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
            initial: false,
            guards: <AutoRouteGuard>[MaintenanceMiddleware()],
            reverseDurationInMilliseconds: 0,
            transitionsBuilder: TransitionsBuilders.noTransition,
            durationInMilliseconds: 0),
        


        /// Dashboard with 4 tabs
        CustomRoute<dynamic>(
          page: DashboardRoute.page,
          path: AppPaths.dashboard,
          initial: true,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
          children: <AutoRoute>[
            CustomRoute<dynamic>(
              initial: true,
              page: HomeRoute.page,
              path: AppPaths.home,
              maintainState: false,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
            CustomRoute<dynamic>(
              page: HomeCategoryRoute.page,
              path: AppPaths.category,
              maintainState: false,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
            CustomRoute<dynamic>(
              page: NotificationRoute.page,
              maintainState: false,
              path: AppPaths.notification,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
            CustomRoute<dynamic>(
              page: WishListRoute.page,
              maintainState: false,
              path: AppPaths.wishlist,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
            CustomRoute<dynamic>(
              page: MyAccountRoute.page,
              path: AppPaths.account,
              maintainState: false,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
          ],
        ),
      ];
}
