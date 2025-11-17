import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays user account information and settings.
class MyAccountPage extends BaseResponsiveView {
  /// Creates a my account page.
  const MyAccountPage({super.key});

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
    // Riverpod provider is available globally, no need for BlocProvider
    return MyAccountForm(device: device,);
  }
}
