import '../../../utils/exports.dart';

@RoutePage()
/// Page for user sign up.
class SignUpPage extends BaseResponsiveView {
  /// Creates [SignUpPage].
  const SignUpPage({super.key});

  SignUpState _createInitialState() {
    return SignUpState(
      status: BaseStateStatus.initial,
      formKey: GlobalKey<FormState>(),
      fullNameController: TextEditingController(),
      emailController: TextEditingController(),
      phoneController: TextEditingController(),
      usernameController: TextEditingController(),
      passwordController: TextEditingController(),
      confirmPasswordController: TextEditingController(),
      fullNameFocusNode: FocusNode(),
      emailFocusNode: FocusNode(),
      phoneFocusNode: FocusNode(),
      usernameFocusNode: FocusNode(),
      passwordFocusNode: FocusNode(),
      confirmPasswordFocusNode: FocusNode(),
    );
  }

  Widget _buildView(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (BuildContext ctx) => SignUpCubit(
        initialState: _createInitialState(),
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
