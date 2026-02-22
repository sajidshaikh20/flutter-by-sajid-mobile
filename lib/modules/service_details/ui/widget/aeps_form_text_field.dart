import '../../../../utils/exports.dart';

/// AEPS form text field – UI only. Parent passes [controller] and callbacks.
class AepsFormTextField extends StatelessWidget {
  const AepsFormTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.maxLength,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.space52,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: const TextStyle(
          fontSize: Dimens.fontSize14,
          fontWeight: FontWeight.w500,
          color: AppColors.colorBlackBastille,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.blackColor.withValues(alpha: 0.5),
            fontSize: Dimens.fontSize14,
            fontWeight: FontWeight.w500,
          ),
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Dimens.space16,
            vertical: Dimens.space14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.radius10),
            borderSide: const BorderSide(color: AppColors.greyBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.radius10),
            borderSide: const BorderSide(
              color: AppColors.greenTextColor,
              width: Dimens.space1_5,
            ),
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
        ),
      ),
    );
  }
}
