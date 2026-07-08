import '../../../../utils/exports.dart';

class SignUpDropdownFieldWidget extends StatelessWidget {
  final String? value;
  final String placeholder;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const SignUpDropdownFieldWidget({
    super.key,
    required this.value,
    required this.placeholder,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    return DropdownButtonFormField<String>(
      value: value,
      hint: CustomTextLabelWidget(
        label: placeholder,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: Dimens.fontSize14,
        ),
      ),
      items: items.map((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: CustomTextLabelWidget(
            label: val,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: Dimens.fontSize14,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.size16,
          vertical: Dimens.size14,
        ),
        filled: true,
        fillColor: isDark ? AppColors.surfaceDark : AppColors.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.radius12),
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.radius12),
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.radius12),
          borderSide: const BorderSide(
            color: AppColors.primaryPurple,
            width: 1.5,
          ),
        ),
      ),
      dropdownColor: isDark ? AppColors.surfaceDark : Colors.white,
    );
  }
}
