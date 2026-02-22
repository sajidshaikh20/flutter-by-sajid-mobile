import '../../../../utils/exports.dart';

/// User info subwidget (name + balance).
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
              label:
              balance != null
                  ? 'Available Balance $balance'
                  : 'Available Balance ₹2000.00',
              style: context.textTheme.labelSmall?.copyWith(
                color: MainConfig.appColors.textWhiteColor,
                fontSize: Dimens.fontSize10,
                fontWeight: FontWeight.w500,
              ),
            ),
            Dimens.space7.widthBox,
            Assets.svgs.icVisiblity.svg(),
          ],
        ),
      ],
    );
  }
}
