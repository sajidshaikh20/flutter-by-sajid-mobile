import '../../../utils/exports.dart';

@RoutePage()
/// Settings tab.
class SettingsPage extends BaseResponsiveView {
  const SettingsPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return DashboardTabPlaceholder(
      title: context.appString.navSettingsKey,
    );
  }
}
