import '../../../utils/exports.dart';


@RoutePage()
/// Trades tab displaying dashboard metrics, recent history, live trades, and market summaries.
class TradesPage extends BaseResponsiveView {
  const TradesPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return DashboardTabPlaceholder(
      title: context.appString.navTradesKey,
    );
  }
}
