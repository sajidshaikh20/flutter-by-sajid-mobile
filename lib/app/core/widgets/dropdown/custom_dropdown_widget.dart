import '../../../../utils/exports.dart';


/// A reusable dropdown widget with placeholder support and rich styling options.
///
/// Generic parameter [T] represents the item type. Provide [getLabel] to map
/// an item of type [T] to a display string.
class CustomDropDownWidget<T> extends StatelessWidget {
  /// The list of items to render as dropdown options.
  final List<T> items;
  /// Currently selected value. If null, the [placeholder] is shown.
  final T? value; // Nullable value to allow placeholder
  /// Callback invoked when the selection changes.
  final ValueChanged<T?> onChanged;
  /// Maps an item of type [T] to a user-visible label.
  final String Function(T)
      getLabel; // Function to get the label from generic type T
  /// Placeholder text displayed when [value] is null.
  final String? placeholder; // Placeholder value
  /// Whether the dropdown should take up the full horizontal space.
  final bool? isExpanded;
  /// Padding applied to the dropdown button.
  final EdgeInsetsGeometry? paddingDropDown;
  /// Text style for menu items in the opened dropdown.
  final TextStyle? dropDownMenuTextStyle;
  /// Text style for the placeholder label.
  final TextStyle? placeHolderTextStyle;
  /// Color of the dropdown arrow icon.
  final Color? dropDownIconColor;
  /// If true, disables interaction.
  final bool isDisabled;
  /// Device type for responsive sizing.
  final ScreenType device;


  /// Creates a [CustomDropDownWidget].
  const CustomDropDownWidget(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.getLabel,
      this.value, // Nullable value
      this.placeholder, // Nullable placeholder
      this.isExpanded,
      this.paddingDropDown,
      this.dropDownMenuTextStyle,
      this.isDisabled = false,
        this.placeHolderTextStyle,this.dropDownIconColor, this.device =ScreenType.mobile});

  @override
  /// Builds the dropdown button with placeholder and custom styles.
  Widget build(BuildContext context) {
    double qtyFontSize=Dimens.fontSize18;
    double iconSize=Dimens.size24;
    double dropDownPaddingRight=Dimens.space13;
    switch(device){
      case ScreenType.tablet:
        qtyFontSize=Dimens.fontSize22;
        iconSize=Dimens.size30;
        dropDownPaddingRight=Dimens.space19;
     default:
       break;
    }
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        child: Theme(
          data: Theme.of(context).copyWith(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
          child: DropdownButton<T>(

            padding:
                paddingDropDown ??  EdgeInsets.only(right: dropDownPaddingRight),
            value: value,
            // Null value when no selection
            hint: CustomTextLabelWidget(
              label: placeholder ?? '',
              style: placeHolderTextStyle?? context.textTheme.headlineMedium?.copyWith(
                  fontSize: qtyFontSize,
                  fontWeight: FontWeight.w600,
                  color: MainConfig.appColors.textColorGreyBlack,
                  ),
            ),
            // Show placeholder when value is null
            isExpanded: isExpanded ?? true,
            icon: Padding(
              padding: const EdgeInsets.only(top: Dimens.space4,bottom: Dimens.space2,left: Dimens.space2),
              child: Assets.svgs.icArrowDown.svg(
                  colorFilter: ColorFilter.mode(
                    dropDownIconColor ??    MainConfig.appColors.mainColor, // The color you want to apply
                    BlendMode.srcIn, // Use srcIn to replace the original color
                  )),
            ),

            iconSize: iconSize,
            isDense: true,
            alignment: isLanguageAlignmentLTR ? Alignment.centerLeft :Alignment.centerRight,

            dropdownColor: Colors.white,
            onChanged: isDisabled ? onChanged :null,
            // Trigger selection change
            items: items.map<DropdownMenuItem<T>>((T item) {
              return DropdownMenuItem<T>(

                value: item,
                child: CustomTextLabelWidget(
                  maxLines: Dimens.maxLines01,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  label: getLabel(item),
                  style: dropDownMenuTextStyle ??
                      context.textTheme.headlineMedium?.copyWith(
                        fontSize: qtyFontSize,
                        fontWeight: FontWeight.w600,
                          color: MainConfig.appColors.textColorGreyBlack,
                         ),

                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}