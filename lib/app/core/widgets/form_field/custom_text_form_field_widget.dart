import '../../../../utils/exports.dart';
import 'no_bubble_text_selectio_controls.dart';

/// Custom TextField
class CustomTextFormFieldWidget extends StatelessWidget {
  ///[label] will be display in text field
  final String label;

  ///[prefixText] will be display in text field
  final String? prefixText;

  ///[suffixText] will be display in text field
  final String? suffixText;

  ///[validator] form filed validator will pass validation method
  final FormFieldValidator? validator;

  ///[focusNode] FocusNode for TextField
  final FocusNode? focusNode;

  ///[autoFocus] focus on the TextField as soon as it’s visible
  final bool autoFocus;

  ///[controller] controller for textfield
  final TextEditingController controller;

  ///[onChange] onchange method
  final ValueChanged<String>? onChange;

  ///[textInputType] give the type of text input in textfield
  final TextInputType? textInputType;

  ///[prefix] Custom Widget for  prefix
  final Widget? prefix;

  ///[prefixIcon] SvgGenImage to be shown as prefix.
  final Widget? prefixIcon;

  ///[maxLength] maxlength of Text
  final int? maxLength;

  ///[maxLines] maximum line of Text
  final int? maxLines;

  ///[minLines] maximum line of Text
  final int? minLines;

  ///[suffixOnClick] Suffix Widget Click Event
  final Function()? suffixOnClick;

  ///[prefixOnClick] Prefix Widget Click Event
  final Function()? prefixOnClick;

  ///[hint] hint text
  final String? hint;

  ///[hintStyle] Style for hint in textField
  final TextStyle? hintStyle;

  /// [input] type of keyboard button like go, next, done
  final TextInputAction? input;

  ///[obscureText] is Sequrity on or off
  final bool? obscureText;

  /// [prefixIconSize] size of prefix
  final Size? prefixIconSize;

  /// [suffixIconSize] size of suffix
  final Size? suffixIconSize;

  /// [prefixIconConstraints] BoxConstraints of prefix
  final BoxConstraints? prefixIconConstraints;

  /// [suffixIconConstraints] BoxConstraints of suffix
  final BoxConstraints? suffixIconConstraints;
  ///[formFieldKey] Key for the underlying TextFormField
  final Key? formFieldKey;

  ///[suffix] custom widget for suffix
  final Widget? suffix;

  ///[inputFormatters] validator for entering value in text field
  final List<TextInputFormatter>? inputFormatters;

  ///[style] style for text in text field
  final TextStyle? style;

  ///[suffixIcon] SvgGenImage to be shown as suffix icon
  final Widget? suffixIcon;

  ///[isEditable] value for enable and disable text field
  final bool? isEditable;

  ///[borderColor] bordercolor for textfield
  final Color? borderColor;

  // ///[isValidate] validated text field from bool value
  // final Rx<bool>? isValidate;

  ///[prefixIconColor] prefix Icon Color
  final Color? prefixIconColor;

  ///[suffixIconColor] suffix Icon Color
  final Color? suffixIconColor;

  ///[errorStyle] Style for Error
  final TextStyle? errorStyle;

  ///[floatingStyle] Style of Floating label
  final TextStyle? floatingStyle;

  ///[onTextSubmit] onTextSubmit of text field
  final Function(String)? onTextSubmit;

  ///[cursorColor] Color for Cursor
  final Color? cursorColor;

  ///[textAlign] Color for Cursor
  final TextAlign? textAlign;

  ///[GestureTapCallback]  on tap of text field
  final GestureTapCallback? onTap;

  ///[readOnly] can not edit text field
  final bool? readOnly;

  ///[FloatingLabelBehavior] defines the behavior of Floating label
  final FloatingLabelBehavior floatingLabelBehavior;

  ///showColorPrefixBorder
  final bool showColorPrefixBorder;

  ///[alignLabelWithHint] defines that the hint
  ///should be aligned with label or not.
  final bool alignLabelWithHint;

  ///[title] defines the title above the edit field
  final String? title;

  ///[titleStyle] Style of title label
  final TextStyle? titleStyle;

  ///[textCapitalization] Controls how text is capitalized as the user types
  final TextCapitalization textCapitalization;

  ///[decoration] Custom decoration to override default input decoration
  final InputDecoration? decoration;
  ///[onTapOutside] Callback when user taps outside the field
  final Function(PointerDownEvent)? onTapOutside;

  ///[blendMode] Optional blend mode used for custom compositing (if applied)
  final BlendMode? blendMode;

  ///[device] Device type used for responsive sizing (mobile/tablet/desktop)
  final ScreenType device;

  ///[cursorHeight] Custom height for the text cursor
  final double? cursorHeight;

  ///CustomTextFormFieldWidget
  const CustomTextFormFieldWidget(
      {super.key,
      required this.controller,
      this.formFieldKey,
      this.blendMode,
      this.focusNode,
      this.maxLength,
      this.label = "",
      this.errorStyle,
      this.validator,
      this.hintStyle,
      this.titleStyle,
      this.title,
      this.prefixIconColor = Colors.transparent,
      this.autoFocus = false,
      this.onChange,
      this.textInputType = TextInputType.text,
      this.prefix,
      this.readOnly = false,
      this.cursorColor,
      this.input,
      this.isEditable,
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
      this.maxLines = Dimens.maxLines01,
      this.minLines = Dimens.minLines01,
      this.onTextSubmit,
      this.prefixOnClick,
      this.prefixIconConstraints,
      this.suffixIconConstraints = const BoxConstraints(
          minWidth: Dimens.size24,
          minHeight: Dimens.size24,
          maxWidth: Dimens.size50,
          maxHeight: Dimens.size50),
      this.prefixIconSize = const Size(Dimens.size20, Dimens.size20),
      this.suffixIconSize,
      this.suffixOnClick,
      // this.isValidate,
      FloatingLabelBehavior? floatingLabelBehavior,
      bool? alignLabelWithHint,
      this.prefixText,
      this.suffixIconColor,
      this.textAlign,
      this.suffixText,
      this.textCapitalization = TextCapitalization.none,
      this.showColorPrefixBorder = false,
      this.decoration,
      this.onTapOutside,
      this.device = ScreenType.mobile,
      this.cursorHeight})
      : floatingLabelBehavior =
            floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        alignLabelWithHint = alignLabelWithHint ?? false;

