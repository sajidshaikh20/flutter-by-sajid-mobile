import '../../../utils/exports.dart';

@RoutePage()
/// My Trades tab — route entry with cubit provided at page level.
class MyTradesPage extends BaseResponsiveView {
  const MyTradesPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return const MyTradesBodyWidget();
  }
}
