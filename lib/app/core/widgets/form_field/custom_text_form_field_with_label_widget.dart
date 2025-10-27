import '../../../../utils/exports.dart';

/// Custom TextField
class CustomTextFormFieldInputWidget extends StatelessWidget {
  /// [label] will be displayed in the text field
  final String? label;

  /// [validator] form field validator
  final FormFieldValidator? validator;

  /// [focusNode] FocusNode for TextField
  final FocusNode? focusNode;

  /// [autoFocus] focus on the TextField as soon as it’s visible
  final bool autoFocus;

  /// [controller] controller for text field
  final TextEditingController? controller;

  /// [onChange] onChange method
  final ValueChanged<String>? onChange;

  /// [textInputType] type of text input in text field
  final TextInputType? textInputType;

  /// [prefix] custom widget for prefix
  final Widget? prefix;

  /// [prefixIcon] SvgGenImage to be shown as prefix
  final SvgGenImage? prefixIcon;

  /// [maxLength] max length of text
  final int? maxLength;

  /// [maxLines] maximum lines of text
  final int? maxLines;

  /// [minLines] maximum lines of text
  final int? minLines;

  /// [suffixOnClick] suffix widget click event
  final Function()? suffixOnClick;

  /// [hint] hint text
  final String? hint;

  /// [hintStyle] style for hint in text field
  final TextStyle? hintStyle;

  /// [input] type of keyboard button like go, next, done
  final TextInputAction? input;

  /// [obscureText] is security on or off
  final bool obscureText;

  /// [prefixIconSize] size of prefix
  final Size? prefixIconSize;

  /// [suffixIconSize] size of suffix
  final Size? suffixIconSize;

  /// [prefixIconConstraints] box constraints of prefix
  final BoxConstraints? prefixIconConstraints;

  /// [suffixIconConstraints] box constraints of suffix
  final BoxConstraints? suffixIconConstraints;

  /// [suffix] custom widget for suffix
  final Widget? suffix;

  /// [inputFormatters] input formatters for text field
  final List<TextInputFormatter>? inputFormatters;

  /// [style] style for text in text field
  final TextStyle? style;

  /// [suffixIcon] Widget to be shown as suffix icon
  final Widget? suffixIcon;

  /// [isEditable] value for enabling and disabling text field
  final bool? isEditable;

  /// [borderColor] border color for text field
  final Color? borderColor;

   /// [fillColor] border color for text field
  final Color? fillColor;

  /// [isValidate] validates text field from bool value
  final bool isValidate;

  /// [prefixIconColor] prefix icon color
  final Color? prefixIconColor;

  /// [suffixIconColor] suffix icon color
  final Color? suffixIconColor;

  /// [errorStyle] style for error
  final TextStyle? errorStyle;

  /// [floatingStyle] style of floating label
  final TextStyle? floatingStyle;

  /// [onTextSubmit] on text submit of text field
  final Function(String)? onTextSubmit;

  /// [cursorColor] color for cursor
  final Color? cursorColor;

  /// [onTap] on tap of text field
  final GestureTapCallback? onTap;

  /// [readOnly] read-only text field
  final bool readOnly;

  /// [alignLabelWithHint] defines if the hint should be aligned with label
  final bool alignLabelWithHint;

  /// [labelStyle] style for label in text field
  final TextStyle? labelStyle;

  /// [title] title header text
  final String? title;

  /// [isEnable] if the text field is enabled
  final bool isEnable;

  /// [hasError] if the text field has an error
  final bool hasError;

  /// [titleStyle] style for title in text field
  final TextStyle? titleStyle;

  /// [errorText] error Text in text field
  final String? errorText;

  /// [enableInteractiveSelection] if the text field interactive selection.
  final bool enableInteractiveSelection;

  /// [textCapitalization] if the text field first letter is in capital.
  final TextCapitalization textCapitalization;

  /// [textAlign] error Text in text field
  final TextAlign? textAlign;

  /// [initialValue] initialValue in text field
  final String? initialValue;

  /// [isValidated] isValidated in text field
  final bool isValidated;

  /// [formFieldKey] formFieldKey in text field
  final GlobalKey<FormFieldState<dynamic>>? formFieldKey;

  /// CustomtextFromFieldInputWidget
  const CustomTextFormFieldInputWidget(
      {super.key,
      this.controller,
      this.isValidated = false,
      this.focusNode,
      this.suffixIconColor,
      this.maxLength,
      this.label,
      this.errorStyle,
      this.validator,
      this.hintStyle,
      this.prefixIconColor = Colors.transparent,
      this.autoFocus = false,
      this.onChange,
      this.textInputType = TextInputType.text,
      this.prefix,
      this.readOnly = false,
      this.cursorColor,
      this.input,
      this.isEditable = true,
      this.onTap,
      this.prefixIcon,
      this.obscureText = false,
      this.hint,
      this.suffix,
      this.style,
      this.suffixIcon,
      this.floatingStyle,
      this.borderColor,
      this.inputFormatters,
      this.maxLines = 1,
      this.minLines = 1,
      this.onTextSubmit,
      this.initialValue,
      this.isEnable = true,
      this.prefixIconConstraints = const BoxConstraints(
        minWidth: Dimens.space40,
        minHeight: Dimens.space16,
        maxWidth: Dimens.size50,
        maxHeight: Dimens.size50,
      ),
      this.suffixIconConstraints = const BoxConstraints(
        minWidth: Dimens.size25,
        minHeight: Dimens.size25,
        maxWidth: Dimens.size50,
        maxHeight: Dimens.size50,
      ),
      this.prefixIconSize = const Size(Dimens.size16, Dimens.size16),
      this.suffixIconSize,
      this.suffixOnClick,
      this.isValidate = false,
      this.labelStyle,
      this.hasError = false,
      this.titleStyle,
      bool? alignLabelWithHint,
      this.title,
      this.errorText,
      this.fillColor,
      this.enableInteractiveSelection = true,
      this.textCapitalization = TextCapitalization.none,
      this.textAlign,
      this.formFieldKey})
      : alignLabelWithHint = alignLabelWithHint ?? true;

