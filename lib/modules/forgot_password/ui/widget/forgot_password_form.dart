import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../../app/providers/providers.dart';

/// `ForgotPasswordForm` is a widget that displays a form for users to
/// request a password reset.
class ForgotPasswordForm extends ConsumerStatefulWidget {
  /// Constructor for the `ForgotPasswordForm` widget.
  const ForgotPasswordForm({super.key, this.device = ScreenType.mobile});

  /// The device type to adjust the form's layout.
  ///
  /// Defaults to [ScreenType.mobile].
  final ScreenType device;

  @override
  ConsumerState<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends ConsumerState<ForgotPasswordForm> {
  late ForgotPasswordState _initialState;

  @override
  void initState() {
    super.initState();
    _initialState = ForgotPasswordState(
      forgotPasswordFocusNode: FocusNode(),
      status: BaseStateStatus.initial,
      resetPasswordFieldController: TextEditingController(),
      formKey: GlobalKey<FormState>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to state changes
    ref.listen<ForgotPasswordState>(
      forgotPasswordNotifierProvider(_initialState),
      (ForgotPasswordState? previous, ForgotPasswordState next) {
        if (next.successMsg.isNotEmpty) {
          displaySnackBar(next.successMsg, context);
          ref.read(forgotPasswordNotifierProvider(_initialState).notifier).resetSuccessMsg();
        } else if (next.msg != null && (next.msg?.isNotEmpty ?? false)) {
          displaySnackBar(next.msg ?? '', context);
        }
        if (next.shouldGoBack) {
          goBack(context);
          ref.read(forgotPasswordNotifierProvider(_initialState).notifier).resetSuccessMsg();
        }
        if (next.redirectRoute != null && context.mounted) {
          unawaited(context.router.push(next.redirectRoute!));
        }
      },
    );

    final ForgotPasswordState state = ref.watch(forgotPasswordNotifierProvider(_initialState));
    
    double horizontalPadding = Dimens.space16;

    switch (widget.device) {
      case ScreenType.tablet:
        horizontalPadding = Dimens.space90;

      default:
        break;
    }

    return NoInternetWidget(
        childWidget: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
          title: context.appString.forgotPasswordTitleKey,
          isLogoVisible: false,
          device: widget.device,
          onTap: () {
            context.router.removeLast();
          }),
      body: Stack(
        children: <Widget>[
          // Background SVG
          Positioned.fill(
            child: Assets.svgs.bgFullscreenCommon.svg(
              fit: BoxFit.fill,),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Form(
              key: state.formKey,
                child: Column(
                  children: <Widget>[
                    Dimens.size15.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space26),
                      child: CustomTextLabelWidget(
                        label: context.appString.detailForgotPasswordKey,
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            height: Dimens.lineHeight18
                                .toLineHeight(Dimens.fontSize14),
                            fontSize: Dimens.fontSize14),
                      ),
                    ),
                    Dimens.size33.heightBox,
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final ForgotPasswordState currentState = ref.watch(forgotPasswordNotifierProvider(_initialState));
                        final ForgotPasswordNotifier currentNotifier = ref.read(forgotPasswordNotifierProvider(_initialState).notifier);
                        
                        return SegmentedControl(
                          firstTitle: context.appString.mobileKey,
                          secondTitle: context.appString.emailKey,
                          selectedIndex: currentState.selectedSegmentIndex ?? 0,
                          onIndexChanged: (int value) {
                            currentNotifier.onSegmentChangedIndex(value);
                            currentNotifier.handleValidationErrorMessageForEmailOrPhone('');
                          },
                        );
                      },
                    ),
                    Dimens.size31.heightBox,
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final ForgotPasswordState currentState = ref.watch(forgotPasswordNotifierProvider(_initialState));
                        final ForgotPasswordNotifier currentNotifier = ref.read(forgotPasswordNotifierProvider(_initialState).notifier);
                        
                        return CommonTextFormFieldWidget(
                          focusNode: currentState.forgotPasswordFocusNode,
                          maxLength: currentState.selectedSegmentIndex == 0
                              ? Dimens.maxLength8
                              : Dimens.maxLength50,
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: Dimens.size24,
                            minHeight: Dimens.size24,
                            maxWidth: Dimens.size62,
                            maxHeight: Dimens.size50,
                          ),
                          prefixIcon: currentState.selectedSegmentIndex == 0
                              ? CustomTextLabelWidget(
                                  textDirection: TextDirection.ltr,
                                  label: context.appString.kuwaitCountryCodeKey,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      height: Dimens.lineHeight24
                                          .toLineHeight(Dimens.fontSize16),
                                      fontSize: Dimens.fontSize16),
                                )
                              : null,
                          device: widget.device,
                          errorMsg: currentState.emailErrorMessage,
                          textInputType: currentState.selectedSegmentIndex == 0
                              ? TextInputType.number
                              : TextInputType.text,
                          controller: currentState.resetPasswordFieldController,
                          onChange: (String value) {
                            if (value.isEmpty) {
                              currentNotifier.handleValidationErrorMessageForEmailOrPhone('');
                            }
                            if (currentState.selectedSegmentIndex == 0) {
                              if (value.validMobileBool(isRequired: true) == true) {
                                currentNotifier.handleValidationErrorMessageForEmailOrPhone('');
                              }
                            }
                            if (currentState.selectedSegmentIndex == 1) {
                              if (value.validateEmailBool() ?? false) {
                                currentNotifier.handleValidationErrorMessageForEmailOrPhone('');
                              }
                            }
                          },
                          label: currentState.selectedSegmentIndex == 0
                              ? context.appString.mobileNumberKey
                              : context.appString.emailIdKey,
                        );
                      },
                    ),
                    const Spacer(),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final ForgotPasswordState currentState = ref.watch(forgotPasswordNotifierProvider(_initialState));
                        final ForgotPasswordNotifier currentNotifier = ref.read(forgotPasswordNotifierProvider(_initialState).notifier);
                        
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimens.space25),
                          child: CustomGradientButtonWidget(
                            device: widget.device,
                            title: currentState.selectedSegmentIndex == 0
                                ? context.appString.getOtpKey
                                : context.appString.sendKey,
                            onTap: () async {
                              final String resetPasswordText = currentState.resetPasswordFieldController.text.trim();

                              if (currentState.selectedSegmentIndex == 0) {
                                // Phone number validation
                                if (resetPasswordText.isEmpty) {
                                  currentNotifier.handleValidationErrorMessageForEmailOrPhone(
                                      context.appString.pleaseEnterMobileNumberKey);
                                  return;
                                }

                                final String? mobileError = resetPasswordText.validMobileNo(
                                    emptyMobileMsg: context.appString.pleaseEnterMobileNumberKey,
                                    onlyNumbersAllowedMsg: context.appString.onlyNumbersAllowedKey,
                                    invalidMobileMsg: context.appString.enterValidMobileNumberKey);
                                if (mobileError?.isNotEmpty ?? false) {
                                  currentNotifier.handleValidationErrorMessageForEmailOrPhone(mobileError ?? "");
                                  return;
                                } else {
                                  currentNotifier.handleValidationErrorMessageForEmailOrPhone("");
                                }

                                await currentNotifier.callForgotPasswordWithMobileApi();
                              } else {
                                // Email validation
                                final String? emailError = resetPasswordText.validateEmail(
                                    isOnlyEmail: true,
                                    enterMobileOrNumberMsg: context.appString.pleaseEnterMobileOrNumberKey,
                                    enterEmailMsg: context.appString.pleaseEnterTheEmailKey,
                                    validEmailMsg: context.appString.pleaseEnterValidEmailKey);
                                if (emailError?.isNotEmpty ?? false) {
                                  currentNotifier.handleValidationErrorMessageForEmailOrPhone(emailError ?? "");
                                  return;
                                } else {
                                  currentNotifier.handleValidationErrorMessageForEmailOrPhone("");
                                }

                                await currentNotifier.callForgotPasswordWithEmailApi();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
