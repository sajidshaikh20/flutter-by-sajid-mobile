import '../../../../utils/exports.dart';

/// Immutable state representing the signup form and its current values.
class SignupState extends BaseState {
  /// Creates a new instance of [SignupState].
  const SignupState(
      {this.passwordObscureText = true,
      this.mobilePrefix = AppConstant.defaultCountryCode,
      this.isReceiveEmail = true,
      this.isAgreed = false,
      this.isSocial = false,
      required this.firstNameFocusNode,
      required this.nationalityFocusNode,
      required this.mobileNumberFocusNode,
      required this.emailFocusNode,
      required this.passwordFocusNode,
      required this.referralCodeFocusNode,
      required this.dateOfBirthFocusNode,
      required this.fullNameController,
      required this.nationalityController,
      required this.dateOfBirthController,
      required this.mobileController,
      required this.emailController,
      required this.passwordController,
      required this.referralCodeController,
      required this.formKey,
      this.screenWidth = '',
      required super.status,
      super.msg = '',
      super.redirectRoute,
      this.requestModel,
      this.successMsg = '',
      this.showDefaultErrMsg = false,
      this.isChecked = false,
      this.fullNameErrorMessage = '',
      this.mobileErrorMessage = '',
      this.emailErrorMessage = '',
      this.nationalityErrorMessage = '',
      this.passwordErrorMessage = '',
      this.termConditionErrorMessage = '',
      this.dateOfBirthErrorMessage = '',
      this.selectedGender = '',
      this.genderErrorMessage = '',
      required this.cmsResponseModel,
      this.isMenuOpen = false});

  /// Whether the password text should be obscured.
  final bool passwordObscureText;

  /// The mobile number prefix (country code).
  final String mobilePrefix;

  /// Whether the user wants to receive emails.
  final bool isReceiveEmail;

  /// Whether the user has agreed to terms.
  final bool isAgreed;

  /// Whether the signup is via social authentication.
  final bool isSocial;

  /// Success message to display.
  final String successMsg;

  /// Whether to show the default error message.
  final bool? showDefaultErrMsg;

  /// Whether the terms checkbox is checked.
  final bool isChecked;

  /// Focus node for the first name field.
  final FocusNode firstNameFocusNode;

  /// Focus node for the nationality field.
  final FocusNode nationalityFocusNode;

  /// Focus node for the mobile number field.
  final FocusNode mobileNumberFocusNode;

  /// Focus node for the email field.
  final FocusNode emailFocusNode;

  /// Focus node for the password field.
  final FocusNode passwordFocusNode;

  /// Focus node for the referral code field.
  final FocusNode referralCodeFocusNode;

  /// Focus node for the date of birth field.
  final FocusNode dateOfBirthFocusNode;

  /// Controller for the full name text field.
  final TextEditingController fullNameController;

  /// Controller for the nationality text field.
  final TextEditingController nationalityController;

  /// Controller for the date of birth text field.
  final TextEditingController dateOfBirthController;

  /// Controller for the mobile number text field.
  final TextEditingController mobileController;

  /// Controller for the email text field.
  final TextEditingController emailController;

  /// Controller for the password text field.
  final TextEditingController passwordController;
  /// Controller for the referral code text field.
  final TextEditingController referralCodeController;

  /// The selected gender value.
  final String? selectedGender;

  /// Global key for the signup form.
  final GlobalKey<FormState> formKey;

  /// The screen width as a string.
  final String screenWidth;

  /// Request model for OTP verification.
  final SignUpUserOtpRequestModel? requestModel;

  /// CMS response model containing content data.
  final CmsResponseModel cmsResponseModel;

  /// Error message for the full name field.
  final String? fullNameErrorMessage;

  /// Error message for the mobile number field.
  final String? mobileErrorMessage;

  /// Error message for the email field.
  final String? emailErrorMessage;

  /// Error message for the nationality field.
  final String? nationalityErrorMessage;

  /// Error message for the password field.
  final String? passwordErrorMessage;

  /// Error message for the terms and conditions.
  final String? termConditionErrorMessage;

  /// Error message for the date of birth field.
  final String? dateOfBirthErrorMessage;

  /// Error message for the gender field.
  final String genderErrorMessage;

