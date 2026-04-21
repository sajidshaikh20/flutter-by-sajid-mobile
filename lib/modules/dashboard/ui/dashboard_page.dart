import '../../../../utils/exports.dart';

/// A responsive page that represents the main dashboard of the app.
///
/// This page adapts its layout based on the device type (mobile, tablet, desktop)
/// using [BaseResponsiveView] as its base class.
///
/// Usage:
/// ```dart
/// AutoRouter.of(context).push(const DashboardPage());
/// ```
///
/// Parameters:
/// - [key]: Optional widget key.
@RoutePage()
class DashboardPage extends BaseResponsiveView {
  ///DashboardPage
  const DashboardPage({
    super.key,
  });

  /// method for the back button which is managed by router
  static Future<bool> systemBackButtonPressed(TabsRouter tabsRouter,
      {bool canPop = false}) async {
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
    // Handle first scenario (existing logic)
    if (nestedRouter != null && nestedRouter.canPop()) {
      await nestedRouter.maybePop();
      return false; // Prevent default back behavior
    } else {
      if (tabsRouter.activeIndex != 0) {
        tabsRouter.setActiveIndex(0);
        MainConfig.tabContext.read<HomeCubit>().refreshHomeData();
        return false;
      } else {
        await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      }
    }
    return false;
  }

  Widget _buildView(BuildContext context, ScreenType device) {
    double iconSize = Dimens.size24;
    if (device == ScreenType.tablet) {
      iconSize = Dimens.size30;
    }

    return AutoTabsRouter(
      curve: Curves.easeInOutQuad,
      duration: const Duration(milliseconds: Dimens.milliseconds400),
      transitionBuilder:
          (BuildContext context, Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutQuad, // Smoothest curve
          ),
          child: child,
        );
      },
      routes: <PageRouteInfo>[
        HomeRoute(),
        const WatchlistRoute(),
        const BankTransferRoute(),
        const ChatSupportRoute(),
      ],
      builder: (BuildContext context, Widget child) {
        /* final tabsRouter = AutoTabsRouter.of(context);
        MainConfig.tabContext = context;*/

        final TabsRouter tabsRouter = AutoTabsRouter.of(context);
        MainConfig.tabContext = context;
        if (getIt<TabRouterService>().tabsRouterContext == null) {
          scheduleMicrotask(() {
            if (context.mounted) {
              getIt<TabRouterService>().tabsRouterContext = context;
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
              onTap: (int value) {
                final TabState selectedTab = TabState.values[value];
                if (selectedTab == TabState.home &&
                    tabsRouter.activeIndex != value) {
                  context.read<HomeCubit>().refreshHomeData();
                } else if (selectedTab == TabState.bankTransfer &&
                    tabsRouter.activeIndex != value) {
                  /// Reset when switching to bank transfer tab.
                }
                tabsRouter.setActiveIndex(value);
              },
              items: <CustomBottomNavBarItem>[
                CustomBottomNavBarItem(
                  activeIcon: Assets.svgs.icHome.svg(
                    height: iconSize,
                    width: iconSize,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  inactiveIcon: Assets.svgs.icHome.svg(
                    height: iconSize,
                    width: iconSize,
                    colorFilter: ColorFilter.mode(
                      MainConfig.appColors.greyTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  routeName: AppPaths.home,
                  label: 'Home',
                ),
                CustomBottomNavBarItem(
                  activeIcon: Assets.svgs.icTransactionHistory.svg(
                    height: iconSize,
                    width: iconSize,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  inactiveIcon: Assets.svgs.icTransactionHistory.svg(
                    height: iconSize,
                    width: iconSize,
                    colorFilter: ColorFilter.mode(
                      MainConfig.appColors.greyTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  routeName: AppPaths.watchlist,
                  label: 'Watchlist',
                ),
                CustomBottomNavBarItem(
                  activeIcon: Assets.svgs.icBankTransfer.svg(
                    height: iconSize,
                    width: iconSize,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  inactiveIcon: Assets.svgs.icBankTransfer.svg(
                    height: iconSize,
                    width: iconSize,
                    colorFilter: ColorFilter.mode(
                      MainConfig.appColors.greyTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  routeName: AppPaths.bankTransfer,
                  label: 'Bank Transfer',
                ),
                CustomBottomNavBarItem(
                  activeIcon: Assets.svgs.icChatSupport.svg(
                    height: iconSize,
                    width: iconSize,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  inactiveIcon: Assets.svgs.icChatSupport.svg(
                    height: iconSize,
                    width: iconSize,
                    colorFilter: ColorFilter.mode(
                      MainConfig.appColors.greyTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  routeName: AppPaths.chatSupport,
                  label: 'Chat Support',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context, ScreenType.tablet);
  }
}
