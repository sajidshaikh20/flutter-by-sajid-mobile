import '../../../../utils/exports.dart';

/// Builds a notification section with title and toggle switch.
Widget buildNotificationSection({
  required String title,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.size8,
                  right: Dimens.size12,
                  top: Dimens.size16,
                  bottom: Dimens.size16),
              child: CustomTextLabelWidget(
                label: title,
                textAlign: TextAlign.start,
                style: MainConfig.context.textTheme.titleLarge?.copyWith(
                  height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                  fontWeight: FontWeight.w600,
                  color: MainConfig.appColors.textBlackColor,
                  fontSize: Dimens.fontSize14,
                ),
              ),
            ),
          ],
        ),
      ),
      // Switch Widget aligned to the right
      Padding(
        padding: const EdgeInsets.only(
            right: Dimens.size8, top: Dimens.size10, left: Dimens.size8),
        child: AdvancedSwitch(
          width: Dimens.size58,
          activeColor: MainConfig.appColors.backgroundWhite,
          inactiveColor: MainConfig.appColors.backgroundGrey,
          inactiveImage: !MainConfig.context.isEnglishLanguage
              ? AssetImage(Assets.png.icSwitchImageOff.path)
              : AssetImage(Assets.png.icSwitchImageOff.path),
          activeImage: !MainConfig.context.isEnglishLanguage
              ? AssetImage(Assets.png.icSwitchImageOn.path)
              : AssetImage(Assets.png.icSwitchImageOn.path),
          initialValue: value, // ✅ Set initial value from NotificationSettingInitial state
          onChanged: (dynamic value) {
            onChanged(value as bool);
          },
          // Replace with your SVG asset if necessary
          // inactiveThumbImage:
          //     Assets.image.ic_switch_image_off, // SVG for inactive state
        ),
      ),
    ],
  );
}