  @override
  Widget build(BuildContext context) {
    // Check if the current direction is RTL
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.noScaling),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: title.isNotNullOrEmpty,
            child: CustomTextLabelWidget(
              label: title ?? "",
              style: titleStyle ??
                  context.textTheme.labelSmall?.copyWith(
                      color: MainConfig.appColors.greyExtraDarkColor,
                      fontSize: Dimens.fontSize14),
            ),
          ),
          const SizedBox(
            height: Dimens.space2,
          ),
          TextFormField(
            onTapOutside: (PointerDownEvent event) {
              if (focusNode != null) {
                focusNode?.unfocus();
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            key: formFieldKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textCapitalization: textCapitalization,
            enableInteractiveSelection: enableInteractiveSelection,
            maxLength: maxLength,
            controller: controller,
            validator: validator,
            onTap: onTap,
            keyboardType: textInputType,
            textInputAction: input,
            onChanged: onChange,
            textAlign: textAlign ?? TextAlign.start,
            readOnly: readOnly,
            focusNode: focusNode,
            autofocus: autoFocus,
            initialValue: initialValue,
            onFieldSubmitted: (String submit) => onTextSubmit != null
                ? onTextSubmit?.call(submit)
                : (input == TextInputAction.next
                    ? FocusScope.of(context).nextFocus()
                    : null),
            inputFormatters: inputFormatters ?? (<TextInputFormatter>[]),
            maxLines: maxLines,
            minLines: minLines,
            enabled: isEditable,
            style: style ??
                context.textTheme.bodyMedium?.copyWith(
                  fontSize: Dimens.fontSize16,
                  color:
                      isEditable! ? MainConfig.appColors.textBlackColor : MainConfig.appColors.textBlackColor,
                ),
            cursorColor: cursorColor ?? MainConfig.appColors.textBlackColor,
            obscureText: obscureText,
              decoration: InputDecoration(
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                errorStyle: errorStyle ?? MainConfig.appStyle.errorStyle,
                labelText: label ?? "",
                labelStyle: style ??
                    context.textTheme.bodyMedium?.copyWith(
                      fontSize: Dimens.fontSize16,
                      color: isEditable! ? MainConfig.appColors.textLabelGreyColor : MainConfig.appColors.textBlackColor,
                    ),
                errorText: errorText,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Dimens.space10,
                  vertical: Dimens.space10,
                ),
                alignLabelWithHint: alignLabelWithHint,
                suffixIconConstraints: suffixIconConstraints,
                prefixIconConstraints: prefixIconConstraints,
                prefix: prefix,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                  borderSide: BorderSide(
                    color: borderColor ?? MainConfig.appColors.errorBorder,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                  borderSide: BorderSide(
                    color: borderColor ?? MainConfig.appColors.borderPrimaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                  borderSide: BorderSide(
                    color: borderColor ?? MainConfig.appColors.dukkanborderGreyLightColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                  borderSide: BorderSide(
                    color: borderColor ?? MainConfig.appColors.errorBorder,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                  borderSide: BorderSide(
                    color: borderColor ?? MainConfig.appColors.backgroundBlackColor,
                  ),
                ),
                filled: true,
                fillColor: isEditable!
                    ? fillColor ?? MainConfig.appColors.backgroundWhite
                    : MainConfig.appColors.backgroundWhite,
                hintText: hint,
                hintStyle: hintStyle ??
                    context.textTheme.bodyMedium?.copyWith(
                      fontSize: Dimens.fontSize14,
                      color: MainConfig.appColors.dukkanHintGreyColor,
                    ),
                suffix: suffix,
                prefixIcon: prefixIcon?.svg(
                  height: prefixIconSize?.height,
                  width: prefixIconSize?.width,
                  colorFilter: ColorFilter.mode(
                    prefixIconColor ?? MainConfig.appColors.transparent,
                    BlendMode.srcATop,
                  ),
                ),
                suffixIcon: Visibility(
                  visible: suffixIcon != null,
                  child: GestureDetector(
                    onTap: suffixOnClick,
                    child: Container(
                      padding: isRtl
                          ? const EdgeInsets.only(
                        left: Dimens.space10,
                        top: Dimens.space14,
                        bottom: Dimens.space14,
                      )
                          : const EdgeInsets.only(
                        right: Dimens.space10,
                        top: Dimens.space12,
                        bottom: Dimens.space10,
                      ),
                      child: suffixIcon,
                    ),
                  ),
                ),
              ),

          ),
        ],
      ),
    );
  }
}
