import '../../../../utils/exports.dart';

/// A custom text label widget that displays a text label with various styling options.
class CustomTextLabelWidget extends StatelessWidget {
  /// The text to be displayed.
  final String label;

  /// The style of the text.
  final TextStyle? style;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// A callback function that is called when the text is tapped.
  final Function()? onTap;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Creates a [CustomTextLabelWidget].
  ///
  /// The [label] parameter is the text to display.
  /// The [style] parameter is optional and specifies the text style.
  /// The [overflow] parameter is optional and specifies how to handle visual overflow.
  /// The [maxLines] parameter is optional and specifies the maximum number of lines.
  /// The [onTap] parameter is optional and specifies a callback function for tap events.
  /// The [textAlign] parameter is optional and defaults to [TextAlign.center].
  const CustomTextLabelWidget(
      {super.key,
      this.label = "",
      this.style,
      this.overflow,
      this.maxLines,
      this.onTap,
        this.textDirection,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Text(
        softWrap: true,
        label,
        textDirection:textDirection ,
        textScaler: TextScaler.noScaling,
        style: style ?? context.textTheme.bodyMedium,
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
