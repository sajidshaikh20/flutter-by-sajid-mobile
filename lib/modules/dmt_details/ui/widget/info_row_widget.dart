import '../../../../../utils/exports.dart';

/// A single label-value row for info/transaction details cards.
/// Uses muted color for [label] and darker text for [value].
class InfoRowWidget extends StatelessWidget {
  const InfoRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.valueBold = false,
  });

  final String label;
  final String value;
  final bool valueBold;

  @override
  Widget build(BuildContext context) {
    final Color labelColor =
        MainConfig.appColors.textBlackColor.withValues(alpha: 0.5);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space10,
        vertical: Dimens.space12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomTextLabelWidget(
            label: label,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: Dimens.fontSize14,
              color: labelColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextLabelWidget(
            label: value,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: Dimens.fontSize14,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
