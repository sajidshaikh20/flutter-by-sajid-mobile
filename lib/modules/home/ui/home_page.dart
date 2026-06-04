import '../../../../utils/exports.dart';

@RoutePage()
class HomePage extends BaseResponsiveView {
  const HomePage({super.key, this.isFromNotification = false});

  final bool? isFromNotification;

  Widget buildview(BuildContext context) {
    final bool isDark = context.isDark;

    return BlocProvider<HomeCubit>(
      create: (BuildContext c) => HomeCubit(),
      child: Scaffold(
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        body: const SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HomeHeaderAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      HomePromoBanner(),
                      SizedBox(height: Dimens.space20),
                      HomeOverviewGrid(),
                      SizedBox(height: Dimens.space20),
                      HomeRecentTradesTable(),
                      SizedBox(height: Dimens.space20),
                      HomeLiveTradesCard(),
                      SizedBox(height: Dimens.space20),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildview(context);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildview(context);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildview(context);
  }
}
