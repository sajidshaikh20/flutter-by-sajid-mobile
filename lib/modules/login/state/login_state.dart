import '../../../../utils/exports.dart';

/// `LoginState` class represents the state of the login screen.
///
/// It extends `BaseState` and contains properties related to the login process.
class LoginState extends BaseState {
  ///
  const LoginState({
    this.passwordObscureText = true,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    this.screenWidth = '',
    required super.status,
    super.msg = '',
    super.redirectRoute,
    this.showDefaultErrMsg = false,
    required this.emailFocusNode,
    required this.passwordFocusNode,

    this.emailErrorMessage = '',
    this.passwordErrorMessage = '',
    this.isEmailConsidered = true,
    this.isNumberConsidered = false,
  });

  /// This is a boolean variable that determines whether the password is
  /// obscured or not.
  final bool passwordObscureText;

  /// This is a global key that is used to identify the form.
  final GlobalKey<FormState> formKey;

  /// This is a text editing controller that is used to control the email text
  /// field.
  final TextEditingController emailController;

  /// This is a text editing controller that is used to control the password
  /// text field.
  final TextEditingController passwordController;

  /// This is a string variable that represents the screen width.
  final String screenWidth;

  /// This is a boolean variable that determines whether the default error
  /// message should be shown or not.
  final bool? showDefaultErrMsg;

  /// This is a focus node that is used to control the focus of the email text
  /// field.
  final FocusNode emailFocusNode;

  /// This is a focus node that is used to control the focus of the password
  /// text field.
  final FocusNode passwordFocusNode;



  /// This is a string variable that represents the error message for the
  /// email text field.
  final String? emailErrorMessage;

  /// This is a string variable that represents the error message for the
  /// password text field.
  final String? passwordErrorMessage;

  /// This is a boolean variable that determines whether the email is
  /// considered or not.
  final bool? isEmailConsidered;

  /// This is a boolean variable that determines whether the number is
  /// considered or not.
  final bool? isNumberConsidered;

  /// `props` is a getter method that returns a list of objects. This list is
  /// used to determine whether two `LoginState` objects are equal. If all the
  /// properties in the list are equal, then the two objects are considered
  /// equal.
  ///
  @override
  List<Object?> get props => <Object?>[
        passwordObscureText,
        screenWidth,
        showDefaultErrMsg,
        ...super.props,
        emailErrorMessage,
        passwordErrorMessage,
        isEmailConsidered,
        isNumberConsidered
      ];

  /// The `copyWith` method is a common pattern in Dart for creating a new
  /// object with some of the properties of the original object modified.
  ///
  /// - Parameters:
  ///   - status: The status of the state.
  ///   - passwordObscureText: A boolean value that determines whether the
  ///     password text should be obscured or not.
  ///   - redirectRoute: The route to redirect to.
  ///   - msg: The message to be displayed.
  ///   - screenWidth: The width of the screen.
  ///   - showDefaultErrMsg: A boolean value that determines whether to show
  ///     the default error message.
  ///   - bioMatricList: A list of biometric types.
  ///   - emailErrorMessage: The error message to display for the email field.
  ///   - passwordErrorMessage: The error message to display for the password
  ///     field.
  ///   - isEmailConsidered: A boolean value that determines whether the email
  ///     is considered.
  ///   - isNumberConsidered: A boolean value that determines whether the
  ///     number is considered.
  LoginState copyWith(
      {BaseStateStatus? status,
      bool? passwordObscureText,
      PageRouteInfo? redirectRoute,
      String? msg,
      String? screenWidth,
      bool? showDefaultErrMsg,

      String? emailErrorMessage,
      String? passwordErrorMessage,
      bool? isEmailConsidered,
      bool? isNumberConsidered,
      }) {
    return LoginState(
      status: status ?? this.status,
      passwordObscureText: passwordObscureText ?? this.passwordObscureText,
      emailController: emailController,
      passwordController: passwordController,
      formKey: formKey,
      redirectRoute: redirectRoute,
      msg: msg,
      screenWidth: screenWidth ?? this.screenWidth,
      showDefaultErrMsg: showDefaultErrMsg ?? this.showDefaultErrMsg,
      emailFocusNode: emailFocusNode,
      passwordFocusNode: passwordFocusNode,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      isEmailConsidered: isEmailConsidered ?? this.isEmailConsidered,
      isNumberConsidered: isNumberConsidered ?? this.isNumberConsidered,
    );
  }
}
