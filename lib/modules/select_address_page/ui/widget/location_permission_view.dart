import '../../../../utils/exports.dart';

/// Widget that displays location permission request view.
class LocationPermissionView extends StatelessWidget {
  /// Creates a location permission view widget.
  const LocationPermissionView({
    super.key,
    required this.onEnableLocationPressed,
  });

  /// Callback function called when the enable location button is pressed.
  final VoidCallback onEnableLocationPressed;

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
              // Location icon with map background
              Assets.svgs.icLocationMaps.svg(
                height: Dimens.size100,
                width: Dimens.size100,
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
                label: context.appString.enableLocationToViewNearestStoresKey,
              ),
              const SizedBox(height: Dimens.size22),
              // Enable Location button
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: Dimens.size50),
                child: CustomGradientButtonWidget(
                  title: context.appString.enableLocationKey,
                  onTap: onEnableLocationPressed,

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
