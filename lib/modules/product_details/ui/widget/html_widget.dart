import '../../../../utils/exports.dart';

/// Widget that displays HTML content in a Flutter widget.
class HtmlWidget extends StatelessWidget {
  /// The HTML data to be rendered.
  final String htmlData;

  /// Creates an HTML widget for displaying HTML content.
  const HtmlWidget({
    super.key,
    required this.htmlData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimens.space5,
        left: Dimens.space16,
        right: Dimens.space17,
      ),
      child: Html(

        data: htmlData,
      ),
    );
  }
}
