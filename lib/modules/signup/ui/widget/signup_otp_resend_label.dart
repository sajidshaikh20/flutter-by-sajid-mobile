import '../../../../utils/exports.dart';

/// Resend OTP label with 30s countdown, then tappable "Resend OTP" link.
class SignUpOtpResendLabel extends StatelessWidget {
  /// Creates [SignUpOtpResendLabel].
  const SignUpOtpResendLabel({
    super.key,
    required this.secondsRemaining,
    required this.onResend,
  });

  /// Seconds until resend is enabled (0 = tappable).
  final int secondsRemaining;

  /// Called when user taps resend after cooldown.
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final AppString strings = context.appString;
    final bool isDark = context.isDark;
    final Color baseColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final TextStyle baseStyle = context.textTheme.bodyMedium?.copyWith(
          color: baseColor,
          fontSize: Dimens.fontSize14,
          fontWeight: FontWeight.w400,
        ) ??
        TextStyle(color: baseColor, fontSize: Dimens.fontSize14);

    if (secondsRemaining > 0) {
      return Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: strings.signUpDidntReceiveOtpKey,
            style: baseStyle,
            children: <InlineSpan>[
              TextSpan(
                text: strings.signUpResendOtpCountdown(secondsRemaining),
                style: baseStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: CustomRichTextLabel(
        isSpaceNeeded: false,
        primaryLabel: strings.signUpDidntReceiveOtpKey,
        secondaryLabel: strings.signUpResendOtpKey,
        primaryStyle: baseStyle,
        secondaryStyle: baseStyle.copyWith(
          color: AppColors.primaryPurple,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryPurple,
        ),
        onTapSecondaryLabel: onResend,
      ),
    );
  }
}
