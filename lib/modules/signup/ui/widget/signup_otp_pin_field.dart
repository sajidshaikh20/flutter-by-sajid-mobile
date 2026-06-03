import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../../utils/exports.dart';

/// Themed [OtpPinField] for sign up verification.
class SignUpOtpPinField extends StatelessWidget {
  /// Creates [SignUpOtpPinField].
  const SignUpOtpPinField({
    super.key,
    required this.fieldKey,
    required this.onChanged,
    required this.onSubmit,
  });

  /// Key to clear OTP programmatically.
  final GlobalKey<OtpPinFieldState> fieldKey;

  /// OTP value changed callback.
  final ValueChanged<String> onChanged;

  /// OTP submit callback.
  final ValueChanged<String> onSubmit;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color borderInactive = isDark
        ? const Color(0xFF4A4560)
        : AppColors.borderLight;
    final Color borderActive = AppColors.primaryPurple;
    final Color textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color fillColor = isDark
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;

    return OtpPinField(
      key: fieldKey,
      maxLength: signUpOtpLength,
      cursorColor: AppColors.primaryPurple,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      otpPinFieldDecoration: OtpPinFieldDecoration.custom,
      otpPinFieldStyle: OtpPinFieldStyle(
        fieldBorderRadius: Dimens.radius12,
        fieldBorderWidth: Dimens.borderWidth1,
        defaultFieldBorderColor: borderInactive,
        activeFieldBorderColor: borderActive,
        filledFieldBorderColor: borderActive,
        defaultFieldBackgroundColor: fillColor,
        activeFieldBackgroundColor: fillColor,
        filledFieldBackgroundColor: fillColor,
        textStyle: context.textTheme.titleMedium?.copyWith(
          fontSize: Dimens.fontSize18,
          fontWeight: FontWeight.w700,
          color: textColor,
        ) ?? TextStyle(
          fontSize: Dimens.fontSize18,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        activeFieldBorderGradient: const LinearGradient(
          colors: signUpStepGradient,
        ),
        filledFieldBorderGradient: const LinearGradient(
          colors: signUpStepGradient,
        ),
      ),
      onChange: onChanged,
      onSubmit: onSubmit,
    );
  }
}
