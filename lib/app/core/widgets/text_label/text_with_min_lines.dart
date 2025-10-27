import '../../../../utils/exports.dart';

/// A custom [Text] widget that ensures a minimum number of visible lines.
///
/// If the text has fewer lines than [minLines], the widget pads it
/// with additional line breaks to maintain layout consistency.
///
/// This can be useful for UI elements where a fixed vertical space
/// is desired, even if the text content is short.
///
/// Example:
/// ```dart
/// TextWithMinLines(
///   'Hello',
///   minLines: 3,
///   style: TextStyle(fontSize: 16),
/// )
/// ```
///
/// This will render the word "Hello" but still occupy space for 3 lines.
class TextWithMinLines extends Text {
  /// Creates a [TextWithMinLines] widget.
  ///
  /// The [minLines] value must be non-negative.
  const TextWithMinLines(
      super.data, {
        super.key,
        super.style,
        super.strutStyle,
        super.textAlign,
        super.textDirection,
        super.locale,
        super.softWrap,
        super.overflow,
        super.textScaleFactor,
        this.minLines = 0,
        super.maxLines,
        super.semanticsLabel,
        super.textWidthBasis,
        super.textHeightBehavior,
      })  : assert(minLines >= 0),
        super();

  /// The minimum number of lines the text should occupy.
  ///
  /// If the actual text has fewer lines, empty lines will be added.
  final int minLines;

  @override
  Widget build(BuildContext context) {
    final Widget displayText = super.build(context);
    if (minLines <= 1) {
      return displayText;
    }
    return IndexedStack(
      children: <Widget>[
        displayText,
        Text(
          '\n' * (minLines - 1),
          style: style,
          textScaler: TextScaler.noScaling,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          maxLines: maxLines,
          textHeightBehavior: textHeightBehavior,
        ),
      ],
    );
  }
}
