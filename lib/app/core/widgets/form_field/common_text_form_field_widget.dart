import '../../../../utils/exports.dart';
///
class CommonTextFormFieldWidget extends StatefulWidget {
  /// Custom TextField
  final String label;

  /// [prefixText] is show before the textfield
  final String? prefixText;

  /// [suffixText] is show after the textfield
  final String? suffixText;

  /// [validator] is the function to validate the textfield
  final FormFieldValidator? validator;

  /// [focusNode] is the focus node for the textfield
  final FocusNode? focusNode;

  /// [autoFocus] is the autofocus for the textfield
  final bool autoFocus;

  /// [controller] is the controller for the textfield
  final TextEditingController controller;

  /// [onChange] is the callback function when the textfield value is changed
  final ValueChanged<String>? onChange;

  /// [textInputType] is the type of the textfield
  final TextInputType? textInputType;

  /// [prefix] is the widget to show before the textfield
  final Widget? prefix;

  /// [prefixIcon] is the icon to show before the textfield
  final Widget? prefixIcon;

  /// [maxLength] is the max length for the textfield
  final int? maxLength;

  /// [maxLines] is the max lines for the textfield
  final int? maxLines;

  /// [minLines] is the min lines for the textfield
  final int? minLines;

  /// [suffixOnClick] is the callback function when the suffix icon is clicked
  final Function()? suffixOnClick;

  /// [prefixOnClick] is the callback function when the prefix icon is clicked
  final Function()? prefixOnClick;

  /// [hint] is the hint text for the textfield
  final String? hint;

  /// [hintStyle] is the style for the hint text
  final TextStyle? hintStyle;

  /// [input] is the type of the text input action
  final TextInputAction? input;

  /// [obscureText] is to hide the text in the textfield
  final bool? obscureText;

  /// [prefixIconSize] is the size of the prefix icon
  final Size? prefixIconSize;

  /// [suffixIconSize] is the size of the suffix icon
  final Size? suffixIconSize;

  /// [prefixIconConstraints] is the constraints of the prefix icon
  final BoxConstraints? prefixIconConstraints;

  /// [suffixIconConstraints] is the constraints of the suffix icon
  final BoxConstraints? suffixIconConstraints;

  /// [formFieldKey] is the key for the form field
  final GlobalKey<FormFieldState<dynamic>>? formFieldKey;

  /// [suffix] is the widget to show after the textfield
  final Widget? suffix;

  /// [inputFormatters] is the formatters for the textfield
  final List<TextInputFormatter>? inputFormatters;

  /// [style] is the style for the textfield
  final TextStyle? style;

  /// [suffixIcon] is the icon to show after the textfield
  final Widget? suffixIcon;

  /// [isEditable] is to enable or disable the textfield
  final bool? isEditable;

  /// [borderColor] is the color of the border
  final Color? borderColor;

  /// [borderWidth] is the width of the border
  final double borderWidth;

  /// [labelColor] is the color of the label
  final Color? labelColor;

  /// [prefixIconColor] is the color of the prefix icon
  final Color? prefixIconColor;

  /// [suffixIconColor] is the color of the suffix icon
  final Color? suffixIconColor;

  /// [errorStyle] is the style of the error text
  final TextStyle? errorStyle;

  /// [floatingStyle] is the style of the floating label
  final TextStyle? floatingStyle;

  /// [onTextSubmit] is the callback function when the textfield is submitted
  final Function(String)? onTextSubmit;

  /// [cursorColor] is the color of the cursor
  final Color? cursorColor;

  /// [fillColor] is the color of the fill
  final Color? fillColor;

  /// [textAlign] is the alignment of the text
  final TextAlign? textAlign;

  /// [onTap] is the callback function when the textfield is tapped
  final GestureTapCallback? onTap;

  /// [readOnly] is to set the textfield as read only
  final bool? readOnly;

  /// [floatingLabelBehavior] is the behavior of the floating label
  final FloatingLabelBehavior floatingLabelBehavior;

  /// [showColorPrefixBorder] is to show the color of the prefix border
  final bool showColorPrefixBorder;

  /// [alignLabelWithHint] is to align the label with the hint
  final bool alignLabelWithHint;

  /// [title] is the title of the textfield
  final String? title;

  /// [titleStyle] is the style of the title
  final TextStyle? titleStyle;

  /// [textCapitalization] is the capitalization of the textfield
  final TextCapitalization textCapitalization;

  /// [decoration] is the decoration of the textfield
  final InputDecoration? decoration;

  /// [onTapOutside] is the callback function when the textfield is tapped outside
  final Function(PointerDownEvent)? onTapOutside;

  /// [blendMode] is the blend mode of the textfield
  final BlendMode? blendMode;

  /// [device] is the device type
  final ScreenType device;

  /// [errorMsg] is the error message of the textfield
  final String? errorMsg;

  /// [editTextHeight] is the height of the textfield
  final double? editTextHeight;

