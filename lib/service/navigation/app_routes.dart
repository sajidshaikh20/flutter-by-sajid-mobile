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
      durationInMilliseconds: 0,
    ),
    CustomRoute<dynamic>(
      page: SplashRoute.page,
      path: AppPaths.splash,
      opaque: false,
      initial: true,
      guards: <AutoRouteGuard>[MaintenanceMiddleware()],
      reverseDurationInMilliseconds: 0,
      transitionsBuilder: TransitionsBuilders.noTransition,
      durationInMilliseconds: 0,
    ),
    CustomRoute<dynamic>(
      page: SocialLoginRoute.page,
      path: AppPaths.socialLogin,
      durationInMilliseconds: Dimens.milliseconds400,
      reverseDurationInMilliseconds: Dimens.milliseconds400,
      transitionsBuilder: fadePageTransition,
    ),
    CustomRoute<dynamic>(
      page: LoginRoute.page,
      path: AppPaths.login,
      durationInMilliseconds: Dimens.milliseconds400,
      reverseDurationInMilliseconds: Dimens.milliseconds400,
      transitionsBuilder: fadePageTransition,
    ),
    CustomRoute<dynamic>(
      page: ForgotPasswordRoute.page,
      path: AppPaths.forgotPassword,
      durationInMilliseconds: Dimens.milliseconds400,
      reverseDurationInMilliseconds: Dimens.milliseconds400,
      transitionsBuilder: fadePageTransition,
    ),
    CustomRoute<dynamic>(
      page: SignUpRoute.page,
      path: AppPaths.signUp,
      durationInMilliseconds: Dimens.milliseconds400,
      reverseDurationInMilliseconds: Dimens.milliseconds400,
      transitionsBuilder: fadePageTransition,
      children: <AutoRoute>[
        CustomRoute<dynamic>(
          initial: true,
          page: SignUpBasicInfoRoute.page,
          path: AppPaths.signUpBasicInfo,
          durationInMilliseconds: Dimens.milliseconds300,
          reverseDurationInMilliseconds: Dimens.milliseconds300,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: SignUpVerificationRoute.page,
          path: AppPaths.signUpVerification,
          durationInMilliseconds: Dimens.milliseconds300,
          reverseDurationInMilliseconds: Dimens.milliseconds300,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: SignUpCompleteProfileRoute.page,
          path: AppPaths.signUpCompleteProfile,
          durationInMilliseconds: Dimens.milliseconds300,
          reverseDurationInMilliseconds: Dimens.milliseconds300,
          transitionsBuilder: fadePageTransition,
        ),
      ],
    ),

    CustomRoute<dynamic>(
      page: VerificationPendingRoute.page,
      path: AppPaths.verificationPending,
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
        /// Home tab shell (AutoRouter); children show inside tab so bottom nav stays visible.
        CustomRoute<dynamic>(
          initial: true,
          page: HomeRoute.page,
          path: AppPaths.home,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: TransactionHistoryRoute.page,
          path: AppPaths.transactionHistory,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: BankTransferRoute.page,
          maintainState: false,
          path: AppPaths.bankTransfer,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ChatSupportRoute.page,
          path: AppPaths.chatSupport,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
      ],
    ),
  ];
}
