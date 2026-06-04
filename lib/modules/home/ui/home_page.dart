import '../../../../utils/exports.dart';
import 'widget/home_header_app_bar.dart';
import 'widget/home_live_trades_card.dart';
import 'widget/home_overview_grid.dart';
import 'widget/home_promo_banner.dart';
import 'widget/home_recent_trades_table.dart';

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
