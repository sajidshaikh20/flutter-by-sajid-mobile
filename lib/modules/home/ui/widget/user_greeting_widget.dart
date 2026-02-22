import '../../../../utils/exports.dart';

/// User greeting section with avatar, name, balance and notification icon.
class UserGreetingWidget extends StatelessWidget {
  /// Creates a user greeting widget.
  const UserGreetingWidget({
    super.key,
    this.userName,
    this.balance,
    this.profileImagePath,
    this.onNotificationTap,
  });

  /// User's display name.
  final String? userName;

  /// Available balance to display.
  final String? balance;

  /// Path to profile image.
  final String? profileImagePath;

  /// Callback when notification icon is tapped.
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildAvatar(context),
        Dimens.space12.widthBox,
        Expanded(
          child: _buildUserInfo(context),
        ),
        _buildNotificationButton(context),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      width: Dimens.size56,
      height: Dimens.size56,
      decoration: BoxDecoration(
        color: MainConfig.appColors.imageBgColor,
        shape: BoxShape.circle,
      ),
      child: profileImagePath != null
          ? ClipOval(
              child: Image.asset(
                profileImagePath!,
                width: Dimens.size56,
                height: Dimens.size56,
                fit: BoxFit.cover,
              ),
            )
          : Icon(
              Icons.person,
              size: Dimens.size34,
              color: MainConfig.appColors.textWhiteColor,
            ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          userName != null ? 'Hi, $userName' : 'Hi, Wade Warren',
          style: context.textTheme.headlineSmall?.copyWith(
            color: MainConfig.appColors.textWhiteColor,
            fontSize: Dimens.fontSize18,
            fontWeight: FontWeight.w700,
            height: Dimens.lineHeight22.toLineHeight(Dimens.fontSize18),
          ),
        ),
        Dimens.space4.heightBox,
        Row(
          children: <Widget>[
            Text(
              balance != null
                  ? 'Available Balance $balance'
                  : 'Available Balance ₹2000.00',
              style: context.textTheme.labelSmall?.copyWith(
                color: MainConfig.appColors.textWhiteColor
                    .withValues(alpha: Dimens.opacity08),
                fontSize: Dimens.fontSize13,
                fontWeight: FontWeight.w400,
              ),
            ),
            Dimens.space6.widthBox,
            Icon(
              Icons.visibility_off,
              color: MainConfig.appColors.textWhiteColor
                  .withValues(alpha: Dimens.opacity06),
              size: Dimens.size16,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MainConfig.appColors.textWhiteColor
            .withValues(alpha: Dimens.opacity025),
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(Dimens.space8),
      child: Icon(
        Icons.notifications_outlined,
        color: MainConfig.appColors.textWhiteColor,
        size: Dimens.size22,
      ),
    );
  }
}
