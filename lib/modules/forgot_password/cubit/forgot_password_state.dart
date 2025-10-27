import '../../../utils/exports.dart';

/// Immutable state representing the forgot password screen.
class ForgotPasswordState extends BaseState {
  /// Creates an instance of [ForgotPasswordState].
  ///
  /// [resetPasswordFieldController] Controller for the password reset input field.
  /// [formKey] Global key for the form validation.
  /// [successMsg] Success message to display.
  /// [status] The current state status.
  /// [msg] Message to display.
  /// [redirectRoute] Route to redirect to.
  /// [showDefaultErrMsg] Whether to show default error message.
  /// [forgotPasswordFocusNode] Focus node for the forgot password field.
  /// [emailErrorMessage] Validation error message for email field.
  /// [selectedSegmentIndex] Index of the selected segment (email/mobile).
  /// [shouldGoBack] Whether the user should navigate back.
  const ForgotPasswordState({
    required this.resetPasswordFieldController,
    required this.formKey,
    this.successMsg = '',
    required super.status,
    super.msg = '',
    super.redirectRoute,
    this.showDefaultErrMsg = false,
    required this.forgotPasswordFocusNode,
    this.emailErrorMessage = '',
    this.selectedSegmentIndex = 0,
    this.shouldGoBack = false,
  });

  /// Global key for the form validation.
  final GlobalKey<FormState> formKey;

  /// Controller for the password reset input field.
  final TextEditingController resetPasswordFieldController;

  /// Success message to display.
  final String successMsg;

  /// Whether to show default error message.
  final bool? showDefaultErrMsg;

  /// Index of the selected segment (email/mobile).
  final int? selectedSegmentIndex;

  /// Focus node for the forgot password field.
  final FocusNode forgotPasswordFocusNode;

  /// Validation error message for email field.
  final String? emailErrorMessage;

  /// Whether the user should navigate back.
  final bool shouldGoBack;

  @override
  List<Object?> get props => <Object?>[
        successMsg,
        showDefaultErrMsg,
        forgotPasswordFocusNode,
        emailErrorMessage,
        selectedSegmentIndex,
        shouldGoBack,
        ...super.props,
      ];

  /// Creates a copy of this [ForgotPasswordState] with optional new values.
  ForgotPasswordState copyWith({
     BaseStateStatus? status,
    String? msg,
    String? successMsg,
    bool? showDefaultErrMsg,
    String? emailErrorMessage,
    FocusNode? forgotPasswordFocusNode, // Allow updating focus node
    int? selectedSegmentIndex, // Add parameter to update the index
    bool? shouldGoBack,
    PageRouteInfo? redirectRoute,
  }) {
    return ForgotPasswordState(
      status: status??this.status,
      resetPasswordFieldController: resetPasswordFieldController,
      formKey: formKey,
      forgotPasswordFocusNode:
          forgotPasswordFocusNode ?? this.forgotPasswordFocusNode,
      successMsg: successMsg ?? this.successMsg,
      msg: msg,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      showDefaultErrMsg: showDefaultErrMsg ?? this.showDefaultErrMsg,
      selectedSegmentIndex: selectedSegmentIndex ?? this.selectedSegmentIndex,
      shouldGoBack: shouldGoBack ?? this.shouldGoBack,
      redirectRoute: redirectRoute,
    );
  }
}
