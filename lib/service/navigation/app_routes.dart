import '../../utils/exports.dart';

@AutoRouterConfig()
///AppRouter
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        CustomRoute<dynamic>(
          page: SplashRoute.page,
          path: AppPaths.splash,
          initial: true,
          reverseDurationInMilliseconds: 0,
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 0,
        ),
        CustomRoute<dynamic>(
          page: MainRoute.page,
          path: AppPaths.main,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
      ];
}
