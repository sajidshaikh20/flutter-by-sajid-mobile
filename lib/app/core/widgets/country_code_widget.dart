import '../../../../utils/exports.dart';

/// Country code picker with dial code display and themed bottom sheet.
class CountryCodeWidget extends StatefulWidget {
  /// Creates [CountryCodeWidget].
  const CountryCodeWidget({
    super.key,
    required this.countryIsoCode,
    required this.dialCode,
    required this.onChanged,
    this.showFlagMain = true,
    this.alignLeft = false,
    this.isReadOnly,
    this.device = ScreenType.mobile,
    this.favorite = const <String>['+91', '+965', '+971', '+1', '+44'],
  });

  /// ISO country code e.g. `IN`, `KW`.
  final String countryIsoCode;

  /// Dial code e.g. `+91`.
  final String dialCode;

  /// Called when user selects a country.
  final ValueChanged<CountryCode> onChanged;

  /// Whether to show the flag of the selected country.
  final bool showFlagMain;

  /// Whether to align the text to the left.
  final bool alignLeft;

  /// When true, picker is disabled.
  final bool? isReadOnly;

  /// Device type for text sizing.
  final ScreenType device;

  /// Favorite dial codes shown at top of picker list.
  final List<String> favorite;

  @override
  State<CountryCodeWidget> createState() => _CountryCodeWidgetState();
}

class _CountryCodeWidgetState extends State<CountryCodeWidget> {
  CountryCode? _selectedCountry;
  List<CountryCode>? _countries;
  List<CountryCode>? _favoriteCountries;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _countries = loadLocalizedCountryCodes(context);
    _favoriteCountries = resolveFavoriteCountries(
      countries: _countries!,
      favoriteDialCodes: widget.favorite,
    );
    _syncSelectedCountry(force: _selectedCountry == null);
  }

  @override
  void didUpdateWidget(covariant CountryCodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countryIsoCode != widget.countryIsoCode ||
        oldWidget.dialCode != widget.dialCode) {
      _syncSelectedCountry(force: true);
    }
  }

  void _syncSelectedCountry({required bool force}) {
    final List<CountryCode> countries = _countries ?? <CountryCode>[];
    if (countries.isEmpty) {
      return;
    }

    final CountryCode? match = findCountryBySelection(
      countries: countries,
      selection: widget.countryIsoCode,
    );

    if (force || match != null) {
      _selectedCountry = match ?? countries.first;
    }
  }

  Future<void> _openPicker() async {
    if (widget.isReadOnly ?? false) {
      return;
    }

    final List<CountryCode> countries =
        _countries ?? loadLocalizedCountryCodes(context);
    final List<CountryCode> favorites = _favoriteCountries ??
        resolveFavoriteCountries(
          countries: countries,
          favoriteDialCodes: widget.favorite,
        );

    final CountryCode? picked = await showThemedCountryCodePicker(
      context: context,
      countries: countries,
      favoriteCountries: favorites,
    );

    if (picked == null || !mounted) {
      return;
    }

    setState(() {
      _selectedCountry = picked;
    });
    widget.onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color iconColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final CountryCode? country = _selectedCountry;
    final String displayDialCode = country?.dialCode ?? widget.dialCode;

    return InkWell(
      onTap: _openPicker,
      borderRadius: BorderRadius.circular(Dimens.radius8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.size8,
          horizontal: Dimens.size4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.showFlagMain &&
                country?.flagUri != null &&
                country!.flagUri!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: Dimens.size6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.radius2),
                  child: Image.asset(
                    country.flagUri!,
                    width: Dimens.size24,
                    height: Dimens.size18,
                    package: 'country_code_picker',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomTextLabelWidget(
                label: Bidi.enforceLtrInText(displayDialCode),
                style: _commonTextStyle(context),
              ),
            ),
            Dimens.size4.widthBox,
            Assets.svgs.icArrowDown.svg(
              height: Dimens.size8,
              width: Dimens.size14,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _commonTextStyle(BuildContext context) {
    double textFontSize = Dimens.fontSize16;
    if (widget.device == ScreenType.tablet) {
      textFontSize = Dimens.fontSize22;
    }
    return context.textTheme.headlineMedium?.copyWith(
          color: MainConfig.appColors.textPrimaryColor,
          fontSize: textFontSize,
          fontWeight: FontWeight.w600,
          height: Dimens.fontHeight2_2,
        ) ??
        const TextStyle();
  }
}
