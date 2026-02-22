import '../../../../utils/exports.dart';

/// Wallet cards section displaying Postpaid, Prepaid and Payout wallets.
class WalletCardsWidget extends StatelessWidget {
  /// Creates a wallet cards widget.
  const WalletCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: Dimens.radius16.borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: Dimens.opacity02),
            blurRadius: Dimens.blurRadius10,
            offset: const Offset(Dimens.offset0, Dimens.offset4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: Dimens.radius16.borderRadius,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (HomeState p, HomeState c) =>
                      p.isPostpaidVisible != c.isPostpaidVisible,
                  builder: (BuildContext context, HomeState state) {
                    return WalletItemWidget(
                      title: 'Postpaid Wallet',
                      showViewButton: false,
                      isVisible: state.isPostpaidVisible,
                      onToggle: () =>
                          context.read<HomeCubit>().togglePostpaidVisibility(),
                    );
                  },
                ),
              ),
              _verticalDivider(),
              const Expanded(
                child: WalletItemWidget(
                  title: 'Prepaid Wallet',
                  showViewButton: true,
                  isVisible: false,
                ),
              ),
              _verticalDivider(),
              const Expanded(
                child: WalletItemWidget(
                  title: 'Payout Wallet',
                  showViewButton: true,
                  isVisible: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: Dimens.borderWidth1,
      color: AppColors.greyBorder,
    );
  }
}
