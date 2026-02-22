import '../../../../utils/exports.dart';

/// Wallet and fund transfer action grid with Self Transfer, Load Wallet, Top Up, Link Payment.
class WalletFundTransferWidget extends StatelessWidget {
  /// Creates a wallet fund transfer widget.
  const WalletFundTransferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Wallet And Fund Transfer',
          style: context.textTheme.headlineSmall?.copyWith(
            color: MainConfig.appColors.textWhiteColor,
            fontSize: Dimens.fontSize16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Dimens.space14.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            _TransferItem(
              icon: Icons.swap_horiz,
              label: 'Self\nTransfer',
            ),
            _TransferItem(
              icon: Icons.account_balance_wallet,
              label: 'Load\nWallet',
            ),
            _TransferItem(
              icon: Icons.arrow_circle_up_outlined,
              label: 'Top Up',
            ),
            _TransferItem(
              icon: Icons.link,
              label: 'Link\nPayment',
            ),
          ],
        ),
      ],
    );
  }
}

class _TransferItem extends StatelessWidget {
  const _TransferItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: Dimens.size68,
          height: Dimens.size68,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: Dimens.radius16.borderRadius,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.blackColor
                    .withValues(alpha: Dimens.opacity01),
                blurRadius: Dimens.blurRadius8,
                offset: const Offset(Dimens.offset0, Dimens.offset3),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: Dimens.size44,
              height: Dimens.size44,
              decoration: BoxDecoration(
                color: MainConfig.appColors.mainColor
                    .withValues(alpha: Dimens.ratio015),
                borderRadius: Dimens.radius10.borderRadius,
              ),
              child: Icon(
                icon,
                color: MainConfig.appColors.mainColor,
                size: Dimens.size26,
              ),
            ),
          ),
        ),
        Dimens.space8.heightBox,
        Text(
          label,
          textAlign: TextAlign.center,
          style: context.textTheme.labelMedium?.copyWith(
            color: MainConfig.appColors.textWhiteColor,
            fontSize: Dimens.fontSize12,
            fontWeight: FontWeight.w500,
            height: Dimens.fontHeight1_5,
          ),
        ),
      ],
    );
  }
}
