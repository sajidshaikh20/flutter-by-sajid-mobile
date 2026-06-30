import '../../../utils/exports.dart';
import 'widget/widget.dart';

@RoutePage()
/// Main page container for the onboarding flow.
class OnboardingPage extends BaseResponsiveView {
  /// Creates the onboarding page.
  const OnboardingPage({super.key});

  Widget _buildView(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (BuildContext ctx) => OnboardingCubit(),
      child: OnboardingScreen(),
    );
  }

  @override
  Widget buildMobileWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildDesktopWidget(BuildContext context) => _buildView(context);
}
