import '../../../../../utils/exports.dart';

/// Single circular digit field for OTP input.
class OtpDigitField extends StatelessWidget {
  const OtpDigitField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.size48,
      height: Dimens.size48,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
          fontSize: Dimens.fontSize18,
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.radius24),
            borderSide: const BorderSide(color: AppColors.greyBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.radius24),
            borderSide: const BorderSide(color: AppColors.greyBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.radius24),
            borderSide: const BorderSide(
              color: AppColors.greenTextColor,
              width: Dimens.space1_5,
            ),
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
