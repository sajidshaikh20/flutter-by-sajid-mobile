import '../../../../utils/exports.dart';

/// A customizable widget for displaying a selectable item in a list.
class SelectionItemWidget extends StatelessWidget {
  /// The unique identifier of the item.
  final String itemId;

  /// The display name of the item.
  final String itemName;

  /// The URL of the flag image associated with the item (optional).
  final String? itemFlag;

  /// The currently selected item's ID.
  final String selectedIndex;

  /// A callback function triggered when the item is selected.
  final VoidCallback onSelect;

  /// Whether to display the flag image.
  final bool showFlag;
  /// The device type for styling the widget.
  final ScreenType device;
///
  const SelectionItemWidget({
    super.key,
    required this.itemId,
    required this.itemName,
    required this.selectedIndex,
    required this.onSelect,
    this.itemFlag,
    this.showFlag = false,
    this.device = ScreenType.mobile,
  });

  @override
  Widget build(BuildContext context) {
    double commonFontSize = Dimens.fontSize16;
    switch (device) {
      case ScreenType.mobile:
        break;
      case ScreenType.tablet:
        commonFontSize = Dimens.fontSize21;

      case ScreenType.desktop:
        commonFontSize = Dimens.fontSize21;

    }

    return Container(
      padding: EdgeInsets.all(device == ScreenType.mobile ? Dimens.space0 : Dimens.space4),
      margin: EdgeInsets.only(bottom: device == ScreenType.mobile ? Dimens.space15 : Dimens.space21),
      decoration: BoxDecorationExtension.customDecoration(
        border: Border.all(color: MainConfig.appColors.borderLightWhiteColor),
        borderRadius: Dimens.radius5.borderRadius,
      ),
      child: InkWell(
        onTap: onSelect,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.space2),
          leading: showFlag && itemFlag != null
              ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space8),
                  child: ClipRRect(
                    borderRadius: Dimens.space5.borderRadius,
                    child: CustomNetworkImageWidget(
                      imageUrl: itemFlag ?? '',
                      placeHolderImage: Assets.svgs.icPlaceHolderDukkan.svg(),
                      height: device == ScreenType.mobile ? Dimens.space40 : Dimens.space50,
                      width: device == ScreenType.mobile ? Dimens.space60 : Dimens.space70,
                    ),
                  ),
                )
              : null,
          title: Padding(
            padding: showFlag
                ?  Dimens.space0.padding
                : const EdgeInsets.symmetric(horizontal: Dimens.space8),
            child: CustomTextLabelWidget(
              textAlign: TextAlign.start,
              label: itemName,
              style: context.textTheme.headlineMedium?.copyWith(
                color: MainConfig.appColors.textBlackColor,
                fontSize: commonFontSize,
              ),
            ),
          ),
          trailing: Radio<String>(
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: itemId,
            groupValue: selectedIndex,
            onChanged: (String? value) {
              onSelect.call();
            },
          ),
        ),
      ),
    );
  }
}
