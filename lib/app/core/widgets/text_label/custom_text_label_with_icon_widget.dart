import '../../../../utils/exports.dart';

/// A custom widget that displays a text label with an optional icon.
///
/// This widget allows you to display a text label alongside an icon, either
/// as a prefix or a suffix. It offers customization options for the text
/// style, overflow, maximum lines, text alignment, icon, icon color, icon
/// size, and icon padding.
class CustomTextLabelWithIcon extends StatelessWidget {
  /// The text label to be displayed.
  final String label;

  /// The style of the text label.
  final TextStyle? style;

  /// The text overflow behavior.
  final TextOverflow? overflow;

  /// The maximum number of lines for the text label.
  final int? maxLines;

  /// The alignment of the text label.
  final TextAlign? textAlign;

  /// The SVG image to be displayed as an icon.
  final SvgGenImage? image;

  /// The color of the icon.
  final Color? imageColor;

  /// The size of the icon.
  final Size? size;

  /// Whether the icon is a prefix or not.
  /// Whether the icon is a suffix or not.

  final bool isPrefix, isSuffix;
  /// [iconPadding] - the padding of the icon.
 final EdgeInsetsGeometry iconPadding;
  /// [mainAxisAlignment] - the alignment of the main axis.
  final MainAxisAlignment mainAxisAlignment;
///
  const CustomTextLabelWithIcon(
      {super.key,
      this.label = "",
      this.style,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.isPrefix = false,
      this.isSuffix = false,
      this.overflow,
      this.iconPadding =
          const EdgeInsets.only(left: Dimens.space8, right: Dimens.space8),
      this.image,
      this.imageColor,
      this.maxLines,
      this.size = const Size(Dimens.size14, Dimens.size14),
      this.textAlign = TextAlign.center});

  /// Builds the widget tree for the CustomTextLabelWithIcon.
  ///
  /// This method constructs a Row widget containing the icon (if present),
  /// the text label, and another icon (if present).
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        Visibility(
          visible: image != null && isPrefix,
          child: Padding(
            padding: iconPadding,
            child: image?.svg(
              height: size?.height,
              width: size?.width,
              colorFilter: ColorFilter.mode(
                imageColor ?? MainConfig.appColors.defaultIconColor,
                BlendMode.srcATop,
              ),
            ),
          ),
        ),
        Expanded(
          flex: maxLines != null && maxLines! > 1 ? 1 : (image == null ? 1 : 0),
          child: CustomTextLabelWidget(
            label: label,
            style: style ??
                context.textTheme.titleMedium
                    ?.copyWith(color: MainConfig.appColors.textBlackColor),
            overflow: overflow,
            maxLines: maxLines,
            textAlign: textAlign,
          ),
        ),
        Visibility(
          visible: image != null && isSuffix,
          child: Padding(
            padding: iconPadding,
            child: image?.svg(
              height: size?.height,
              width: size?.width,
              colorFilter: ColorFilter.mode(
                imageColor ?? MainConfig.appColors.defaultIconColor,
                BlendMode.srcATop,
              ),
            ),
          ),
        )
      ],
    );
  }
}
