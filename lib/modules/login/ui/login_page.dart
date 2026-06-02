import '../../../../utils/exports.dart';

@RoutePage()
/// Page that displays the login form for user authentication.
class LoginPage extends BaseResponsiveView {
  /// Creates a login page.
  ///
  /// [isFromCart] Whether the login was initiated from the cart flow.
  const LoginPage({super.key, this.isFromCart = false});

  /// Whether the login was initiated from the cart flow.
  final bool? isFromCart;

  Widget _buildView(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext ctx) => LoginCubit(
          isFromCart: isFromCart ?? false,
          repository: LoginRepositoryImpl(),
          initialState: LoginState(
              status: BaseStateStatus.initial,
              emailController: TextEditingController(),
              passwordController: TextEditingController(),
              formKey: GlobalKey<FormState>(),
              emailFocusNode: FocusNode(),
              passwordFocusNode: FocusNode())),
      child: const LoginForm(),
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context);
  }
}
