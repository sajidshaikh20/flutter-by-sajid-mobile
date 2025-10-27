import '../../../utils/exports.dart';

/// State class for [ChangePasswordCubit].
///
/// Holds all UI and validation states for the change password screen,
/// including password visibility, input controllers, focus nodes, form validation,
/// error messages, and any success or redirect messages.
class ChangePasswordState extends BaseState {
  /// Creates an immutable state object for change password screen.
  const ChangePasswordState({
    required super.status,
    this.oldPassObscureText = true,
    this.newPassObscureText = true,
    this.cnfPasswordObscureText = true,
    required this.oldPassFocusNode,
    required this.newPassFocusNode,
    required this.cnfPassFocusNode,
    required this.oldPassController,
    required this.newPassController,
    required this.cnfPassController,
    required this.formKey,
    this.oldPassErrorMessage = '',
    this.newPassErrorMessage = '',
    this.conPassErrorMessage = '',
    this.screenWidth = '',
    super.msg = '',
    super.redirectRoute,
    this.successMsg = '',
    this.showDefaultErrMsg = false,
  });

  /// Whether the old password field is obscured.
  final bool oldPassObscureText;

  /// Whether the new password field is obscured.
  final bool newPassObscureText;

  /// Whether the confirm password field is obscured.
  final bool cnfPasswordObscureText;

  /// Message shown on successful password change.
  final String successMsg;

  /// Flag to show default error message if any.
  final bool? showDefaultErrMsg;

  /// Focus node for old password field.
  final FocusNode oldPassFocusNode;

  /// Focus node for new password field.
  final FocusNode newPassFocusNode;

  /// Focus node for confirm password field.
  final FocusNode cnfPassFocusNode;

  /// Text controller for old password field.
  final TextEditingController oldPassController;

  /// Text controller for new password field.
  final TextEditingController newPassController;

  /// Text controller for confirm password field.
  final TextEditingController cnfPassController;

  /// Validation error message for old password.
  final String? oldPassErrorMessage;

  /// Validation error message for new password.
  final String? newPassErrorMessage;

  /// Validation error message for confirm password.
  final String? conPassErrorMessage;

  /// Key for the change password form.
  final GlobalKey<FormState> formKey;

  /// Optional screen width string for UI adjustments/responsiveness.
  final String screenWidth;

  @override
  List<Object?> get props => <Object?>[
    oldPassObscureText,
    newPassObscureText,
    cnfPasswordObscureText,
    successMsg,
    showDefaultErrMsg,
    screenWidth,
    oldPassErrorMessage,
    newPassErrorMessage,
    conPassErrorMessage,
    redirectRoute,
    ...super.props,
  ];

  /// Returns a copy of this [ChangePasswordState] with updated fields.
  ///
  /// Useful for updating a subset of fields without modifying the original state.
  ChangePasswordState copyWith({
    BaseStateStatus? status,
    bool? oldPassObscureText,
    bool? newPassObscureText,
    bool? cnfPasswordObscureText,
    String? msg,
    PageRouteInfo? redirectRoute,
    SignupRequestModel? requestModel,
    String? successMsg,
    bool? showDefaultErrMsg,
    String? screenWidth,
    String? oldPassErrorMessage,
    String? newPassErrorMessage,
    String? conPassErrorMessage,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      oldPassObscureText: oldPassObscureText ?? this.oldPassObscureText,
      newPassObscureText: newPassObscureText ?? this.newPassObscureText,
      cnfPasswordObscureText: cnfPasswordObscureText ?? this.cnfPasswordObscureText,
      oldPassFocusNode: oldPassFocusNode,
      newPassFocusNode: newPassFocusNode,
      cnfPassFocusNode: cnfPassFocusNode,
      oldPassController: oldPassController,
      newPassController: newPassController,
      cnfPassController: cnfPassController,
      formKey: formKey,
      msg: msg,
      redirectRoute: redirectRoute,
      successMsg: successMsg ?? this.successMsg,
      showDefaultErrMsg: showDefaultErrMsg ?? this.showDefaultErrMsg,
      screenWidth: screenWidth ?? this.screenWidth,
      oldPassErrorMessage: oldPassErrorMessage ?? this.oldPassErrorMessage,
      newPassErrorMessage: newPassErrorMessage ?? this.newPassErrorMessage,
      conPassErrorMessage: conPassErrorMessage ?? this.conPassErrorMessage,
    );
  }
}
