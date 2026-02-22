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
        UserGreetingAvatarWidget(profileImagePath: profileImagePath),
        Dimens.space10.widthBox,
        Expanded(
          child: UserGreetingInfoWidget(userName: userName, balance: balance),
        ),
        UserGreetingNotificationButtonWidget(onTap: onNotificationTap),
      ],
    );
  }
}
