import '../../../../utils/exports.dart';

/// Wallet cards section displaying Postpaid, Prepaid and Payout wallets.
class WalletCardsWidget extends StatelessWidget {
  /// Creates a wallet cards widget.
  const WalletCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.space16,
        vertical: Dimens.space14,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: Dimens.radius16.borderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          _WalletItem(label: 'Postpaid Wallet', showView: false),
          _WalletItem(label: 'Prepaid Wallet', showView: true),
          _WalletItem(label: 'Payout Wallet', showView: true),
        ],
      ),
    );
  }
}

class _WalletItem extends StatelessWidget {
  const _WalletItem({
    required this.label,
    required this.showView,
  });

  final String label;
  final bool showView;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextLabelWidget(
          label: label,
          textAlign: TextAlign.start,
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: Dimens.fontSize11,
            color: MainConfig.appColors.textBlackColor
                .withValues(alpha: Dimens.opacity06),
          ),
        ),
        Dimens.space6.heightBox,
        Row(
          children: <Widget>[
            CustomTextLabelWidget(
              label: '₹****',
              textAlign: TextAlign.start,
              style: context.textTheme.headlineSmall?.copyWith(
                fontSize: Dimens.fontSize14,
                fontWeight: FontWeight.w700,
                color: MainConfig.appColors.textBlackColor
                    .withValues(alpha: Dimens.opacity08),
              ),
            ),
            Dimens.space4.widthBox,
            if (!showView)
              Icon(
                Icons.visibility_off,
                size: Dimens.size14,
                color: MainConfig.appColors.textBlackColor
                    .withValues(alpha: Dimens.opacity04),
              ),
            if (showView) _ViewButton(),
          ],
        ),
      ],
    );
  }
}

class _ViewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.space8,
        vertical: Dimens.space2,
      ),
      decoration: BoxDecoration(
        color: MainConfig.appColors.mainColor,
        borderRadius: Dimens.radius6.borderRadius,
      ),
      child: CustomTextLabelWidget(
        label: 'View',
        style: context.textTheme.labelMedium?.copyWith(
          color: MainConfig.appColors.textWhiteColor,
          fontSize: Dimens.fontSize11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
