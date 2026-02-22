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
        padding: EdgeInsets.symmetric(horizontal: Dimens.space20),
        child: Row(
          children: <Widget>[
            _buildProfileSection(context),
            const Spacer(),
            _buildNotificationButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildProfileImage(context),
        Dimens.space10.widthBox,
        _buildUserInfoColumn(context),
        Dimens.space8.widthBox,
        _buildBalanceIcon(context),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    final Color textColorValue =
        textColor ?? MainConfig.appColors.textWhiteColor;
    return Container(
      width: Dimens.size50,
      height: Dimens.size50,
      decoration: BoxDecoration(
        borderRadius: Dimens.radius24.borderRadius,
        color: MainConfig.appColors.imageBgColor,
      ),
      child: ClipRRect(
        borderRadius: Dimens.radius24.borderRadius,
        child: profileImagePath != null
            ? Image.asset(
                profileImagePath!,
                height: Dimens.size50,
                width: Dimens.size50,
                fit: BoxFit.cover,
              )
            : Icon(
                Icons.person,
                size: Dimens.size34,
                color: textColorValue,
              ),
      ),
    );
  }

  Widget _buildUserInfoColumn(BuildContext context) {
    final Color textColorValue =
        textColor ?? MainConfig.appColors.textWhiteColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomTextLabelWidget(
          label: userName != null ? 'Hi, $userName' : 'Hi, Wade Warren',
          textAlign: TextAlign.start,
          style: context.textTheme.headlineSmall?.copyWith(
            color: textColorValue,
            fontSize: Dimens.fontSize18,
            fontWeight: FontWeight.w700,
            height: Dimens.lineHeight22.toLineHeight(Dimens.fontSize18),
          ),
        ),
        CustomTextLabelWidget(
          label: balance != null
              ? 'Available Balance $balance'
              : 'Available Balance ₹2000.00',
          textAlign: TextAlign.start,
          style: context.textTheme.labelSmall?.copyWith(
            color: textColorValue.withValues(alpha: Dimens.opacity08),
            fontSize: Dimens.fontSize13,
            fontWeight: FontWeight.w400,
            height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize13),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceIcon(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimens.space8),
      child: Icon(
        Icons.edit_outlined,
        size: Dimens.size14,
        color: MainConfig.appColors.textWhiteColor
            .withValues(alpha: Dimens.opacity06),
      ),
    );
  }

  Widget _buildNotificationButton(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: MainConfig.appColors.textWhiteColor,
        ),
        borderRadius: Dimens.radius15.borderRadius,
      ),
      child: IconButton(
        onPressed: onNotificationTap ?? () {},
        constraints: BoxConstraints(
          minWidth: Dimens.size30,
          minHeight: Dimens.size30,
        ),
        icon: Icon(
          Icons.notifications_outlined,
          size: Dimens.size22,
          color: MainConfig.appColors.textWhiteColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimens.size50);
}
