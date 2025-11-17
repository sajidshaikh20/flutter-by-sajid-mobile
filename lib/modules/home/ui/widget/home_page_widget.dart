import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';

/// The main home page widget that displays banners, categories, products,
/// and handles navigation and state management for the home screen.
class HomePageWidget extends ConsumerStatefulWidget {
  /// Creates a [HomePageWidget].
  const HomePageWidget({super.key});

  @override
  ConsumerState<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends ConsumerState<HomePageWidget> {
  bool _hasInitializedHomeNotifier = false;
  bool _isNavigatingToSelectAddress = false;

  @override
  Widget build(BuildContext context) {
    // Listen to redirect route changes
    ref.listen<HomeState>(
      homeNotifierProvider,
      (HomeState? previous, HomeState next) async {
        // Navigate to select address page if address list is empty
        // Only navigate if not already navigating to prevent multiple navigations
        if (next.redirectRoute != null && !_isNavigatingToSelectAddress && context.mounted) {
          _isNavigatingToSelectAddress = true;
          await context.router.push(next.redirectRoute!);
          // Clear the redirect route after navigation
          if (context.mounted) {
            _isNavigatingToSelectAddress = false;
          }
        }
      },
    );

    return _HomePageContent(
      hasInitializedHomeNotifier: _hasInitializedHomeNotifier,
      onHomeNotifierInitialized: () {
        setState(() {
          _hasInitializedHomeNotifier = true;
        });
      },
    );
  }
}

class _HomePageContent extends ConsumerWidget {
  const _HomePageContent({
    required this.hasInitializedHomeNotifier,
    required this.onHomeNotifierInitialized,
  });

  final bool hasInitializedHomeNotifier;
  final VoidCallback onHomeNotifierInitialized;

  Widget buildViews(BuildContext context, WidgetRef ref, ScreenType device) {
    // Listen to message changes
    ref.listen<HomeState>(
      homeNotifierProvider,
      (HomeState? previous, HomeState next) {
        // Only listen when message changes and is not empty
        if (previous?.msg != next.msg && (next.msg?.isNotEmpty ?? false)) {
          displaySnackBar(next.msg!, context);
        }
      },
    );

    final HomeState homeState = ref.watch(homeNotifierProvider);
    
    return NoInternetWidget(
      childWidget: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (BuildContext context) {
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const HomeAppbar(),
                    /*homeState.apiCallForAddress != BaseStateStatus.success
                        ? const HomeAddressSelectionShimmer()
                        : const HomeAddressSelection(),*/
                    Container(height: 200, color: Colors.red)
                  ],
                ),
                const Positioned(
                    bottom: Dimens.size16,
                    right: Dimens.size16,
                    child: HomeFaqWidget())
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        ScreenType device = ScreenType.mobile;
        if (constraints.maxWidth >= AppConstant.webPixelWidth) {
          device = ScreenType.desktop;
        } else if (constraints.maxWidth >= AppConstant.mobilePixelWidth) {
          device = ScreenType.tablet;
        }
        return buildViews(context, ref, device);
      },
    );
  }

  Widget commonHeaderWithSizeBox(
    String title, {
    required bool isViewAllVisible,
    Function()? viewAllOnclick,
    required BuildContext context,
    required ScreenType device,
    required HomeState state,
  }) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: Dimens.size25,
        ),
        HeaderWidget(
          device: device,
          mainHeader: title,
          viewAll: context.appString.viewAllKey,
          isPaddingNeed: true,
          isViewAllVisible: isViewAllVisible,
          viewAllOnclick: viewAllOnclick,
        ),
        const SizedBox(
          height: Dimens.size18,
        ),
      ],
    );
  }

  // Removed buildDesktopWidget, buildMobileWidget, buildTabletWidget
  // as they're now handled in the build method with LayoutBuilder
}
