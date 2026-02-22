import '../../../../../utils/exports.dart';

/// Customer info card: white card with label-value rows and dividers.
class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    super.key,
    required this.mobileNumber,
    required this.availableLimit,
    required this.name,
    required this.sendUpTo,
  });

  final String mobileNumber;
  final String availableLimit;
  final String name;
  final String sendUpTo;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimens.radius10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.06),
            offset: const Offset(Dimens.space0, Dimens.space4),
            blurRadius: Dimens.blurRadius10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _InfoRow(label: 'Mobile Number', value: mobileNumber),
          const DottedDivider(indent: Dimens.space20, endIndent: Dimens.space20),
          _InfoRow(label: 'Available Limit', value: availableLimit),
          const DottedDivider(indent: Dimens.space20, endIndent: Dimens.space20),
          _InfoRow(label: 'Name', value: name, valueBold: true),
          const DottedDivider(indent: Dimens.space20, endIndent: Dimens.space20),
          _InfoRow(label: 'You Can Send Up To', value: sendUpTo),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.valueBold = false,
  });

  final String label;
  final String value;
  final bool valueBold;

  @override
  Widget build(BuildContext context) {
    final Color labelColor = MainConfig.appColors.textBlackColor.withOpacity(0.5);
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
              fontWeight:  FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
