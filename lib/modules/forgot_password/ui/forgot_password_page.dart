import '../../../utils/exports.dart';

@RoutePage()
/// Page for requesting a password reset link via email.
class ForgotPasswordPage extends BaseResponsiveView {
  /// Creates [ForgotPasswordPage].
  const ForgotPasswordPage({super.key});

  Widget _buildView(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (BuildContext ctx) => ForgotPasswordCubit(
        repository: ForgotPasswordRepositoryImpl(),
        initialState: ForgotPasswordState(
          status: BaseStateStatus.initial,
          emailController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
          emailFocusNode: FocusNode(),
        ),
      ),
      child: const ForgotPasswordForm(),
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _buildView(context);
}
