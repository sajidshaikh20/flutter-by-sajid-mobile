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
            initial: false,
            guards: <AutoRouteGuard>[MaintenanceMiddleware()],
            reverseDurationInMilliseconds: 0,
            transitionsBuilder: TransitionsBuilders.noTransition,
            durationInMilliseconds: 0),

        /// Authentication Flow Routes
        CustomRoute<dynamic>(
          page: LoginRoute.page,
          maintainState: false,
          path: AppPaths.login,
          guards: <AutoRouteGuard>[AuthenticationMiddleWare()],
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),

        /// Language Selection Routes
        CustomRoute<dynamic>(
          page: LanguageSelectionRoute.page,
          maintainState: false,
          path: AppPaths.languageSelection,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),

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
              page: FilesRoute.page,
              path: AppPaths.files,
              maintainState: false,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
            CustomRoute<dynamic>(
              page: TabsRoute.page,
              maintainState: false,
              path: AppPaths.tabs,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
            CustomRoute<dynamic>(
              page: SettingsRoute.page,
              path: AppPaths.settings,
              maintainState: false,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
          ],
        ),
        CustomRoute<dynamic>(
          page: CommonWebView.page,
          path: AppPaths.webView,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
      ];
}
