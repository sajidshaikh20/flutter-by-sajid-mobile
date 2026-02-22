import '../../../../utils/exports.dart';

/// Section label for DMT form (e.g. "Transaction Type", "Select Bank").
class DmtFormSectionLabel extends StatelessWidget {
  const DmtFormSectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return CustomTextLabelWidget(
      label: label,
      style: context.textTheme.titleMedium?.copyWith(
        fontSize: Dimens.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
      ),
    );
  }
}
