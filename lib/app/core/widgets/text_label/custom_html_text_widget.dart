import '../../../../utils/exports.dart';

/// A widget that renders HTML content with optional custom styles and font size.
///
/// This widget uses the `flutter_html` package to parse and render HTML.
/// It also supports clickable links that will be launched using the device's browser.
///
/// Example usage:
/// ```dart
/// CustomHtmlTextWidget(
///   htmlContent: "<p>Hello <a href='https://example.com'>world</a></p>",
///   fontSize: 16.0,
/// )
/// ```
class CustomHtmlTextWidget extends StatelessWidget {
  /// Creates a [CustomHtmlTextWidget].
  ///
  /// The [htmlContent] parameter must not be null.
  /// Optionally, you can provide [customStyles] to override default text styling,
  /// and [fontSize] to control the text size for the rendered HTML.
  const CustomHtmlTextWidget({
    super.key,
    required this.htmlContent,
    this.customStyles,
    this.fontSize,
  });

  /// The HTML content string to be rendered.
  final String htmlContent;

  /// Optional custom style for the HTML `<body>` element.
  ///
  /// If null, a default style is applied.
  final Style? customStyles;

  /// Optional font size for the rendered HTML text.
  ///
  /// If null, defaults to [Dimens.fontSize17].
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: htmlContent,
      onLinkTap: (String? url, Map<String, String> attributes, dynamic element) async {
        if (url != null) {
          await _launchURL(url);
        }
      },
      style: <String, Style>{
        "body": customStyles ??
            Style(
              padding: HtmlPaddings.zero,
              textAlign: TextAlign.start,
              fontStyle: FontStyle.normal,
              fontSize: FontSize(fontSize ?? Dimens.fontSize17),
              fontWeight: FontWeight.w500,
              fontFamily: "source_sans_pro_regular",
              color: MainConfig.appColors.textLabelGreyColor,
            ),
      },
    );
  }
}

/// Launches a URL in the device's default browser.
///
/// Throws an [Exception] if the URL cannot be launched.
Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
