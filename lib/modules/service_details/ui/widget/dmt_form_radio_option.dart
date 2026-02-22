import '../../../../utils/exports.dart';

/// Radio-style option: square checkbox + label. Selected = filled black with white check.
class DmtFormRadioOption extends StatelessWidget {
  const DmtFormRadioOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: <Widget>[
          Container(
            width: Dimens.size16,
            height: Dimens.size16,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.blackColor : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(Dimens.radius4),

            ),
            child: isSelected
                ? const Icon(
                    Icons.check,
                    size: Dimens.size14,
                    color: AppColors.whiteColor,
                  )
                : null,
          ),
Dimens.space12.widthBox,
          CustomTextLabelWidget(
            label: label,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
