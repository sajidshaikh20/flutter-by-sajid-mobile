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
            initial: true,
            guards: <AutoRouteGuard>[MaintenanceMiddleware()],
            reverseDurationInMilliseconds: 0,
            transitionsBuilder: TransitionsBuilders.noTransition,
            durationInMilliseconds: 0),
        
        /// Authentication Flow Routes
        CustomRoute<dynamic>(
          page: SocialLoginRoute.page,
          path: AppPaths.socialLogin,
          opaque: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: LoginRoute.page,
          maintainState: false,
          path: AppPaths.login,
          guards: <AutoRouteGuard>[AuthenticationMiddleWare()],
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: SignUpRoute.page,
          path: AppPaths.signup,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ForgotPasswordRoute.page,
          maintainState: false,
          path: AppPaths.forgotPassword,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
            durationInMilliseconds: Dimens.milliseconds400,
            reverseDurationInMilliseconds: Dimens.milliseconds400,
            transitionsBuilder: fadePageTransition,
            page: VerifyOtpRoute.page, 
            path: AppPaths.verifyOtp),
        
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
