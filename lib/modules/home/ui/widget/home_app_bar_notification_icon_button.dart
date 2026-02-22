import '../../../../utils/exports.dart';

/// Sub-widget: icon button with notification icon for the home app bar.
class HomeAppBarNotificationIconButton extends StatelessWidget {
  const HomeAppBarNotificationIconButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () {},
      constraints: const BoxConstraints(
        minWidth: Dimens.size30,
        minHeight: Dimens.size30,
      ),
      icon: Icon(
        Icons.notifications_outlined,
        size: Dimens.size22,
        color: MainConfig.appColors.textWhiteColor,
      ),
    );
  }
}
