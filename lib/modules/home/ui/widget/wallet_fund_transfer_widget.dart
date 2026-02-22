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
        CustomTextLabelWidget(
          label: 'Wallet And Fund Transfer',
          textAlign: TextAlign.start,
          style: context.textTheme.headlineSmall?.copyWith(
            color: MainConfig.appColors.textWhiteColor,
            fontSize: Dimens.fontSize16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Dimens.space16.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TransferItem(
              icon: Assets.svgs.icSelfTransfer.svg(),
              label: 'Self\nTransfer',
            ),
            TransferItem(
              icon: Assets.svgs.icLoadWallet.svg(),
              label: 'Load\nWallet',
            ),
            TransferItem(
              icon: Assets.svgs.icTopUp.svg(),
              label: 'Top Up',
            ),
            TransferItem(
              icon: Assets.svgs.icLinkPayment.svg(),
              label: 'Link\nPayment',
            ),
          ],
        ),
      ],
    );
  }
}
