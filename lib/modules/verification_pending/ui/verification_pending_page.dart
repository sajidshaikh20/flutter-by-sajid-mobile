import '../../../utils/exports.dart';

@RoutePage()
/// Screen shown after login when account verification is under review.
class VerificationPendingPage extends BaseResponsiveView {
  /// Creates [VerificationPendingPage].
  const VerificationPendingPage({super.key});

  Widget _buildView(BuildContext context) {
    return NoInternetWidget(
      onTryAgain: () {},
      childWidget: const VerificationPendingContent(),
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _buildView(context);
}
