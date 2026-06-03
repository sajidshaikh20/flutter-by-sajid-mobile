import '../../../utils/exports.dart';

/// Total steps in the sign up flow.
const int signUpTotalSteps = 3;

/// OTP length for sign up verification.
const int signUpOtpLength = Dimens.otpLength;

/// Cooldown before OTP can be resent again.
const int signUpOtpResendCooldownSeconds = Dimens.timeDuration30;

/// State for the sign up screen.
class SignUpState extends BaseState {
  /// Creates [SignUpState].
  SignUpState({
    required super.status,
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.fullNameFocusNode,
    required this.emailFocusNode,
    required this.phoneFocusNode,
    required this.usernameFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    this.currentStep = 0,
    this.totalSteps = signUpTotalSteps,
    this.countryDialCode = '+91',
    this.countryIsoCode = 'IN',
    this.fullNameErrorMessage = '',
    this.emailErrorMessage = '',
    this.phoneErrorMessage = '',
    this.emailOtpErrorMessage = '',
    this.phoneOtpErrorMessage = '',
    this.usernameErrorMessage = '',
    this.passwordErrorMessage = '',
    this.confirmPasswordErrorMessage = '',
    this.passwordObscureText = true,
    this.confirmPasswordObscureText = true,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.showEmailOtpField = false,
    this.showPhoneOtpField = false,
    this.emailOtp = '',
    this.phoneOtp = '',
    this.emailResendSecondsRemaining = 0,
    this.phoneResendSecondsRemaining = 0,
    super.msg = '',
    super.redirectRoute,
  });

  /// Active step index (0: basic info, 1: verification, 2: complete profile).
  final int currentStep;

  /// Total number of sign up steps.
  final int totalSteps;

  /// Root form key.
  final GlobalKey<FormState> formKey;

  /// Basic info — full name.
  final TextEditingController fullNameController;

  /// Basic info / verification — email.
  final TextEditingController emailController;

  /// Verification — phone (without dial code).
  final TextEditingController phoneController;

  /// Profile — username.
  final TextEditingController usernameController;

  /// Profile — password.
  final TextEditingController passwordController;

  /// Profile — confirm password.
  final TextEditingController confirmPasswordController;

  /// Focus nodes.
  final FocusNode fullNameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;

  /// Selected country dial code for phone field.
  final String countryDialCode;

  /// ISO country code for country picker e.g. `IN`.
  final String countryIsoCode;

  /// Field validation messages.
  final String fullNameErrorMessage;
  final String emailErrorMessage;
  final String phoneErrorMessage;
  final String emailOtpErrorMessage;
  final String phoneOtpErrorMessage;
  final String usernameErrorMessage;
  final String passwordErrorMessage;
  final String confirmPasswordErrorMessage;

  /// Password visibility toggles.
  final bool passwordObscureText;
  final bool confirmPasswordObscureText;

  /// Whether email / phone OTP has been verified.
  final bool isEmailVerified;
  final bool isPhoneVerified;

  /// Whether OTP pin fields are visible after send.
  final bool showEmailOtpField;
  final bool showPhoneOtpField;

  /// Current OTP pin values.
  final String emailOtp;
  final String phoneOtp;

  /// Seconds until email / phone OTP can be resent (0 = enabled).
  final int emailResendSecondsRemaining;
  final int phoneResendSecondsRemaining;

  /// Whether email OTP resend is available.
  bool get canResendEmailOtp => emailResendSecondsRemaining <= 0;

  /// Whether phone OTP resend is available.
  bool get canResendPhoneOtp => phoneResendSecondsRemaining <= 0;

  /// Trimmed email.
  String get email => emailController.text.trim();

  /// Trimmed full name.
  String get fullName => fullNameController.text.trim();

  /// Full phone with dial code.
  String get fullPhoneNumber => '$countryDialCode${phoneController.text.trim()}';

  @override
  List<Object?> get props => <Object?>[
    currentStep,
    totalSteps,
    countryDialCode,
    countryIsoCode,
    fullNameErrorMessage,
    emailErrorMessage,
    phoneErrorMessage,
    emailOtpErrorMessage,
    phoneOtpErrorMessage,
    usernameErrorMessage,
    passwordErrorMessage,
    confirmPasswordErrorMessage,
    passwordObscureText,
    confirmPasswordObscureText,
    isEmailVerified,
    isPhoneVerified,
    showEmailOtpField,
    showPhoneOtpField,
    emailOtp,
    phoneOtp,
    emailResendSecondsRemaining,
    phoneResendSecondsRemaining,
    ...super.props,
  ];

  /// Returns a copy with updated fields.
  SignUpState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    int? currentStep,
    int? totalSteps,
    String? countryDialCode,
    String? countryIsoCode,
    String? fullNameErrorMessage,
    String? emailErrorMessage,
    String? phoneErrorMessage,
    String? emailOtpErrorMessage,
    String? phoneOtpErrorMessage,
    String? usernameErrorMessage,
    String? passwordErrorMessage,
    String? confirmPasswordErrorMessage,
    bool? passwordObscureText,
    bool? confirmPasswordObscureText,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    bool? showEmailOtpField,
    bool? showPhoneOtpField,
    String? emailOtp,
    String? phoneOtp,
    int? emailResendSecondsRemaining,
    int? phoneResendSecondsRemaining,
  }) {
    return SignUpState(
      status: status ?? this.status,
      formKey: formKey,
      fullNameController: fullNameController,
      emailController: emailController,
      phoneController: phoneController,
      usernameController: usernameController,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
      fullNameFocusNode: fullNameFocusNode,
      emailFocusNode: emailFocusNode,
      phoneFocusNode: phoneFocusNode,
      usernameFocusNode: usernameFocusNode,
      passwordFocusNode: passwordFocusNode,
      confirmPasswordFocusNode: confirmPasswordFocusNode,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      countryDialCode: countryDialCode ?? this.countryDialCode,
      countryIsoCode: countryIsoCode ?? this.countryIsoCode,
      fullNameErrorMessage: fullNameErrorMessage ?? this.fullNameErrorMessage,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      phoneErrorMessage: phoneErrorMessage ?? this.phoneErrorMessage,
      emailOtpErrorMessage: emailOtpErrorMessage ?? this.emailOtpErrorMessage,
      phoneOtpErrorMessage: phoneOtpErrorMessage ?? this.phoneOtpErrorMessage,
      usernameErrorMessage: usernameErrorMessage ?? this.usernameErrorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      confirmPasswordErrorMessage:
          confirmPasswordErrorMessage ?? this.confirmPasswordErrorMessage,
      passwordObscureText: passwordObscureText ?? this.passwordObscureText,
      confirmPasswordObscureText:
          confirmPasswordObscureText ?? this.confirmPasswordObscureText,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      showEmailOtpField: showEmailOtpField ?? this.showEmailOtpField,
      showPhoneOtpField: showPhoneOtpField ?? this.showPhoneOtpField,
      emailOtp: emailOtp ?? this.emailOtp,
      phoneOtp: phoneOtp ?? this.phoneOtp,
      emailResendSecondsRemaining:
          emailResendSecondsRemaining ?? this.emailResendSecondsRemaining,
      phoneResendSecondsRemaining:
          phoneResendSecondsRemaining ?? this.phoneResendSecondsRemaining,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute ?? this.redirectRoute,
    );
  }
}
