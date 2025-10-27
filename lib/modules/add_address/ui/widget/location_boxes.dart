import '../../../../utils/exports.dart';

/// A widget that displays a location option with an icon and a label,
/// highlighting the selection state.
///
/// Typically used in lists or grids of selectable locations.
class LocationBoxes extends StatelessWidget {
  /// Creates a [LocationBoxes] widget.
  ///
  /// The [keyName] is a unique identifier for this location box.
  /// The [name] is the label text to display.
  /// The [image] is the SVG icon representing the location.
  /// The [isSelected] indicates whether this location is currently selected.
  /// The [device] parameter allows adjusting the layout/styling based on the device type,
  /// defaulting to [ScreenType.mobile].
  const LocationBoxes({
    super.key,
    required this.keyName,
    required this.name,
    required this.image,
    required this.isSelected,
    this.device = ScreenType.mobile,
  });

  /// Unique identifier for this location box.
  final String keyName;

  /// The label text of the location.
  final String name;

  /// The SVG icon representing the location.
  final SvgGenImage image;

  /// Whether this location box is selected.
  final bool isSelected;

  /// The type of device layout to adapt the widget's appearance.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double addressTypeFontSize = Dimens.fontSize16;
    double containerHeight =
        isLanguageAlignmentLTR ? Dimens.size58 : Dimens.size65;

    switch (device) {
      case ScreenType.tablet:
        addressTypeFontSize = Dimens.fontSize21;
        containerHeight =
            isLanguageAlignmentLTR ? Dimens.size60 : Dimens.size78;

      default:
        break;
    }

    // Set the background color based on the selection state
    Color backgroundColor =
        isSelected ? AppColors.whiteColor : AppColors.whiteColor;

    return InkWell(
      onTap: () {
        context.instance<AddressCubit>().setAddressType(keyName);
      },
      child: Container(
        height: containerHeight,
        decoration: BoxDecorationExtension.customDecoration(
          color: backgroundColor, // Set background color here
          border: Border.all(
            color: isSelected
                ? MainConfig.appColors.spanTextColor
                : MainConfig.appColors.borderGreyColor,
          ),
          borderRadius: Dimens.radius4.borderRadius,
        ),
        padding: const EdgeInsets.only(
          left: Dimens.space18,
          right: Dimens.space15,
          top: Dimens.space12,
          bottom: Dimens.space12,
        ),
        child: Row(
          children: <Widget>[
            image.svg(
              colorFilter: ColorFilter.mode(
                isSelected
                    ? MainConfig.appColors.mainColor
                    : MainConfig.appColors.backgroundGrey,
                BlendMode.srcIn,
              ),
            ),
            Expanded(
              child: CustomTextLabelWidget(
                maxLines: 2,
                label: name,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: addressTypeFontSize,
                  fontWeight: FontWeight.w400,
                  color: isSelected
                      ? MainConfig.appColors.spanTextColor
                      : MainConfig.appColors.textColorGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
