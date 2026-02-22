import '../../../../utils/exports.dart';

/// User info subwidget (name + balance with visibility toggle).
class UserGreetingInfoWidget extends StatelessWidget {
  const UserGreetingInfoWidget({
    super.key,
    this.userName,
    this.balance,
  });

  final String? userName;
  final String? balance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (HomeState previous, HomeState current) =>
          previous.isBalanceVisible != current.isBalanceVisible,
      builder: (BuildContext context, HomeState state) {
        final String balanceText = balance != null
            ? 'Available Balance $balance'
            : 'Available Balance ₹2000.00';
        final String displayBalance =
            state.isBalanceVisible ? balanceText : 'Available Balance ₹****';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTextLabelWidget(
              label: userName != null ? 'Hi, $userName' : 'Hi, Wade Warren',
              textAlign: TextAlign.start,
              style: context.textTheme.headlineSmall?.copyWith(
                color: MainConfig.appColors.textWhiteColor,
                fontSize: Dimens.fontSize14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: <Widget>[
                CustomTextLabelWidget(
                  label: displayBalance,
                  textAlign: TextAlign.start,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: MainConfig.appColors.textWhiteColor,
                    fontSize: Dimens.fontSize10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Dimens.space7.widthBox,
                GestureDetector(
                  onTap: () => context.read<HomeCubit>().toggleBalanceVisibility(),
                  child: state.isBalanceVisible
                      ? Assets.svgs.icVisiblity.svg(
                          colorFilter: ColorFilter.mode(
                            MainConfig.appColors.textWhiteColor,
                            BlendMode.srcIn,
                          ),
                        )
                      : Icon(
                          Icons.visibility_off,
                          size: Dimens.size16,
                          color: MainConfig.appColors.textWhiteColor
                              .withValues(alpha: Dimens.opacity08),
                        ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
