import '../../../../utils/exports.dart';

/// Machine selector button (e.g. Morpho / Mantra) for AEPS form.
/// Pass [selectedColor], [unselectedColor], and [textColor] to override defaults.
class AepsMachineButton extends StatelessWidget {
  const AepsMachineButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.textColor,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;


  final Color? selectedColor;

  /// Background color when not selected. Defaults to [AppColors.greyLight].
  final Color? unselectedColor;

  /// Label text color. When null, defaults to [AppColors.whiteColor].
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isSelected
        ? (selectedColor ?? MainConfig.appColors.primaryDark)
        : (unselectedColor ?? AppColors.greyLight);
    final Color labelColor = textColor ?? AppColors.whiteColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: Dimens.space34,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(Dimens.radius10),
        ),
        alignment: Alignment.center,
        child: CustomTextLabelWidget(
          label: label,
          style: context.textTheme.headlineMedium?.copyWith(
            color: labelColor,
            fontWeight: FontWeight.w600,
            fontSize: Dimens.fontSize15,
          ),
        ),
      ),
    );
  }
}
