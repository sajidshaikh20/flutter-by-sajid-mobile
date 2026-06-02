import '../../../utils/exports.dart';

/// State for the forgot password screen.
class ForgotPasswordState extends BaseState {
  /// Creates [ForgotPasswordState].
  const ForgotPasswordState({
    required super.status,
    required this.emailController,
    required this.formKey,
    required this.emailFocusNode,
    super.msg = '',
    super.redirectRoute,
    this.emailErrorMessage = '',
  });

  /// Email input controller.
  final TextEditingController emailController;

  /// Form key for validation.
  final GlobalKey<FormState> formKey;

  /// Focus node for email field.
  final FocusNode emailFocusNode;

  /// Email field validation error.
  final String emailErrorMessage;

  @override
  List<Object?> get props => <Object?>[emailErrorMessage, ...super.props];

  /// Returns a copy with updated fields.
  ForgotPasswordState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    String? emailErrorMessage,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      emailController: emailController,
      formKey: formKey,
      emailFocusNode: emailFocusNode,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
    );
  }
}
