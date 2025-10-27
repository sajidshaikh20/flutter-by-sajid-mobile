import '../../../utils/exports.dart';

/// Immutable state representing the reset password form and its current values.
class ResetPasswordState extends BaseState {
  /// Whether the new password text should be obscured.
  final bool newPasswordObscureText;

  /// Whether the confirm password text should be obscured.
  final bool conFirmPasswordObscureText;

  /// Controller for the new password text field.
  final TextEditingController newPassController;

  /// Controller for the confirm password text field.
  final TextEditingController conPasswordController;

  /// Focus node for the new password field.
  final FocusNode newPassFocusNode;

  /// Focus node for the confirm password field.
  final FocusNode conPasswordFocusNode;

  /// Error message for the new password field.
  final String? newPassErrorMessage;

  /// Error message for the confirm password field.
  final String? conPassErrorMessage;

  /// Form key for validation.
  final GlobalKey<FormState> formKey;

  /// Success message to display.
  final String successMsg;

  /// Whether to show the default error message.
  final bool? showDefaultErrMsg;

  /// The mobile number associated with the reset password request.
  final String mobileNumber;

  /// Creates a new instance of [ResetPasswordState].
  const ResetPasswordState({
    required super.status,
    super.redirectRoute,
    super.msg,
    this.newPasswordObscureText = true,
    this.conFirmPasswordObscureText = true,
    required this.newPassController,
    required this.conPasswordController,
    required this.newPassFocusNode,
    required this.conPasswordFocusNode,
    this.newPassErrorMessage = '',
    this.conPassErrorMessage = '',
    required this.formKey,
    this.successMsg = '',
    this.showDefaultErrMsg = false,
    this.mobileNumber = '',
  });

  /// Creates a copy of this [ResetPasswordState] with optional new values.
  ResetPasswordState copyWith({
    BaseStateStatus? status,
    String? msg,
    bool? newPasswordObscureText,
    bool? conFirmPasswordObscureText,
    String? newPassErrorMessage,
    String? conPassErrorMessage,
    String? successMsg,
    bool? showDefaultErrMsg,
    bool? shouldGoBack,
    String? mobileNumber,
    PageRouteInfo? redirectRoute,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      msg: msg,
      redirectRoute: redirectRoute,
      newPasswordObscureText:
          newPasswordObscureText ?? this.newPasswordObscureText,
      conFirmPasswordObscureText:
          conFirmPasswordObscureText ?? this.conFirmPasswordObscureText,
      newPassController: newPassController,
      conPasswordController: conPasswordController,
      newPassFocusNode: newPassFocusNode,
      conPasswordFocusNode: conPasswordFocusNode,
      newPassErrorMessage: newPassErrorMessage ?? this.newPassErrorMessage,
      conPassErrorMessage: conPassErrorMessage ?? this.conPassErrorMessage,
      formKey: formKey,
      successMsg: successMsg ?? this.successMsg,
      showDefaultErrMsg: showDefaultErrMsg ?? this.showDefaultErrMsg,
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        newPasswordObscureText,
        conFirmPasswordObscureText,
        newPassErrorMessage,
        conPassErrorMessage,
        successMsg,
        showDefaultErrMsg,
        mobileNumber,
      ];
}
