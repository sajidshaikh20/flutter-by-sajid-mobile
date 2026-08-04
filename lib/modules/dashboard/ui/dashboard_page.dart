import '../../../../utils/exports.dart';
import '../../../service/navigation/deep_link_manager.dart';

/// Main dashboard with 5 bottom tabs.
@RoutePage()
class DashboardPage extends BaseResponsiveView {
  /// Creates [DashboardPage].
  const DashboardPage({super.key});


  /// Handles system back on dashboard tabs.
  static Future<bool> systemBackButtonPressed(
    TabsRouter tabsRouter, {
    bool canPop = false,
  }) async {
    final StackRouter? nestedRouter =
        tabsRouter.stackRouterOfIndex(tabsRouter.activeIndex);
    if (canPop) {
      if (nestedRouter != null && nestedRouter.canPop()) {
        await nestedRouter.maybePop();
        return false;
      }
      if (tabsRouter.activeIndex != 0) {
        return false;
      }
      await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return false;
    }
    if (nestedRouter != null && nestedRouter.canPop()) {
      await nestedRouter.maybePop();
      return false;
    }
    if (tabsRouter.activeIndex != 0) {
      tabsRouter.setActiveIndex(0);
      MainConfig.tabContext.read<HomeCubit>().refreshHomeData();
      return false;
    }
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    return false;
  }

  Widget _buildView(BuildContext context, ScreenType device) {
    final AppString strings = context.appString;
    final double iconSize =
        device == ScreenType.tablet ? Dimens.size26 : Dimens.size24;
    final String role = UserProfileService.instance().roleName.toUpperCase();
    final bool isTraderOrAdmin = role == 'TRADER' || role == 'MENTOR' || role == 'ADMIN';

    return AutoTabsRouter(
      curve: Curves.easeInOutQuad,
      duration: const Duration(milliseconds: Dimens.milliseconds400),
      transitionBuilder:
          (BuildContext context, Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutQuad,
          ),
          child: child,
        );
      },
      routes: <PageRouteInfo<dynamic>>[
        HomeRoute(),
        const MyTradesRoute(),
        isTraderOrAdmin ? const AddTradeRoute() : const TradesRoute(),
        const ToolRoute(),
        const SettingsRoute(),
      ],
      builder: (BuildContext context, Widget child) {
        final TabsRouter tabsRouter = AutoTabsRouter.of(context);
        MainConfig.tabContext = context;
        if (getIt<TabRouterService>().tabsRouterContext == null) {
          scheduleMicrotask(() {
            if (context.mounted) {
              getIt<TabRouterService>().tabsRouterContext = context;
              DeepLinkManager.instance.checkAndProcessPendingDeepLink();
            }
          });
        } else {
          scheduleMicrotask(() {
            if (context.mounted) {
              DeepLinkManager.instance.checkAndProcessPendingDeepLink();
            }
          });
        }

        return PopScope(
          canPop: Navigator.canPop(context),
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            await systemBackButtonPressed(tabsRouter, canPop: didPop);
          },
          child: Scaffold(
            body: child,
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: tabsRouter.activeIndex,
              iconSize: iconSize,
              onTap: (int index) {
                if (index == TabState.home.index &&
                    tabsRouter.activeIndex != index) {
                  context.read<HomeCubit>().refreshHomeData();
                }
                tabsRouter.setActiveIndex(index);
              },
              items: <CustomBottomNavBarItem>[
                CustomBottomNavBarItem(
                  iconBuilder: (Color color, double size) => Icon(
                    Icons.home_rounded,
                    size: size,
                    color: color,
                  ),
                  routeName: AppPaths.home,
                  label: strings.navHomeKey,
                ),
                CustomBottomNavBarItem(
                  iconBuilder: (Color color, double size) => Icon(
                    Icons.candlestick_chart_outlined,
                    size: size,
                    color: color,
                  ),
                  routeName: AppPaths.myTrades,
                  label: strings.navMyTradesKey,
                ),
                CustomBottomNavBarItem(
                  isCenterElevated: true,
                  routeName: isTraderOrAdmin ? AppPaths.addTrade : AppPaths.trades,
                  label: isTraderOrAdmin ? 'Add Trade' : strings.navTradesKey,
                ),

                CustomBottomNavBarItem(
                  iconBuilder: (Color color, double size) => Icon(
                    Icons.build_circle_outlined,
                    size: size,
                    color: color,
                  ),
                  routeName: AppPaths.tool,
                  label: strings.navToolKey,
                ),
                CustomBottomNavBarItem(
                  iconBuilder: (Color color, double size) => Icon(
                    Icons.settings_outlined,
                    size: size,
                    color: color,
                  ),
                  routeName: AppPaths.settings,
                  label: strings.navSettingsKey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      _buildView(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      _buildView(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      _buildView(context, ScreenType.tablet);
}
