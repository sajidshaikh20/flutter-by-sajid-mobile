import '../../../../utils/exports.dart';

/// User greeting and available balance text column for the home app bar.
class HomeAppBarUserInfoColumn extends StatelessWidget {
  const HomeAppBarUserInfoColumn({
    super.key,
    this.userName,
    this.balance,
    this.textColor,
  });

  final String? userName;
  final String? balance;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final Color color =
        textColor ?? MainConfig.appColors.textWhiteColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _GreetingLabel(userName: userName, color: color),
        _BalanceLabel(balance: balance, color: color),
      ],
    );
  }
}

/// Sub-widget: "Hi, {userName}" greeting text.
class _GreetingLabel extends StatelessWidget {
  const _GreetingLabel({required this.userName, required this.color});

  final String? userName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomTextLabelWidget(
      label: userName != null ? 'Hi, $userName' : 'Hi, Wade Warren',
      textAlign: TextAlign.start,
      style: context.textTheme.headlineSmall?.copyWith(
        color: color,
        fontSize: Dimens.fontSize18,
        fontWeight: FontWeight.w700,
        height: Dimens.lineHeight22.toLineHeight(Dimens.fontSize18),
      ),
    );
  }
}

/// Sub-widget: "Available Balance {balance}" text.
class _BalanceLabel extends StatelessWidget {
  const _BalanceLabel({required this.balance, required this.color});

  final String? balance;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomTextLabelWidget(
      label: balance != null
          ? 'Available Balance $balance'
          : 'Available Balance ₹2000.00',
      textAlign: TextAlign.start,
      style: context.textTheme.labelSmall?.copyWith(
        color: color.withValues(alpha: Dimens.opacity08),
        fontSize: Dimens.fontSize13,
        fontWeight: FontWeight.w400,
        height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize13),
      ),
    );
  }
}
