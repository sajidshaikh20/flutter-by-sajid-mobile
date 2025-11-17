import '../../../../../utils/exports.dart';
import '../../../../../app/providers/providers.dart';

@RoutePage()
/// Page that displays the forgot password form for password reset.
class ForgotPasswordPage extends BaseResponsiveView {
  /// Creates a forgot password page.
  const ForgotPasswordPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildViews(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildViews(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildViews(context, ScreenType.tablet);
  }

  Widget _buildViews(BuildContext context, ScreenType device) {
    // Riverpod provider is available globally, no need for BlocProvider
    return ForgotPasswordForm(
      device: device,
    );
  }
}
