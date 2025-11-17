import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';

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
        // Refresh home data using Riverpod
        if (MainConfig.tabContext != null) {
          final ProviderContainer container = ProviderScope.containerOf(MainConfig.tabContext!);
          container.read(homeNotifierProvider.notifier).refreshHomeData();
        }
        return false;
      } else {
        await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      }
    }
    return false;
  }

  Widget _buildView(BuildContext context, ScreenType device) {
    double selectedUnSelectedFontSize = Dimens.fontSize10;
    double iconSize = Dimens.size24;
    switch (device) {
      case ScreenType.tablet:
        selectedUnSelectedFontSize = Dimens.fontSize16;
        iconSize = Dimens.size30;

      default:
        break;
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
        const HomeCategoryRoute(),
        const NotificationRoute(),
        const WishListRoute(),
        const MyAccountRoute(),
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
            bottomNavigationBar: CustomLineIndicatorBottomNavbar(
              splashColor: Colors.transparent,
              selectedLabelStyle: context.textTheme.headlineMedium?.copyWith(
                  fontSize: selectedUnSelectedFontSize,
                  height: Dimens.lineHeight18Point74
                      .toLineHeight(selectedUnSelectedFontSize),
                  color: MainConfig.appColors.mainColor,
                  fontWeight: FontWeight.normal),
              unselectedLabelStyle: context.textTheme.headlineMedium?.copyWith(
                  fontSize: selectedUnSelectedFontSize,
                  color: MainConfig.appColors.greyTextColor,
                  height: Dimens.lineHeight18Point74
                      .toLineHeight(selectedUnSelectedFontSize),
                  fontWeight: FontWeight.normal),
              // selectedItemColor: AppColors.mainColor,
              // unselectedItemColor: AppColors.greyTextColor,
              selectedColor: MainConfig.appColors.mainColor,
              backgroundColor: Colors.white,
              unSelectedColor: MainConfig.appColors.greyTextColor,
              customBottomBarItems: <CustomBottomBarItems<Widget>>[
                CustomBottomBarItems<Widget>(
                  activeIcon: Assets.svgs.icNavHome.svg(
                      height: iconSize,
                      width: iconSize,
                      colorFilter: ColorFilter.mode(
                          MainConfig.appColors.mainColor, BlendMode.srcIn)),
                  icon: Assets.svgs.icNavHome
                      .svg(height: iconSize, width: iconSize),
                  label: context.appString.navHomeKey,
                ),
                CustomBottomBarItems<Widget>(
                  activeIcon: Assets.svgs.icNavCategories.svg(
                      height: iconSize,
                      width: iconSize,
                      colorFilter: ColorFilter.mode(
                          MainConfig.appColors.mainColor, BlendMode.srcIn)),
                  icon: Assets.svgs.icNavCategories
                      .svg(height: iconSize, width: iconSize),
                  label: context.appString.navCategoriesKey,
                ),
                CustomBottomBarItems<Widget>(
                  icon: badges.Badge(
                    badgeAnimation:
                        const badges.BadgeAnimation.size(toAnimate: false),
                    showBadge: false,
                    badgeStyle: badges.BadgeStyle(
                      padding: Dimens.space5.padding,
                      badgeColor: MainConfig.appColors.redColor,
                      elevation: 0,
                    ),
                    position: badges.BadgePosition.topEnd(end: -Dimens.space7),
                    badgeContent: CustomTextLabelWidget(
                      label: AppConstant.notificationCount.toString(),
                      style: context.textTheme.headlineMedium?.copyWith(
                          fontSize: Dimens.fontSize12,
                          height: Dimens.lineHeight14
                              .toLineHeight(Dimens.fontSize12),
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.normal),
                    ),
                    child: Assets.svgs.icNavNotification
                        .svg(height: Dimens.size24, width: Dimens.size24),
                  ),
                  activeIcon: Assets.svgs.icNavNotification.svg(
                      height: iconSize,
                      width: iconSize,
                      colorFilter: ColorFilter.mode(
                          MainConfig.appColors.mainColor, BlendMode.srcIn)),
                  label: context.appString.navNotificationsKey,
                ),
                CustomBottomBarItems<Widget>(
                  activeIcon: Assets.svgs.icNavWishlist.svg(
                      height: iconSize,
                      width: iconSize,
                      colorFilter: ColorFilter.mode(
                          MainConfig.appColors.mainColor, BlendMode.srcIn)),
                  icon: Assets.svgs.icNavWishlist
                      .svg(height: iconSize, width: iconSize),
                  label: context.appString.navWishlistKey,
                ),
                CustomBottomBarItems<Widget>(
                  icon: Assets.svgs.icNavAccount
                      .svg(height: iconSize, width: iconSize),
                  activeIcon: Assets.svgs.icNavAccount.svg(
                      height: iconSize,
                      width: iconSize,
                      colorFilter: ColorFilter.mode(
                          MainConfig.appColors.mainColor, BlendMode.srcIn)),
                  label: context.appString.navAccountKey,
                ),
              ],
              currentIndex: tabsRouter.activeIndex,
              onTap: (int value) {
                final TabState selectedTab = TabState.values[value];
                if (selectedTab == TabState.cart &&
                    tabsRouter.activeIndex != value) {
                } else if (selectedTab == TabState.home &&
                    tabsRouter.activeIndex != value) {
                  // Refresh home data using Riverpod
                  final ProviderContainer container = ProviderScope.containerOf(context);
                  container.read(homeNotifierProvider.notifier).refreshHomeData();
                } else if (selectedTab == TabState.offers &&
                    tabsRouter.activeIndex != value) {
                  /// Reset filters and reload offers when switching to the "offers" tab.
                }
                tabsRouter.setActiveIndex(value);
              },
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
