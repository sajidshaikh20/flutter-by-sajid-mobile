import '../../../../utils/exports.dart';

/// AEPS form dropdown – UI only. Parent passes [value], [items], [onChanged].
class AepsFormDropdownField extends StatelessWidget {
  const AepsFormDropdownField({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.space52,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyBorder),
        borderRadius: BorderRadius.circular(Dimens.radius10),
        color: AppColors.whiteColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: CustomTextLabelWidget(
            label:
            hint,
            style: const TextStyle(
              color: AppColors.greyMediumColor,
              fontSize: Dimens.fontSize14,
            ),
          ),
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.greyDarkColor,
          ),
          items: items
              .map(
                (String item) => DropdownMenuItem<String>(
                  value: item,
                  child: CustomTextLabelWidget(
                    label:
                    item,
                    style: const TextStyle(
                      fontSize: Dimens.fontSize14,
                      color: AppColors.colorBlackBastille,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
