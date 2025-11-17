import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';

/// A widget for the login form.
///
/// OPTIMIZATION NOTES:
/// - Uses Consumer widgets only where necessary for reactive UI updates
/// - Static elements (like buttons, spacing) remain outside Consumer for performance
class LoginForm extends ConsumerStatefulWidget {
  ///
  const LoginForm({
    super.key,
  });

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  @override
  void initState() {
    super.initState();
    // Listen to login state changes
    ref.listen<LoginState>(loginNotifierProvider, (LoginState? previous, LoginState next) {
      if (next.msg != null && (next.msg?.isNotEmpty ?? false)) {
        displaySnackBar(next.msg ?? '', context);
      }
      if (next.redirectRoute != null && mounted) {
        unawaited(context.router.replaceAll(<PageRouteInfo>[next.redirectRoute!]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final LoginState state = ref.watch(loginNotifierProvider);
    
    return NoInternetWidget(
        onTryAgain: () {},
        childWidget: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Form(
          key: state.formKey,
            child: Column(
              children: <Widget>[
                const TopViewOnboardingLogin(
                  isFromLogin: true,
                ),
                Expanded(
                  child: BottomViewOnboardingLogin(
                      childWidget: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Dimens.size16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Dimens.size50.heightBox,
                          CustomTextLabelWidget(
                            label: context.appString.loginKey,
                            style: context.textTheme.titleLarge?.copyWith(
                                height: Dimens.lineHeight28
                                    .toLineHeight(Dimens.fontSize24),
                                fontSize: Dimens.fontSize24),
                          ),
                          Dimens.size40.heightBox,

                          Consumer(
                            builder: (BuildContext context, WidgetRef ref, Widget? child) {
                              final LoginState currentState = ref.watch(loginNotifierProvider);
                              final LoginNotifier currentNotifier = ref.read(loginNotifierProvider.notifier);
                              
                              return CommonTextFormFieldWidget(
                                controller: currentState.emailController,
                                label: context.appString.labelMobileOrMailKey,
                                input: TextInputAction.next,
                                focusNode: currentState.emailFocusNode,
                                errorMsg: currentState.emailErrorMessage,
                                prefixIconConstraints:
                                    (currentState.isNumberConsidered ?? false)
                                        ? const BoxConstraints(
                                            minWidth: Dimens.size24,
                                            minHeight: Dimens.size24,
                                            maxWidth: Dimens.size62,
                                            maxHeight: Dimens.size50,
                                          )
                                        : null,
                                prefixIcon: (currentState.isNumberConsidered ?? false)
                                    ? CustomTextLabelWidget(
                                        textDirection: TextDirection.ltr,
                                        label: context
                                            .appString.kuwaitCountryCodeKey,
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                height: Dimens.lineHeight24
                                                    .toLineHeight(
                                                        Dimens.fontSize16),
                                                fontSize: Dimens.fontSize16),
                                      )
                                    : null,
                                onChange: (String value) {
                                  if (value.startsWithNumber()) {
                                    currentNotifier.updateNumberConsideration(
                                            isNumber: true);
                                  }
                                  if (value.containsChar()) {
                                    currentNotifier.updateNumberConsideration(
                                            isNumber: false);
                                  }

                                  if (value.isEmpty) {
                                    currentNotifier
                                      ..handleValidationErrorMessageForEmail('')
                                      ..updateNumberConsideration(
                                          isNumber: false);
                                  }
                                  if (value.validateEmailBool() ?? true) {
                                    currentNotifier
                                        .handleValidationErrorMessageForEmail(
                                            '');
                                  }
                                  if (value.validMobileBool() == true) {
                                    currentNotifier
                                        .handleValidationErrorMessageForEmail(
                                            '');
                                  }
                                },
                                maxLength: (currentState.isNumberConsidered ?? false)
                                    ? Dimens.maxLength8
                                    : Dimens.maxLength50,
                                onTextSubmit: (_) {
                                  currentNotifier
                                      .moveToNextField(currentState.passwordFocusNode);
                                },
                                textCapitalization: TextCapitalization.none,
                              );
                            },
                          ),
                          Dimens.size16.heightBox,
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref, Widget? child) {
                              final LoginState currentState = ref.watch(loginNotifierProvider);
                              final LoginNotifier currentNotifier = ref.read(loginNotifierProvider.notifier);
                              
                              return CommonTextFormFieldWidget(
                                controller: currentState.passwordController,
                                label: context.appString.passwordKey,
                                input: TextInputAction.done,
                                focusNode: currentState.passwordFocusNode,
                                errorMsg: currentState.passwordErrorMessage,
                                maxLength: Dimens.maxLength15,
                                obscureText: currentState.passwordObscureText,
                                onChange: (String value) {
                                  if (value.validatePasswordBool() ?? false) {
                                    currentNotifier
                                        .handleValidationErrorMessageForPassword(
                                            '');
                                  }
                                },
                                suffixIcon: CustomTextLabelWidget(
                                  label: currentState.passwordObscureText
                                      ? context.appString.showKey
                                      : context.appString.hideKey,
                                  textAlign: TextAlign.start,
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      height: Dimens.lineHeight16
                                          .toLineHeight(Dimens.fontSize12),
                                      color: MainConfig
                                          .appColors.textLightBlackColor,
                                      fontSize: Dimens.fontSize12),
                                  onTap: () {
                                    currentNotifier.toggleCurrentPassObscureText();
                                  },
                                ),
                              );
                            },
                          ),
                          Dimens.size15.heightBox,
                          const OtherAuthView(),
                          Dimens.size16.heightBox,
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref, Widget? child) {
                              final LoginState currentState = ref.watch(loginNotifierProvider);
                              final LoginNotifier currentNotifier = ref.read(loginNotifierProvider.notifier);
                              
                              return CustomGradientButtonWidget(
                              title: context.appString.loginKey,
                              onTap: () async {
                                  final String email = currentState
                                      .emailController.text
                                    .trim();
                                  final String password = currentState
                                      .passwordController.text
                                    .trim();
                                  bool isValid = true;

                                // Empty check
                                if (email.isEmpty || password.isEmpty) {
                                  if (email.isEmpty) {
                                      currentNotifier.handleValidationErrorMessageForEmail(
                                        "${context.appString.pleaseEnterMobileOrNumberKey}.");
                                    isValid = false;
                                  }
                                  if (password.isEmpty) {
                                      currentNotifier
                                        .handleValidationErrorMessageForPassword(
                                            "${context.appString.pleaseEnterThePasswordKey}.");
                                    isValid = false;
                                  }
                                }

                                // Validate Mobile Number
                                  if (email.isNotEmpty) {
                                    if (currentState.isNumberConsidered ?? false) {
                                    final String? mobileError =
                                    email.validMobileNo(
                                        emptyMobileMsg: context.appString
                                            .pleaseEnterMobileNumberKey,
                                        onlyNumbersAllowedMsg: context
                                            .appString.onlyNumbersAllowedKey,
                                        invalidMobileMsg: context.appString
                                            .enterValidMobileNumberKey);
                                    if (mobileError?.isNotEmpty ?? false) {
                                        currentNotifier
                                          .handleValidationErrorMessageForEmail(
                                          mobileError ?? "");
                                      isValid = false;
                                    } else {
                                        currentNotifier
                                          .handleValidationErrorMessageForEmail(
                                            "");
                                      }
                                  }
                                }

                                // Validate Email
                                if (email.isNotEmpty && (email.startsWithLetter() ||
                                      currentState.isNumberConsidered == false)) {
                                  final String? emailError =
                                      email.validateEmail(
                                          isOnlyEmail: true,
                                          enterMobileOrNumberMsg: context
                                              .appString
                                              .pleaseEnterMobileOrNumberKey,
                                          enterEmailMsg: context
                                              .appString.pleaseEnterTheEmailKey,
                                          validEmailMsg: context.appString
                                              .pleaseEnterValidEmailKey);
                                  if (emailError?.isNotEmpty ?? false) {
                                      currentNotifier
                                        .handleValidationErrorMessageForEmail(
                                            emailError ?? "");
                                    isValid = false;
                                  } else {
                                      currentNotifier
                                        .handleValidationErrorMessageForEmail(
                                              "");
                                    }
                                }

                                // Validate Password
                                if (password.isNotEmpty) {
                                  final String? passwordError = password
                                      .validatePassword(
                                      isNewPassword: true,
                                      customError: context.appString
                                          .pleaseEnterThePasswordKey,
                                      emptyPasswordMsg: context.appString
                                          .pleaseEnterThePasswordKey,
                                      invalidPasswordMsg: context
                                          .appString.passAllCriteriaKey);
                                  if (passwordError?.isNotEmpty ?? false) {
                                      currentNotifier
                                        .handleValidationErrorMessageForPassword(
                                        passwordError ?? "");
                                    isValid = false;
                                  } else {
                                      currentNotifier
                                        .handleValidationErrorMessageForPassword(
                                          "");
                                    }
                                }

                                if (isValid) {
                                    await currentNotifier.login(
                                    emailMobile: email,
                                    password: password,
                                  );
                                }
                                },
                              );
                            },
                          ),
                          Dimens.size65.heightBox,
                          CustomTextLabelWidget(
                            onTap: () async {
                             // await context.router.replace(const DashboardRoute());
                            },
                            label: context.appString.continueGuestKey,
                            style: context.textTheme.titleLarge?.copyWith(
                                height: Dimens.lineHeight20
                                    .toLineHeight(Dimens.fontSize20),
                                fontWeight: FontWeight.w600,
                                fontSize: Dimens.fontSize14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimens.space50, top: Dimens.size82),
                            child: CustomTextLabelWidget(
                              onTap: () async {
                                await context.router.push(const SignUpRoute());
                              },
                              label: context.appString.dontHaveAccountKey,
                              style: context.textTheme.titleLarge?.copyWith(
                                  height: Dimens.lineHeight20
                                      .toLineHeight(Dimens.fontSize14),
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimens.fontSize14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