  /// Whether the nationality dropdown menu is open.
  final bool isMenuOpen;

  @override
  List<Object?> get props => <Object?>[
        passwordObscureText,
        mobilePrefix,
        isReceiveEmail,
        isChecked,
        isAgreed,
        screenWidth,
        requestModel,
        successMsg,
        showDefaultErrMsg,
        cmsResponseModel,
        fullNameErrorMessage,
        mobileErrorMessage,
        emailErrorMessage,
        nationalityErrorMessage,
        passwordErrorMessage,
        termConditionErrorMessage,
        dateOfBirthErrorMessage,
        selectedGender,
        genderErrorMessage,
        ...super.props,
        isMenuOpen
      ];

  /// Creates a copy of this state with the given fields replaced with new values.
  /// 
  /// Returns a new [SignupState] instance with the specified parameters updated
  /// while keeping all other parameters unchanged.
  SignupState copyWith(
      {BaseStateStatus? status,
      bool? passwordObscureText,
      bool? cnfPasswordObscureText,
      String? mobilePrefix,
      bool? isReceiveEmail,
      bool? isAgreed,
      bool? isSocial,
      String? screenWidth,
      String? msg,
      PageRouteInfo? redirectRoute,
      SignUpUserOtpRequestModel? requestModel,
      String? successMsg,
      bool? showDefaultErrMsg,
      bool? isChecked,
      CmsResponseModel? cmsResponseModel,
      String? fullNameErrorMessage,
      String? mobileErrorMessage,
      String? emailErrorMessage,
      String? nationalityErrorMessage,
      String? passwordErrorMessage,
      String? termConditionErrorMessage,
      String? dateOfBirthErrorMessage,
      TextEditingController? nationalityController,
      String? selectedGender,
      String? genderErrorMessage,
      bool? isMenuOpen}) {
    return SignupState(
        status: status ?? this.status,
        passwordObscureText: passwordObscureText ?? this.passwordObscureText,
        mobilePrefix: mobilePrefix ?? this.mobilePrefix,
        isReceiveEmail: isReceiveEmail ?? this.isReceiveEmail,
        isAgreed: isAgreed ?? this.isAgreed,
        firstNameFocusNode: firstNameFocusNode,
        nationalityFocusNode: nationalityFocusNode,
        mobileNumberFocusNode: mobileNumberFocusNode,
        emailFocusNode: emailFocusNode,
        passwordFocusNode: passwordFocusNode,
        referralCodeFocusNode: referralCodeFocusNode,
        dateOfBirthFocusNode: dateOfBirthFocusNode,
        fullNameController: fullNameController,
        nationalityController:
            nationalityController ?? this.nationalityController,
        dateOfBirthController: dateOfBirthController,
        mobileController: mobileController,
        emailController: emailController,
        passwordController: passwordController,
        referralCodeController: referralCodeController,
        formKey: formKey,
        screenWidth: screenWidth ?? this.screenWidth,
        msg: msg,
        redirectRoute: redirectRoute,
        isSocial: isSocial ?? this.isSocial,
        requestModel: requestModel ?? this.requestModel,
        successMsg: successMsg ?? this.successMsg,
        showDefaultErrMsg: showDefaultErrMsg ?? this.showDefaultErrMsg,
        isChecked: isChecked ?? this.isChecked,
        fullNameErrorMessage: fullNameErrorMessage ?? this.fullNameErrorMessage,
        mobileErrorMessage: mobileErrorMessage ?? this.mobileErrorMessage,
        emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
        nationalityErrorMessage:
            nationalityErrorMessage ?? this.nationalityErrorMessage,
        passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
        termConditionErrorMessage:
            termConditionErrorMessage ?? this.termConditionErrorMessage,
        dateOfBirthErrorMessage:
            dateOfBirthErrorMessage ?? this.dateOfBirthErrorMessage,
        selectedGender: selectedGender ?? this.selectedGender,
        genderErrorMessage: genderErrorMessage ?? this.genderErrorMessage,
        cmsResponseModel: cmsResponseModel ?? this.cmsResponseModel,
        isMenuOpen: isMenuOpen ?? this.isMenuOpen);
  }
}
