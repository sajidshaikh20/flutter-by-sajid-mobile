import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the sign up form for new user registration.
class SignUpPage extends BaseResponsiveView {
  /// Creates a sign up page.
  const SignUpPage({super.key});

  /// Builds the sign up view with BlocProvider for the specified device type.
  Widget _buildView(BuildContext context, ScreenType device) {
    return BlocProvider<SignupCubit>(
        create: (BuildContext ctx) => SignupCubit(
            repository: SignUpRepositoryImpl(),
            initialState: SignupState(
                status: BaseStateStatus.initial,
                firstNameFocusNode: FocusNode(),
                nationalityFocusNode: FocusNode(),
                mobileNumberFocusNode: FocusNode(),
                emailFocusNode: FocusNode(),
                passwordFocusNode: FocusNode(),
                referralCodeFocusNode: FocusNode(),
                dateOfBirthFocusNode: FocusNode(),
                fullNameController: TextEditingController(),
                nationalityController: TextEditingController(),
                mobileController: TextEditingController(),
                passwordController: TextEditingController(),
                referralCodeController: TextEditingController(),
                dateOfBirthController: TextEditingController(),
                emailController: TextEditingController(),
                formKey: GlobalKey<FormState>(),
                cmsResponseModel: CmsResponseModel())),
        child: SignUpForm(
          device: device,
        ));
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context, ScreenType.tablet);
  }
}
