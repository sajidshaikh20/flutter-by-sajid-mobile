import '../../../../utils/exports.dart';

/// A custom radio button widget designed for various screen types.
class CustomRadioButtonWidget extends StatelessWidget {
  /// The value associated with this radio button.
  final dynamic value;

  /// The currently selected value of the group of radio buttons.
  final dynamic groupValue;

  /// A callback function triggered when this radio button is selected.
  final Function(dynamic) onChange;

  /// The label text displayed next to the radio button.
  final String? label;

  /// The style for the label text.
  final TextStyle? labelStyle;

  /// The border color for the radio button.
  final Color? borderColor;

  /// Determines if the radio button should be rendered in a dense format.
  final bool? isDense;

  /// The type of device screen (mobile, tablet, desktop) for responsive design.
  final ScreenType device;

  /// Creates a custom radio button widget.
  ///
  /// [value] - The value of this radio button.
  /// [groupValue] - The current group value.
  /// [onChange] - Callback when the radio button is selected.
  /// [label] - The label text.
  /// [labelStyle] - Style for the label.
  const CustomRadioButtonWidget(
      {super.key,
      required this.value,
      required this.groupValue,
      this.label = "",
      this.labelStyle,
      required this.onChange,
      this.borderColor,
      this.isDense,
      this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;
    double labelFontSize = Dimens.fontSize16;
    EdgeInsets contentPadding = const EdgeInsets.symmetric(horizontal: Dimens.space8);
    switch (device) {
      case ScreenType.mobile:
        break;
      case ScreenType.tablet:
        labelFontSize = Dimens.fontSize20;
        contentPadding = const EdgeInsets.symmetric(horizontal: Dimens.space12);
      case ScreenType.desktop:
        break;
    }
    return Column(
      children: <Widget>[
        CommonContainer(
          boxDecoration: BoxDecorationExtension.customDecoration(
              color: isSelected
                  ? MainConfig.appColors.backgroundExtraLightBlue // Use your desired red color
                  : MainConfig.appColors.backgroundWhiteColor,
              borderRadius: Dimens.space5.borderRadius,
              border: Dimens.borderWidth1.borderAll(
                color: MainConfig.appColors.dukkanborderGreyLightColor,
              )),
          childWidgets: ListTile(
            dense: isDense ?? false,
            selected: isSelected,
            contentPadding: contentPadding,
            tileColor: MainConfig.appColors.backgroundWhiteColor,
            shape: OutlineInputBorder(
              borderRadius: Dimens.radius5.borderRadius,
              borderSide: BorderSide(
                color: borderColor ?? MainConfig.appColors.borderLightWhiteColor,
              ),
            ),
            leading: Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected
                  ? MainConfig.appColors.iconDarkBlueColor
                  : MainConfig.appColors.iconLightGreyColor,
            ),
            title: CustomTextLabelWidget(
              label: label ?? "",
              textAlign: TextAlign.start,
              style: labelStyle ??
                  MainConfig.appStyle.textSemiBold.copyWith(
                    fontSize: labelFontSize,
                    color: isSelected
                        ? MainConfig.appColors.textMediumDarkBlueColor
                        : MainConfig.appColors.textColorGreyBlack,
                  ),
            ),
            onTap: () {
              onChange(value);
            },
          ),
        ),
        Dimens.space2.heightBox
      ],
    );
  }
}
