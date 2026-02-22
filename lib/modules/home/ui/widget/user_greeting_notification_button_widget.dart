import '../../../../utils/exports.dart';

/// Notification button subwidget.
class UserGreetingNotificationButtonWidget extends StatelessWidget {
  const UserGreetingNotificationButtonWidget({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Assets.svgs.icNotification.svg(),
    );
  }
}
