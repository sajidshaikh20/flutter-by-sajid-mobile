import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays user account information and settings.
class SettingsPage extends BaseResponsiveView {
  /// Creates a settings page.
  const SettingsPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context,ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context,ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context,ScreenType.tablet);
  }

  Widget _buildView(BuildContext context,ScreenType device) {
    return

      BlocProvider<MyAccountCubit>(
      create: (BuildContext ctx) => MyAccountCubit(
        MyAccountRepositoryImpl(),
        MyAccountState.init(),
      ),
      child: MyAccountForm(device: device),
    );
  }
}