  /// Builds the configured TextFormField with consistent styling and behavior
  @override
  Widget build(BuildContext context) {
    double textFontSize = Dimens.fontSize16;
    double floatingLabelFontSize = Dimens.fontSize18;
    double errorLabelFontSize = Dimens.fontSize14;
    OutlineInputBorder commonBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: MainConfig.appColors.lightGreyColor,
          width: Dimens.borderWidth05), // Border color and width
      borderRadius: Dimens.radius8.borderRadius, // Border radius
    );

    EdgeInsets contentPadding = EdgeInsets.zero;
    switch (device) {
      case ScreenType.mobile:
        break;
      case ScreenType.tablet:
        floatingLabelFontSize = Dimens.fontSize20;
        textFontSize = Dimens.fontSize22;
        contentPadding = const EdgeInsets.only(
            top: Dimens.space9,
            bottom: Dimens.space15,
            left: Dimens.space15,
            right: Dimens.space17);
        errorLabelFontSize = Dimens.fontSize18;
      case ScreenType.desktop:
        break;
    }
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.noScaling),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            visible: title.isNotNullOrEmpty,
            child: Container(
              margin: const EdgeInsets.only(
                  top: Dimens.space8, bottom: Dimens.space4),
              child:
                  CustomTextLabelWidget(label: title ?? "", style: titleStyle),
            ),
          ),
          TextFormField(
            selectionControls: NoBubbleTextSelectionControls(),
            onTapOutside: onTapOutside,
            key: formFieldKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enableInteractiveSelection: true,
            maxLength: maxLength,
            controller: controller,
            validator: validator,
            onTap: onTap,
            textCapitalization: textCapitalization,
            keyboardType: textInputType,
            textInputAction: input,
            onChanged: onChange,
            readOnly: readOnly ?? false,
            focusNode: focusNode,
            autofocus: autoFocus,
            inputFormatters: inputFormatters,
            style: style ??
                context.textTheme.titleMedium?.copyWith(
                    color: MainConfig.appColors.textPrimaryColor,
                    fontSize: textFontSize),
            maxLines: maxLines,
            minLines: minLines,
            enabled: isEditable,
            cursorHeight: cursorHeight,
            cursorColor: cursorColor ?? MainConfig.appColors.primary,
            obscureText: obscureText ?? false,
            textAlign: textAlign ?? TextAlign.start,
            onFieldSubmitted: onTextSubmit,
            decoration: decoration ??
                InputDecoration(
                  border: commonBorder,
                  enabledBorder: commonBorder,
                  focusedBorder: commonBorder,
                  disabledBorder: commonBorder,
                  errorBorder: commonBorder,
                  focusedErrorBorder: commonBorder,
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  errorStyle: errorStyle ??
                      context.textTheme.titleSmall?.copyWith(
                          fontSize: errorLabelFontSize,
                          color: AppColors.redColorNormal),
                  counterText: '',
                  alignLabelWithHint: alignLabelWithHint,
                  floatingLabelBehavior: floatingLabelBehavior,
                  suffixIconConstraints: suffixIconConstraints,
                  contentPadding: contentPadding,
                  prefixIconConstraints: prefixIconConstraints,
                  prefix: prefix,
                  labelText: label,
                  isDense: true,
                  isCollapsed: true,
                  hintStyle: hintStyle,
                  hintText: hint,
                  labelStyle: context.textTheme.titleSmall?.copyWith(
                      color: MainConfig.appColors.textColorGrey,
                      fontSize: floatingLabelFontSize),
                  prefixIcon: prefixIcon != null
                      ? GestureDetector(
                          onTap: () {
                            prefixOnClick?.call();
                          },
                          child: Row(
                            children: <Widget>[
                              DecoratedBox(
                                decoration: showColorPrefixBorder
                                    ? BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: MainConfig
                                              .appColors.backgroundBlueColor,
                                        ),
                                      )
                                    : const BoxDecoration(),
                                child: prefixIcon,
                              ),
                              if (prefixText != null) ...<Widget>[
                                Dimens.size12.widthBox
                              ],
                              Text(
                                prefixText ?? "",
                                style: context.textTheme.headlineMedium,
                              ),
                              if (prefixText != null) ...<Widget>[
                                Dimens.size6.widthBox
                              ],
                            ],
                          ),
                        )
                      : null,
                  suffix: suffix,
                  suffixIcon: suffixIcon != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (suffixText.isNotNullOrEmpty) ...<Widget>[
                              Dimens.size8.widthBox,
                              Expanded(
                                child: CustomTextLabelWidget(
                                  textAlign: TextAlign.start,
                                  label: suffixText ?? "",
                                  style: context.textTheme.headlineMedium,
                                ),
                              )
                            ],

                            GestureDetector(
                              onTap: () {
                                suffixOnClick?.call();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: Dimens.space9,
                                  left: Dimens.space4,
                                ),
                                child: suffixIcon,
                              ),
                            ),
                          ],
                        )
                      : null,
                ),
          ),
        ],
      ),
    );
  }
}
