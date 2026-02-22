import '../../../../../utils/exports.dart';


/// Single beneficiary card: name, bank/IFSC, account/status, delete icon, Send Money button.
class BeneficiaryCardWidget extends StatelessWidget {
  const BeneficiaryCardWidget({
    super.key,
    required this.beneficiary,
    this.onDelete,
    this.onSendMoney,
  });

  final BeneficiaryModel beneficiary;
  final VoidCallback? onDelete;
  final VoidCallback? onSendMoney;

  @override
  Widget build(BuildContext context) {
    final Color greyLabel = MainConfig.appColors.greyTextColor;
    final TextStyle? labelStyle = context.textTheme.bodySmall?.copyWith(
      color: greyLabel,
      fontSize: Dimens.fontSize12,
    );
    final TextStyle? valueStyle = context.textTheme.titleSmall?.copyWith(
      color: AppColors.blackColor,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSize14,
    );

    return Container(
      padding: const EdgeInsets.all(Dimens.space16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimens.radius12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.06),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // ── Top row: Name + Delete icon ──────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextLabelWidget(label: 'Name', style: labelStyle),
                    Dimens.space4.heightBox,
                    CustomTextLabelWidget(
                      label: beneficiary.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: valueStyle,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(Dimens.radius8),
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.space4),
                  child: Assets.svgs.icDelete.svg(),
                ),
              ),
            ],
          ),

          Dimens.space16.heightBox,

          // ── Row 1: Bank (left) | IFSC (right) ────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextLabelWidget(label: 'Bank', style: labelStyle),
                    Dimens.space4.heightBox,
                    CustomTextLabelWidget(
                      label: beneficiary.bank,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: valueStyle,
                    ),
                  ],
                ),
              ),
              Dimens.space16.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextLabelWidget(label: 'IFSC', style: labelStyle),
                    Dimens.space4.heightBox,
                    CustomTextLabelWidget(
                      label: beneficiary.ifsc,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: valueStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Dimens.space16.heightBox,

          // ── Row 2: Account (left) | Status (right) ───────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextLabelWidget(label: 'Account', style: labelStyle),
                    Dimens.space4.heightBox,
                    CustomTextLabelWidget(
                      label: beneficiary.accountNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: valueStyle,
                    ),
                  ],
                ),
              ),
              Dimens.space16.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextLabelWidget(label: 'Status', style: labelStyle),
                    Dimens.space4.heightBox,
                    StatusPillWidget(isActive: beneficiary.isActive),
                  ],
                ),
              ),
            ],
          ),

          Dimens.space20.heightBox,

          // ── Send Money button ─────────────────────────────────────────
          CustomButtonWidget(
            title: 'Send Money',
            onTap: onSendMoney ?? () {},
            backgroundColor: AppColors.blackColor,
            height: Dimens.space34,
            borderRadius: Dimens.radius50,
            isPrimaryButton: false,
            titleTextStyle: context.textTheme.titleMedium?.copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w500,
              fontSize: Dimens.fontSize14,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.isActive});

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
        horizontal: Dimens.space12,
        vertical: Dimens.space4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(Dimens.radius50),
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