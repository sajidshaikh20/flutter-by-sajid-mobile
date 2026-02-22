import '../../../../utils/exports.dart';

/// Sub-widget: bordered container around the notification button.
class HomeAppBarNotificationButtonBorder extends StatelessWidget {
  const HomeAppBarNotificationButtonBorder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: MainConfig.appColors.textWhiteColor,
        ),
        borderRadius: Dimens.radius15.borderRadius,
      ),
      child: child,
    );
  }
}
