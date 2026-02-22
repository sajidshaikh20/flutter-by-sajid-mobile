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
              children: <AutoRoute>[

              ],
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
