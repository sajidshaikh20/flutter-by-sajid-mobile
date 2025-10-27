import '../../../../utils/exports.dart';

/// A widget that displays when notification permission is not granted.
/// Similar to LocationPermissionView but for notification permissions.
class NotificationPermissionView extends StatelessWidget {
  /// Creates a notification permission view.
  const NotificationPermissionView({
    super.key,
    required this.onEnableNotificationPressed,
  });

  /// Callback function called when the enable notification button is pressed.
  final VoidCallback onEnableNotificationPressed;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: MainConfig.appColors.backgroundLightPinkColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Notification icon
              Icon(
                Icons.notifications_outlined,
                size: Dimens.size100,
                color: MainConfig.appColors.textBlackColor,
              ),
              const SizedBox(height: Dimens.size17),
              // Text message
              CustomTextLabelWidget(
                style: context.textTheme.titleMedium?.copyWith(
                  fontSize: Dimens.fontSize14,
                  fontWeight: FontWeight.w400,
                  color: MainConfig.appColors.textBlackColor,
                  height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                ),
                label: context.appString.enableNotificationToReceiveUpdatesKey,
              ),
              const SizedBox(height: Dimens.size22),
              // Enable Notification button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.size50),
                child: CustomGradientButtonWidget(
                  title: context.appString.enableNotificationKey,
                  onTap: onEnableNotificationPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
