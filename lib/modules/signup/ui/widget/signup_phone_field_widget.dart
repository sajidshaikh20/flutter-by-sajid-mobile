import '../../../../utils/exports.dart';

/// Mobile number field with integrated country code picker for sign up.
///
/// Styled to match [CommonTextFormFieldWidget] without affecting other forms.
class SignUpPhoneFieldWidget extends StatefulWidget {
  /// Creates [SignUpPhoneFieldWidget].
  const SignUpPhoneFieldWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.errorMsg,
    required this.countryIsoCode,
    required this.dialCode,
    required this.onCountryChanged,
    this.onChanged,
    this.textInputAction,
  });

  /// Phone digits controller (without country code).
  final TextEditingController controller;

  /// Focus node for the number input.
  final FocusNode focusNode;

  /// Field label.
  final String label;

  /// Validation error message.
  final String errorMsg;

  /// ISO country code for picker e.g. `IN`.
  final String countryIsoCode;

  /// Selected dial code e.g. `+91`.
  final String dialCode;

  /// Country picker callback.
  final ValueChanged<CountryCode> onCountryChanged;

  /// Number text changed callback.
  final ValueChanged<String>? onChanged;

  /// Keyboard action.
  final TextInputAction? textInputAction;

  @override
  State<SignUpPhoneFieldWidget> createState() => _SignUpPhoneFieldWidgetState();
}

class _SignUpPhoneFieldWidgetState extends State<SignUpPhoneFieldWidget> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  bool get _hasText => widget.controller.text.isNotEmpty;

  bool get _hasError => widget.errorMsg.isNotEmpty;

  bool get _isFocused => widget.focusNode.hasFocus;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final bool showFloatingLabel = _isFocused || _hasText;

    final Color fillColor =
        isDark ? AppColors.surfaceDark : AppColors.whiteColor;
    final Color labelColor = _hasError
        ? AppColors.errorColor
        : _isFocused
        ? AppColors.primaryPurple
        : (isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight);
    final Color borderColor = _hasError
        ? AppColors.errorColor
        : _isFocused
        ? AppColors.primaryPurple
        : (isDark
              ? AppColors.whiteColor
              : MainConfig.appColors.dukkanborderGreyLightColor);
    final Color textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          constraints: const BoxConstraints(minHeight: Dimens.size58),
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size8),
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(
              color: borderColor,
              width: Dimens.borderWidth05,
            ),
            borderRadius: BorderRadius.circular(Dimens.size10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (showFloatingLabel)
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimens.size8,
                    left: Dimens.size4,
                  ),
                  child: CustomTextLabelWidget(
                    label: widget.label,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: labelColor,
                      fontSize: Dimens.fontSize12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              Row(
                children: <Widget>[
                  CountryCodeWidget(
                    countryIsoCode: widget.countryIsoCode,
                    dialCode: widget.dialCode,
                    onChanged: widget.onCountryChanged,
                  ),
                  Container(
                    width: Dimens.borderWidth1,
                    height: Dimens.size28,
                    margin: const EdgeInsets.symmetric(
                      horizontal: Dimens.size8,
                    ),
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller,
                      focusNode: widget.focusNode,
                      keyboardType: TextInputType.phone,
                      textInputAction: widget.textInputAction,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: Dimens.maxLength15,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: Dimens.lineHeight24.toLineHeight(
                          Dimens.fontSize16,
                        ),
                        color: textColor,
                        fontSize: Dimens.fontSize16,
                      ),
                      cursorColor: isDark ? Colors.white : Colors.black,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: showFloatingLabel ? null : widget.label,
                        hintStyle: context.textTheme.headlineMedium?.copyWith(
                          color: labelColor,
                          fontWeight: FontWeight.w400,
                          fontSize: Dimens.fontSize16,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: Dimens.size14,
                          horizontal: Dimens.size4,
                        ),
                        isDense: true,
                      ),
                      onChanged: (String value) {
                        setState(() {});
                        widget.onChanged?.call(value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_hasError) ...<Widget>[
          Dimens.size6.heightBox,
          Padding(
            padding: const EdgeInsets.only(left: Dimens.size4),
            child: CustomTextLabelWidget(
              label: widget.errorMsg,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.errorColor,
                fontSize: Dimens.fontSize12,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
