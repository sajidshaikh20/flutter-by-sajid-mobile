import '../../../../../utils/exports.dart';

/// Pill-shaped label for Active (green) or Inactive (red) status.
class StatusPillWidget extends StatelessWidget {
  const StatusPillWidget({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isActive
        ? MainConfig.appColors.lightgreenBgColor
        : MainConfig.appColors.lightredBgColor;
    final Color textColor = isActive
        ? MainConfig.appColors.greenColor
        : MainConfig.appColors.redColor;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space6,
        vertical: Dimens.space4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(Dimens.radius5),
      ),
      child: CustomTextLabelWidget(
        label: isActive ? 'Active' : 'Inactive',
        style: context.textTheme.labelMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimens.fontSize12,
        ),
      ),
    );
  }
}
