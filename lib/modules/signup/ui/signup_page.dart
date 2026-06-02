import '../../../utils/exports.dart';

@RoutePage()
/// Page for user sign up.
class SignUpPage extends BaseResponsiveView {
  /// Creates [SignUpPage].
  const SignUpPage({super.key});

  Widget _buildView(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (BuildContext ctx) => SignUpCubit(
        initialState: const SignUpState(status: BaseStateStatus.initial),
      ),
      child: const SignUpFlowWidget(),
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _buildView(context);
}
