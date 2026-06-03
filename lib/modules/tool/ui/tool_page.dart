import '../../../utils/exports.dart';

@RoutePage()
/// Tool tab.
class ToolPage extends BaseResponsiveView {
  const ToolPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return DashboardTabPlaceholder(
      title: context.appString.navToolKey,
    );
  }
}
