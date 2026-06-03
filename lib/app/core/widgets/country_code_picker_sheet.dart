import '../../../utils/exports.dart';

/// Opens a themed country picker bottom sheet aligned with app design.
Future<CountryCode?> showThemedCountryCodePicker({
  required BuildContext context,
  required List<CountryCode> countries,
  required List<CountryCode> favoriteCountries,
}) {
  final bool isDark = context.isDark;

  return showModalBottomSheet<CountryCode>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: MainConfig.appColors.shadowBlackColor,
    builder: (BuildContext sheetContext) {
      return _ThemedCountryCodePickerSheet(
        countries: countries,
        favoriteCountries: favoriteCountries,
        isDark: isDark,
      );
    },
  );
}

class _ThemedCountryCodePickerSheet extends StatefulWidget {
  const _ThemedCountryCodePickerSheet({
    required this.countries,
    required this.favoriteCountries,
    required this.isDark,
  });

  final List<CountryCode> countries;
  final List<CountryCode> favoriteCountries;
  final bool isDark;

  @override
  State<_ThemedCountryCodePickerSheet> createState() =>
      _ThemedCountryCodePickerSheetState();
}

class _ThemedCountryCodePickerSheetState
    extends State<_ThemedCountryCodePickerSheet> {
  late List<CountryCode> _filteredCountries;

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
  }

  void _filterCountries(String query) {
    final String normalized = query.trim().toUpperCase();
    setState(() {
      if (normalized.isEmpty) {
        _filteredCountries = widget.countries;
        return;
      }
      _filteredCountries = widget.countries
          .where(
            (CountryCode country) =>
                (country.code ?? '').toUpperCase().contains(normalized) ||
                (country.dialCode ?? '').contains(normalized) ||
                (country.name ?? '').toUpperCase().contains(normalized),
          )
          .toList();
    });
  }

  Color get _surfaceColor =>
      widget.isDark ? AppColors.surfaceDark : AppColors.surfaceLight;

  Color get _primaryTextColor => widget.isDark
      ? AppColors.textPrimaryDark
      : AppColors.textPrimaryLight;

  Color get _secondaryTextColor => widget.isDark
      ? AppColors.textSecondaryDark
      : AppColors.textSecondaryLight;

  Color get _borderColor =>
      widget.isDark ? AppColors.borderDark : AppColors.borderLight;

  Color get _searchFillColor =>
      widget.isDark ? AppColors.backgroundDark : AppColors.whiteColor;

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final double sheetHeight = MediaQuery.of(context).size.height * 0.85;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _surfaceColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius24),
              topRight: Radius.circular(Dimens.radius24),
            ),
            border: Border.all(
              color: widget.isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.05),
            ),
          ),
          child: SizedBox(
            height: sheetHeight,
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildHeader(context),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      Dimens.size16,
                      Dimens.size8,
                      Dimens.size16,
                      Dimens.size12,
                    ),
                    child: _buildSearchField(context),
                  ),
                  Expanded(
                    child: _filteredCountries.isEmpty
                        ? _buildEmptyState(context)
                        : ListView(
                            padding: const EdgeInsets.only(
                              bottom: Dimens.size16,
                            ),
                            children: <Widget>[
                              if (widget.favoriteCountries.isNotEmpty &&
                                  _filteredCountries.length ==
                                      widget.countries.length) ...<Widget>[
                                ...widget.favoriteCountries.map(
                                  (CountryCode country) =>
                                      _buildCountryTile(country),
                                ),
                                Divider(
                                  height: Dimens.size24,
                                  thickness: Dimens.borderWidth1,
                                  color: widget.isDark
                                      ? AppColors.dividerDark
                                      : AppColors.dividerLight,
                                  indent: Dimens.size16,
                                  endIndent: Dimens.size16,
                                ),
                              ],
                              ..._filteredCountries.map(
                                (CountryCode country) =>
                                    _buildCountryTile(country),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.size16,
        Dimens.size12,
        Dimens.size8,
        Dimens.size4,
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: Dimens.size48,
              height: Dimens.size4,
              decoration: BoxDecoration(
                color: widget.isDark ? Colors.white24 : Colors.black26,
                borderRadius: BorderRadius.circular(Dimens.radius2),
              ),
            ),
          ),
          Dimens.size16.heightBox,
          Row(
            children: <Widget>[
              Expanded(
                child: CustomTextLabelWidget(
                  label: context.appString.signUpSelectCountryKey,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: _primaryTextColor,
                    fontSize: Dimens.fontSize18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close_rounded,
                  color: _secondaryTextColor,
                  size: Dimens.size22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      onChanged: _filterCountries,
      style: context.textTheme.titleMedium?.copyWith(
        color: _primaryTextColor,
        fontSize: Dimens.fontSize16,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: widget.isDark ? Colors.white : Colors.black,
      decoration: InputDecoration(
        hintText: context.appString.signUpSearchCountryKey,
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          color: _secondaryTextColor,
          fontSize: Dimens.fontSize16,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: _searchFillColor,
        prefixIcon: Icon(
          Icons.search_rounded,
          color: _secondaryTextColor,
          size: Dimens.size22,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: Dimens.size14,
          horizontal: Dimens.size12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.size10),
          borderSide: BorderSide(
            color: _borderColor,
            width: Dimens.borderWidth05,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.size10),
          borderSide: const BorderSide(
            color: AppColors.primaryPurple,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.size10),
          borderSide: BorderSide(
            color: _borderColor,
            width: Dimens.borderWidth05,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: CustomTextLabelWidget(
        label: context.appString.signUpNoCountryFoundKey,
        style: context.textTheme.bodyMedium?.copyWith(
          color: _secondaryTextColor,
          fontSize: Dimens.fontSize14,
        ),
      ),
    );
  }

  Widget _buildCountryTile(CountryCode country) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(country),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.size16,
            vertical: Dimens.size12,
          ),
          child: Row(
            children: <Widget>[
              if (country.flagUri != null && country.flagUri!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.radius2),
                  child: Image.asset(
                    country.flagUri!,
                    width: Dimens.size32,
                    height: Dimens.size24,
                    package: 'country_code_picker',
                    fit: BoxFit.cover,
                  ),
                ),
              Dimens.size12.widthBox,
              Expanded(
                child: CustomTextLabelWidget(
                  label: country.toLongString(),
                  style: context.textTheme.titleMedium?.copyWith(
                    color: _primaryTextColor,
                    fontSize: Dimens.fontSize15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Loads localized country codes for the picker.
List<CountryCode> loadLocalizedCountryCodes(BuildContext context) {
  return codes
      .map((Map<String, String> json) => CountryCode.fromJson(json))
      .map((CountryCode country) => country.localize(context))
      .toList();
}

/// Resolves favorite countries from dial codes.
List<CountryCode> resolveFavoriteCountries({
  required List<CountryCode> countries,
  required List<String> favoriteDialCodes,
}) {
  return countries
      .where(
        (CountryCode country) =>
            favoriteDialCodes.firstWhereOrNull(
              (String criteria) =>
                  country.code?.toUpperCase() == criteria.toUpperCase() ||
                  country.dialCode == criteria ||
                  country.name?.toUpperCase() == criteria.toUpperCase(),
            ) !=
            null,
      )
      .toList();
}

/// Finds a country by ISO code, dial code, or name.
CountryCode? findCountryBySelection({
  required List<CountryCode> countries,
  required String selection,
}) {
  if (selection.isEmpty) {
    return null;
  }
  return countries.firstWhereOrNull(
    (CountryCode country) =>
        country.code?.toUpperCase() == selection.toUpperCase() ||
        country.dialCode == selection ||
        country.name?.toUpperCase() == selection.toUpperCase(),
  );
}
