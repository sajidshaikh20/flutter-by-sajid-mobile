import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';

/// A page for OTP verification during user authentication flows.
/// Supports different OTP flows like signup, login, and email updates.
@RoutePage()
class VerifyOtpPage extends ConsumerWidget {
  /// The route to redirect to after successful OTP verification.
  final PageRouteInfo? redirectRoute;

  /// The email address associated with the OTP verification.
  final String email;

  /// The country code prefix for phone number verification.
  final String prefix;

  /// Form data for signup flow, if applicable.
  final SignUpFormDataModel? formData;


  /// The type of OTP flow (signup, login, email update, etc.).
  final OtpFlowType flowType;

  /// Pre-filled OTP value for auto-completion, if available.
  final String? autoFilledOtp;

  static Completer<void>? _navigationCompleter;
  static bool _okHandled = false; // prevent multiple rapid OK taps

  /// Creates a [VerifyOtpPage] widget.
  ///
  /// [email] and [prefix] are required parameters.
  /// [flowType] defaults to [OtpFlowType.forgotPassword].
  /// Other parameters are optional.
  const VerifyOtpPage({
    super.key,
    required this.email,
    required this.prefix,
    this.redirectRoute,
    this.formData,
    this.flowType = OtpFlowType.forgotPassword,
    this.autoFilledOtp,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OtpNotifierParams params = OtpNotifierParams(
      flowType: flowType,
      signupFormData: formData,
      autoFilledOtp: autoFilledOtp,
    );
    
    // Listen to state changes
    ref.listen<OtpState>(
      otpNotifierProvider(params),
      (OtpState? previous, OtpState next) async {
        if (next.msg?.isNotEmpty ?? false) {
          displaySnackBar(next.msg ?? '', context);
          ref.read(otpNotifierProvider(params).notifier).clearMessage();
        }
        if (next.redirectRoute != null &&
            next.status == BaseStateStatus.success) {
          // Reset single-tap guard when showing dialog again
          _okHandled = false;
          // Capture the redirect route before showing dialog
          final PageRouteInfo capturedRedirectRoute = next.redirectRoute!;
          await showCustomDialogWithLottie(
            lottieAnimationFilePath: Assets.gif.icSuccessRight.path,
            "",
            barrierDismissible: false,
            title1: context.appString.successKey,
            title2: next.flowType == OtpFlowType.forgotPassword
                ? context.appString.otpVerifiedSuccessfullyKey
                : next.flowType == OtpFlowType.updateEmail
                ? context.appString.updateEmailVerifiedSuccessfullyKey
                : context.appString.accountMsgKey,
            title3: next.flowType == OtpFlowType.signup
                ? context.appString.otpSuccessMsgKey
                : "",
            titleStyle3: context.textTheme.titleLarge?.copyWith(
              color: MainConfig.appColors.creyColor,
              height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
              fontWeight: FontWeight.w400,
              fontSize: Dimens.fontSize12,
            ),
            okBtnTitle: context.appString.okayKey,
            isDialogHideOnClick: true,
            onOkClicked: () async {
              if (!context.mounted) {
                return;
              }
              if (_okHandled) {
                return;
              }
              _okHandled = true;
              // Prevent multiple rapid taps: if navigation already started, ignore further taps
              if (_navigationCompleter != null) {
                return;
              }
              _navigationCompleter = Completer<void>();
              try {
                await context.router.replaceAll(<PageRouteInfo>[
                  const SocialLoginRoute(),
                  capturedRedirectRoute,
                ]);
              } finally {
                _navigationCompleter?.complete();
                _navigationCompleter = null;
              }
            },
          );
        }
      },
    );

    final OtpState state = ref.watch(otpNotifierProvider(params));
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background SVG
          Positioned.fill(
            child: Assets.svgs.bgFullscreenCommon.svg(
              fit: BoxFit.fill,
            ),
          ),
          OtpPageWidget(
            email: email,
            prefix: prefix,
            redirectRoute: redirectRoute,
            params: params,
          ),
        ],
      ),
    );
  }
}
