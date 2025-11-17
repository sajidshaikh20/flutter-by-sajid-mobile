import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../utils/exports.dart';
import '../../../../../app/providers/providers.dart';

/// A widget that displays an OTP input screen for user verification.
/// Handles OTP input, validation, and navigation after successful verification.
class OtpPageWidget extends ConsumerStatefulWidget {
  /// The email address associated with the OTP verification.
  final String email;

  /// The country code prefix for the phone number.
  final String prefix;

  /// The route to redirect to after successful OTP verification.
  final PageRouteInfo? redirectRoute;

  /// Parameters for OTP notifier
  final OtpNotifierParams params;

  /// Creates an [OtpPageWidget].
  ///
  /// [email] and [prefix] are required parameters.
  /// [redirectRoute] is optional and specifies where to navigate after verification.
  const OtpPageWidget({
    super.key,
    required this.email,
    required this.prefix,
    this.redirectRoute,
    required this.params,
  });

  @override
  ConsumerState<OtpPageWidget> createState() => _OtpPageWidgetState();
}

class _OtpPageWidgetState extends ConsumerState<OtpPageWidget> with WidgetsBindingObserver {
  bool _isFocusing = false; // Prevent multiple simultaneous focus attempts

  @override
  void initState() {
    super.initState();
    try {
      WidgetsBinding.instance.addObserver(this);
      
      // Multiple focus attempts to ensure keyboard opens after navigation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _focusOtpField();
        }
      });
      
      // Additional focus attempt for navigation from previous screen
      Future<void>.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _focusOtpField();
        }
      });
      
      // Final attempt for stubborn cases
      Future<void>.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          _focusOtpField();
        }
      });
    } on Exception {
      // Handle any potential errors silently
    }
  }

  @override
  void dispose() {
    try {
      WidgetsBinding.instance.removeObserver(this);
    } on Exception {
      // Handle any potential errors silently
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Focus when app becomes active (user returns to app)
    if (state == AppLifecycleState.resumed && mounted) {
      try {
        Future<void>.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            _focusOtpField();
          }
        });
      } on Exception {
        // Handle any potential errors silently
      }
    }
  }

  void _focusOtpField() {
    if (_isFocusing || !mounted) return; // Prevent multiple simultaneous attempts and check if widget is still mounted
    
    try {
      final OtpNotifier notifier = ref.read(otpNotifierProvider(widget.params).notifier);
      final OtpPinFieldState? otpState = notifier.otpPinFieldKey.currentState;
      if (otpState != null && mounted) {
        _isFocusing = true;
        otpState.onFieldFocus();
        
        // Reset the flag after a delay to allow keyboard to open
        Future<void>.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            _isFocusing = false;
          }
        });
      }
    } on Exception {
      // Handle any potential errors silently
      _isFocusing = false;
    }
  }


  @override
  Widget build(BuildContext context) {
    final String phoneNumberPrefix = widget.prefix;
    return Scaffold(
      appBar: CustomAppBar(
          title: context.appString.verifyOTPKey,
          isLogoVisible: false,
          onTap: () async {
            if (context.router.canPop()) {
              await context.router.maybePop();
            }
          }),
      body: GestureDetector(
        onTap: () {
          // Only focus if not already focusing to prevent misbehavior
          try {
            if (!_isFocusing && mounted) {
              _focusOtpField();
            }
          } on Exception {
            // Handle any potential errors silently
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.space16, vertical: Dimens.space13),
          child: Column(
          children: <Widget>[
            Dimens.space2.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space26),
              child: CustomTextLabelWidget(
               label: context.appString.verifyOTPTitleKey,
               style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.fontSize14),

              ),
            ),
            CustomTextLabelWidget(
              textDirection: TextDirection.ltr,
              label: widget.email.validateEmailBool() ?? false
                  ? widget.email
                  : '${AppConstant.plus}$phoneNumberPrefix ${widget.email}',
              style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: MainConfig.appColors.spanTextColor,
                  fontSize: Dimens.fontSize14),
            ),

            Dimens.size33.heightBox,
            //otp text field
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final OtpState state = ref.watch(otpNotifierProvider(widget.params));
                return GestureDetector(
                  onTap: () {
                    // Simple focus without aggressive behavior
                    try {
                      if (!_isFocusing && mounted) {
                        _focusOtpField();
                      }
                    } on Exception {
                      // Handle any potential errors silently
                    }
                  },
                  child: OtpPinField(
                    fieldHeight: Dimens.size44,
                    fieldWidth: Dimens.size44,
                    key: ref.read(otpNotifierProvider(widget.params).notifier).otpPinFieldKey,
                    phoneNumbersHint: true,
                    onSubmit: (String text) {
                      // OTP submitted - don't close keyboard
                    },
                    onChange: (String text) {
                      ref.read(otpNotifierProvider(widget.params).notifier).otpChange(text);
                      // Simple focus management - only if not already focusing
                      if (!_isFocusing && text.length < 4) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!_isFocusing) {
                            _focusOtpField();
                          }
                        });
                      }
                    },
                  otpPinFieldStyle: OtpPinFieldStyle(
                      textStyle: context.textTheme.titleMedium!.copyWith(
                        color: MainConfig.appColors.textBlackColor,
                        fontSize: Dimens.fontSize14,
                      ),
                      fieldBorderRadius: Dimens.radius8,
                      defaultFieldBoxShadow: <BoxShadow>[],
                      defaultFieldBackgroundColor:
                          MainConfig.appColors.backgroundWhite,
                      activeFieldBackgroundColor:
                          MainConfig.appColors.backgroundWhite,
                      defaultFieldBorderColor:
                          MainConfig.appColors.dukkanborderGreyLightColor,
                      activeFieldBorderColor: MainConfig.appColors.mainColor,
                      fieldBorderWidth: Dimens.borderWidth1),
                  onCodeChanged: (String code) {},
                  cursorColor: MainConfig.appColors.primary,
                  showCustomKeyboard: false,
                  cursorWidth: Dimens.space1,
                  mainAxisAlignment: MainAxisAlignment.center,
                  otpPinFieldDecoration: OtpPinFieldDecoration.custom,
                  ),
                );
              },
            ),
            Dimens.size20.heightBox,
            // required when we integrate api
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final OtpState state = ref.watch(otpNotifierProvider(widget.params));
                return CustomRichTextLabel(
                  primaryLabel: context.appString.resendOtpInKey,
                  primaryStyle: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      height:
                          Dimens.lineHeight20.toLineHeight(Dimens.fontSize14),
                      fontSize: Dimens.fontSize14),
                  secondaryLabel:
                      "00:${state.secondsRemaining.toString().padLeft(2, '0')}",
                  secondaryStyle: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: MainConfig.appColors.darkGreenColor,
                      height:
                          Dimens.lineHeight20.toLineHeight(Dimens.fontSize14),
                      fontSize: Dimens.fontSize14),
                );
              },
            ),
            Dimens.size24.heightBox,

            // required when we integrate api
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final OtpState state = ref.watch(otpNotifierProvider(widget.params));
                final OtpNotifier notifier = ref.read(otpNotifierProvider(widget.params).notifier);
                
                return CustomRichTextLabel(
                    onTapSecondaryLabel: () async {
                      if (state.secondsRemaining == 0) {
                        await notifier.resendOtp(
                          mobileNumber: widget.email,
                          email: state.flowType == OtpFlowType.updateEmail ? widget.email : null,
                        );
                      }
                    },
                    secondaryLabel: context.appString.resendCodeKey,
                    secondaryStyle: context.textTheme.titleMedium!.copyWith(
                        color: state.secondsRemaining == 0
                            ? MainConfig.appColors.mainColor
                            : AppColors.grey,
                        fontSize: Dimens.fontSize14));
              },
            ),
            const Spacer(),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final OtpState state = ref.watch(otpNotifierProvider(widget.params));
                final OtpNotifier notifier = ref.read(otpNotifierProvider(widget.params).notifier);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.space20),
                  child: CustomGradientButtonWidget(
                    title: context.appString.verifyKey,
                    isButtonEnabled:
                        state.otpNumber.length == AppConstant.otpTextLength,
                    onTap: state.otpNumber.length == AppConstant.otpTextLength
                        ? () async {
                           await notifier.verifyOtp(
                             mobileNumber: widget.email,
                             redirectRoute: widget.redirectRoute,
                           );
                          }
                        : () {},
                  ),
                );
              },
            ),
          ],
        ),
        ),
      ),
    );
  }
}
