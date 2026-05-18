import '../../../utils/exports.dart';

@RoutePage()
class WatchlistPage extends BaseResponsiveView {
  const WatchlistPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);
  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);
  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<WatchlistCubit>(
      create: (BuildContext c) => WatchlistCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Watchlist',
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: Dimens.fontSize18,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        body:  Container(),
      ),
    );
  }
}
