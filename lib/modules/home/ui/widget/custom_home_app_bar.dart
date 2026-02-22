import '../../../../utils/exports.dart';

/// Customizable app bar component for home screens.
///
/// Features:
/// - User profile image with circular border radius
/// - Greeting text with user name
/// - Available balance display
/// - Notification icon button
/// - Responsive design with Dimens
/// - Customizable colors and content
class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a custom home app bar.
  const CustomHomeAppBar({
    super.key,
    this.userName,
    this.balance,
    this.profileImagePath,
    this.onNotificationTap,
    this.backgroundColor,
    this.textColor,
  });

  /// User's display name for greeting.
  final String? userName;

  /// Available balance amount to display.
  final String? balance;

  /// Path to the user's profile image.
  final String? profileImagePath;

  /// Callback when notification icon is tapped.
  final VoidCallback? onNotificationTap;

  /// Background color of the app bar.
  final Color? backgroundColor;

  /// Color of the text elements.
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? MainConfig.appColors.transparent,
      elevation: Dimens.elevation0,
      automaticallyImplyLeading: false,
      toolbarHeight: Dimens.size50,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space20),
        child: Row(
          children: <Widget>[
            HomeAppBarProfileSection(
              userName: userName,
              balance: balance,
              profileImagePath: profileImagePath,
              textColor: textColor,
            ),
            const Spacer(),
            HomeAppBarNotificationButton(onTap: onNotificationTap),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Dimens.size50);
}
