import '../../../utils/exports.dart';

@RoutePage()
/// Page for user sign up.
class SignUpPage extends BaseResponsiveView {
  /// Creates [SignUpPage].
  const SignUpPage({
    super.key,
    this.prefilledName,
    this.prefilledEmail,
    this.prefilledPhone,
    this.prefilledCountryCode,
  });

  /// Prefilled fields from external authentications
  final String? prefilledName;
  final String? prefilledEmail;
  final String? prefilledPhone;
  final String? prefilledCountryCode;

  SignUpState _createInitialState() {
    final String initialDialCode = prefilledCountryCode ?? '+91';
    final String initialIsoCode = prefilledCountryCode != null
        ? _mapDialCodeToIsoCode(prefilledCountryCode!)
        : 'IN';

    return SignUpState(
      status: BaseStateStatus.initial,
      formKey: GlobalKey<FormState>(),
      fullNameController: TextEditingController(text: prefilledName),
      emailController: TextEditingController(text: prefilledEmail),
      phoneController: TextEditingController(text: prefilledPhone),
      usernameController: TextEditingController(),
      passwordController: TextEditingController(),
      confirmPasswordController: TextEditingController(),
      fullNameFocusNode: FocusNode(),
      emailFocusNode: FocusNode(),
      phoneFocusNode: FocusNode(),
      usernameFocusNode: FocusNode(),
      passwordFocusNode: FocusNode(),
      confirmPasswordFocusNode: FocusNode(),
      countryDialCode: initialDialCode,
      countryIsoCode: initialIsoCode,
    );
  }

  String _mapDialCodeToIsoCode(String dialCode) {
    switch (dialCode) {
      case '+91':
        return 'IN';
      case '+1':
        return 'US';
      case '+44':
        return 'GB';
      case '+971':
        return 'AE';
      default:
        return 'IN';
    }
  }

  Widget _buildView(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (BuildContext ctx) => SignUpCubit(
        repository: SignUpRepositoryImpl(),
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