  /// [cursorHeight] is the height of the cursor
  final double? cursorHeight;

  /// [borderRadius] is the border radius of the textfield
  final double borderRadius;

  /// [floatingLabelFontSize] is the font size of the floating label
  final double? floatingLabelFontSize;

  /// If true, emojis are allowed in input; if false, emojis are filtered out
  final bool isEmojiAllow;

  /// Override interactive selection behavior (null uses default behavior)
  final bool? enableInteractiveSelection;

  /// Override cursor visibility (null uses default behavior)
  final bool? showCursor;

  /// Disable context menu when true (default: false)
  final bool disableContextMenu;

  /// When true, the field's container height grows with content instead of being fixed
  final bool enableAutoHeight;
///
  const CommonTextFormFieldWidget({
    super.key,
    required this.controller,
    this.formFieldKey,
    this.blendMode,
    this.focusNode,
    this.maxLength,
    this.label = "",
    this.errorMsg = "",
    this.errorStyle,
    this.validator,
    this.hintStyle,
    this.titleStyle,
    this.title,
    this.prefixIconColor = Colors.transparent,
    this.labelColor,
    this.autoFocus = false,
    this.onChange,
    this.textInputType = TextInputType.text,
    this.prefix,
    this.readOnly = false,
    this.cursorColor,
    this.fillColor,
    this.input,
    this.editTextHeight = Dimens.size58,
    this.borderRadius = Dimens.size10,
    this.isEditable,
    this.onTap,
    this.prefixIcon,
    this.obscureText = false,
    this.hint,
    this.suffix,
    this.style,
    this.suffixIcon,
    this.cursorHeight,
    this.floatingStyle,
    this.borderColor,
    this.borderWidth = Dimens.borderWidth05,
    this.inputFormatters,
    this.maxLines = Dimens.maxLines01,
    this.minLines = Dimens.minLines01,
    this.floatingLabelFontSize = Dimens.fontSize16,
    this.onTextSubmit,
    this.prefixOnClick,
    this.prefixIconConstraints,
    this.suffixIconConstraints = const BoxConstraints(
      minWidth: Dimens.size24,
      minHeight: Dimens.size24,
      maxWidth: Dimens.size50,
      maxHeight: Dimens.size50,
    ),
    this.prefixIconSize = const Size(Dimens.size24, Dimens.size24),
    this.suffixIconSize,
    this.suffixOnClick,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.alignLabelWithHint = false,
    this.prefixText,
    this.suffixIconColor,
    this.textAlign,
    this.suffixText,
    this.textCapitalization = TextCapitalization.sentences,
    this.showColorPrefixBorder = false,
    this.decoration,
    this.onTapOutside,
    this.device = ScreenType.mobile,
    this.isEmojiAllow = false,
    this.enableInteractiveSelection,
    this.showCursor,
    this.disableContextMenu = false,
    this.enableAutoHeight = false,
  });

  @override
  State<CommonTextFormFieldWidget> createState() =>
      _CommonTextFormFieldWidgetState();
}

