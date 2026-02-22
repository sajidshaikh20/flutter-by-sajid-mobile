import '../../../../utils/exports.dart';

/// Notification icon button for the home app bar.
class HomeAppBarNotificationButton extends StatelessWidget {
  const HomeAppBarNotificationButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return HomeAppBarNotificationButtonBorder(
      child: HomeAppBarNotificationIconButton(onTap: onTap),
    );
  }
}
