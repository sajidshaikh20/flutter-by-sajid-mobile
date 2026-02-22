import '../../../../utils/exports.dart';

/// Wallet cards section displaying Postpaid, Prepaid and Payout wallets.
class WalletCardsWidget extends StatelessWidget {
  /// Creates a wallet cards widget.
  const WalletCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space20,
        vertical: Dimens.space14,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: Dimens.radius6.borderRadius,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  <Widget>[
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
            fontSize: Dimens.fontSize10,
            fontWeight: FontWeight.w400,
            color: MainConfig.appColors.textBlackColor
          ),
        ),
        Dimens.space7.heightBox,
        Row(
          children: <Widget>[
            CustomTextLabelWidget(
              label: '₹****',
              textAlign: TextAlign.start,
              style: context.textTheme.headlineSmall?.copyWith(
                fontSize: Dimens.fontSize14,
                fontWeight: FontWeight.w600,
                color: MainConfig.appColors.textBlackColor
              ),
            ),
            Dimens.space12.widthBox,
            if (!showView)
              Assets.svgs.icVisibilityPrimary.svg(),
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
      padding: const EdgeInsets.all(
      Dimens.space5,
      ),
      decoration: BoxDecoration(
       border: Border.all(
         color: MainConfig.appColors.primary,
         width: Dimens.borderWidth05
       ),
        borderRadius: Dimens.radius6.borderRadius,
      ),
      child: CustomTextLabelWidget(
        label: 'View',
        style: context.textTheme.labelMedium?.copyWith(
          color: MainConfig.appColors.primary,
          fontSize: Dimens.fontSize7,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
