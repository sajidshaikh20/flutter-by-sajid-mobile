import '../../../../utils/exports.dart';

/// The main home page widget that displays banners, categories, products,
/// and handles navigation and state management for the home screen.
class HomePageWidget extends StatefulWidget {
  /// Creates a [HomePageWidget].
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  bool _hasInitializedHomeCubit = false;
  bool _isNavigatingToSelectAddress = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener<dynamic, dynamic>>[
        BlocListener<HomeCubit, HomeState>(
          listener: (BuildContext context, HomeState state) async {
            // Navigate to select address page if address list is empty
            // Only navigate if not already navigating to prevent multiple navigations
            if (state.redirectRoute != null && !_isNavigatingToSelectAddress) {
              _isNavigatingToSelectAddress = true;
              await context.router.push(state.redirectRoute!);
              // Clear the redirect route after navigation
              if (context.mounted) {
                _isNavigatingToSelectAddress = false;
              }
            }
          },
        ),
      ],
      child: _HomePageContent(
        hasInitializedHomeCubit: _hasInitializedHomeCubit,
        onHomeCubitInitialized: () {
          setState(() {
            _hasInitializedHomeCubit = true;
          });
        },
      ),
    );
  }
}

class _HomePageContent extends BaseResponsiveView {
  const _HomePageContent({
    required this.hasInitializedHomeCubit,
    required this.onHomeCubitInitialized,
  });

  final bool hasInitializedHomeCubit;
  final VoidCallback onHomeCubitInitialized;

  Widget buildViews(BuildContext context, ScreenType device) {
    return NoInternetWidget(
      childWidget: Scaffold(
        backgroundColor: Colors.white,
        body: MultiBlocListener(
          listeners: <BlocListener<dynamic, dynamic>>[
            BlocListener<HomeCubit, HomeState>(
              listenWhen: (HomeState previous, HomeState current) {
                // Only listen when message changes and is not empty
                return previous.msg != current.msg &&
                    (current.msg?.isNotEmpty ?? false);
              },
              listener: (BuildContext context, HomeState state) {
                if (state.msg != null && state.msg!.isNotEmpty) {
                  displaySnackBar(state.msg!, context);
                }
              },
            ),
          ],
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (BuildContext context, HomeState homeState) {
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const HomeAppbar(
                        title: "kuvakatech Flutter Assignment",
                      ),
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
      ),
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

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildViews(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildViews(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildViews(context, ScreenType.tablet);
  }
}