class _CommonTextFormFieldWidgetState extends State<CommonTextFormFieldWidget> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {}); // Trigger UI update on focus changes
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;
    double textFontSize = Dimens.fontSize16;
    EdgeInsets contentPadding = const EdgeInsets.only(
      top: Dimens.space10,
      bottom: Dimens.space10,
      left: Dimens.space5,
      right: Dimens.space10,
    );

    final bool hasError = widget.errorMsg?.isNotEmpty ?? false;
    final bool isFocused = _focusNode.hasFocus;

    // Dynamically resolve colors based on theme
    final Color resolvedFillColor = widget.fillColor ??
        (isDark ? AppColors.surfaceDark : AppColors.whiteColor);
    final Color resolvedLabelColor = widget.labelColor ??
        (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    Color borderColor;
    Color labelColor;
    if (hasError) {
      borderColor = AppColors.errorColor;
      labelColor = AppColors.errorColor;
    } else if (isFocused) {
      borderColor = AppColors.primaryPurple;
      labelColor = AppColors.primaryPurple;
    } else {
      borderColor = widget.borderColor ??
          (isDark ? AppColors.whiteColor : MainConfig.appColors.dukkanborderGreyLightColor);
      labelColor = resolvedLabelColor;
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.noScaling),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: widget.enableAutoHeight ? null : widget.editTextHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: resolvedFillColor,
              border: Border.all(color: borderColor,
              width: widget.borderWidth),
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
            ),
            child: TextFormField(
              onTapOutside: widget.onTapOutside,
            key: widget.formFieldKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enableInteractiveSelection: widget.enableInteractiveSelection ?? true,
            maxLength: widget.maxLength,
            controller: widget.controller,
            onTap: widget.onTap,
            textCapitalization: widget.textCapitalization,
            keyboardType: widget.textInputType,
            textInputAction: widget.input,
            onChanged: widget.onChange,
            readOnly: widget.readOnly ?? false,
            focusNode: widget.focusNode,
            autofocus: widget.autoFocus,
            showCursor: widget.showCursor,
            // contextMenuBuilder: widget.disableContextMenu
            //     ? (BuildContext context, EditableTextState editableTextState) {
            //         return const SizedBox.shrink();
            //       }
            //     : null,
            cursorHeight: widget.cursorHeight,
            inputFormatters: widget.isEmojiAllow
                ? widget.inputFormatters
                : <TextInputFormatter>[
                    ...?widget.inputFormatters,
                    EmojiBlockFormatter(),
                  ],
            style: widget.style ??
                context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: Dimens.lineHeight24.toLineHeight(textFontSize),
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: textFontSize),
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            enabled: widget.isEditable,
            cursorColor: widget.cursorColor ??
                (isDark ? Colors.white : Colors.black),
            obscureText: widget.obscureText ?? false,
            textAlign: widget.textAlign ?? TextAlign.start,
            onFieldSubmitted: widget.onTextSubmit,
            decoration: widget.decoration ??
                InputDecoration(
                  counterText: '',
                  alignLabelWithHint: widget.alignLabelWithHint,
                  floatingLabelBehavior: widget.floatingLabelBehavior,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: resolvedFillColor,
                  filled: true,
                  focusedErrorBorder: InputBorder.none,
                  suffixIconConstraints: widget.suffixIconConstraints,
                    contentPadding: contentPadding,
                    prefixIconConstraints: widget.prefixIconConstraints ??
                        BoxConstraints(
                          minWidth: Dimens.size24,
                          minHeight: Dimens.size24,
                          maxWidth: widget.prefixText.isNullOrEmpty
                              ? Dimens.size50
                              : Dimens.size50,
                          maxHeight: Dimens.size50,
                        ),
                    prefix: widget.prefix,
                    labelText: widget.label,
                    isDense: false,
                    hintStyle: widget.hintStyle,
                    hintText: widget.hint,
                    labelStyle: context.textTheme.headlineMedium?.copyWith(
                        color: labelColor,
                        fontWeight: FontWeight.w400,
                        height: Dimens.lineHeight29.toLineHeight(Dimens.size16),
                        fontSize: widget.floatingLabelFontSize),
                    prefixIcon: widget.prefixIcon != null
                        ? GestureDetector(
                      behavior: HitTestBehavior.translucent,
                            onTap: () {
                              widget.prefixOnClick?.call();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: isLanguageAlignmentLTR
                                      ? Dimens.space12
                                      : 0,
                                  right: isLanguageAlignmentLTR
                                      ? 0
                                      : Dimens.space12),
                              child: Row(
                                children: <Widget>[
                                  DecoratedBox(
                                    decoration: widget.showColorPrefixBorder
                                        ? BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: MainConfig.appColors
                                                  .backgroundBlueColor,
                                            ),
                                          )
                                        : const BoxDecoration(),
                                    child: widget.prefixIcon,
                                  ),
                                  if (widget.prefixText != null) ...<Widget>[
                                    Dimens.size12.widthBox
                                  ],
                                  Text(
                                    widget.prefixText ?? "",
                                    style: context.textTheme.headlineMedium,
                                  ),
                                  if (widget.prefixText != null) ...<Widget>[
                                    Dimens.size6.widthBox
                                  ],
                                ],
                              ),
                            ),
                          )
                        : null,
                    suffix: widget.suffix,
                    suffixIcon: widget.suffixIcon != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              if (widget
                                  .suffixText.isNotNullOrEmpty) ...<Widget>[
                                Dimens.size8.widthBox,
                                Flexible(
                                  child: CustomTextLabelWidget(
                                    textAlign: TextAlign.start,
                                    label: widget.suffixText ?? "",
                                    style: context.textTheme.headlineMedium,
                                  ),
                                )
                              ],
                              GestureDetector(
                                onTap: () {
                                  widget.suffixOnClick?.call();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: Dimens.space10,
                                    left: Dimens.space4,
                                  ),
                                  child: widget.suffixIcon,
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
            ),
          ),
          Visibility(
            visible: widget.errorMsg?.isNotEmpty ?? false,
            child: Padding(
              padding: EdgeInsets.only(
                  right: isRTL ? Dimens.space12 : Dimens.space0,
                  left: isRTL ? Dimens.space0 : Dimens.space12,
                  top: Dimens.space2),
              child: CustomTextLabelWidget(
                textAlign: TextAlign.start,
                label: widget.errorMsg ?? "",
                style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: Dimens.fontSize10,
                    height: Dimens.lineHeight18Point74
                        .toLineHeight(Dimens.fontSize10),
                    fontWeight: FontWeight.w400,
                    color: MainConfig.appColors.errorBorder),
              ),
            ),
          )
        ],
      ),
    );
  }
}
