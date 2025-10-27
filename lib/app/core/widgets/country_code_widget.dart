import '../../../../utils/exports.dart';

/// [CountryCodeWidget] is a stateless widget that allows you to select a country code.
///
/// The widget displays a country code picker and an arrow down icon.
/// It supports various customizations like showing the flag, drop-down button,
/// aligning the text to the left, read-only mode, and different screen types.
class CountryCodeWidget extends StatelessWidget {
  /// Creates a [CountryCodeWidget].
  const CountryCodeWidget({
    super.key,
    /// The initial country code selection.
    required this.initialSelection,
    /// The callback function that is called when the country code is changed.
    required this.onChanged,
    /// Whether to show the flag of the selected country.
    this.showFlagMain = false,
    /// Whether to show the drop-down button.
    this.showDropDownButton = false,
    /// Whether to align the text to the left.
    this.alignLeft = false,
    /// Whether the widget is read-only.
    this.isReadOnly,
    /// the type of device the app is running on
    ///
    /// [ScreenType.mobile] for mobile device
    /// [ScreenType.tablet] for tablet device
    /// [ScreenType.desktop] for desktop device
    this.device=ScreenType.mobile
  });

  /// The initial country code selection.
  final String initialSelection;
  /// The callback function that is called when the country code is changed.
  final Function(CountryCode) onChanged;
  /// Whether to show the flag of the selected country.
  final bool showFlagMain;
  /// Whether to show the drop-down button.
  final bool showDropDownButton;
  /// Whether to align the text to the left.
  final bool alignLeft;
  /// Whether the widget is read-only.
  ///
  /// default value is  if is null
  final bool? isReadOnly;
  /// the type of device the app is running on
  ///
  /// [ScreenType.mobile] for mobile device
  /// [ScreenType.tablet] for tablet device
  /// [ScreenType.desktop] for desktop device
  final ScreenType device;
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CountryCodePicker(
          onChanged: onChanged,
          initialSelection: initialSelection,
          showFlagMain: showFlagMain,
          barrierColor: MainConfig.appColors.shadowBlackColor,
          showDropDownButton: showDropDownButton,
          alignLeft: alignLeft,
          enabled: !(isReadOnly ?? false),
          builder: (CountryCode? countryCode) {
            return isLanguageAlignmentLTR
                ? CustomTextLabelWidget(
                    label: initialSelection.contains('+')
                        ? Bidi.enforceLtrInText(initialSelection)
                        : initialSelection,
                    style: _commonTextStyle(context),
                  )
                : Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomTextLabelWidget(
                      label: initialSelection.contains('+')
                          ? '${Bidi.enforceLtrInText(initialSelection.replaceAll('+', ''))}+' // Ensure '+' at the end
                          : initialSelection,
                      style: _commonTextStyle(context),
                      textAlign: TextAlign.end, // Align text to the right
                    ),
                  );
          },
        ),
        Assets.svgs.icArrowDown.svg(
            height: Dimens.size8,
            width: Dimens.size14,
            colorFilter: ColorFilter.mode(
              MainConfig.appColors.iconDarkBlueColor,
              BlendMode.srcIn,
            ),
           ),
      ],
    );
  }

  TextStyle _commonTextStyle(BuildContext context) {
    double   textFontSize=Dimens.fontSize16;
    switch(device){
      case ScreenType.mobile:
        break;
      case ScreenType.tablet:
        textFontSize=Dimens.fontSize22;

      case ScreenType.desktop:
        break;
    }
    return context.textTheme.headlineMedium?.copyWith(
          color: MainConfig.appColors.textPrimaryColor,
          fontSize:  textFontSize,
          fontWeight: FontWeight.w600,
          height: Dimens.fontHeight2_2,
        ) ??
        const TextStyle(); // Default to an empty TextStyle if it's null
  }
}
