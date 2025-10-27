import '../../../../../utils/exports.dart';

/// Custom widget to show Customised AppBar as per the requirement.
///
/// This Widget includes BackButton, TitleWidget and TrailingIcons.
class MainAppBarTitleWidget extends StatelessWidget {
  /// The title text to display in the app bar.
  final String? title;

  /// Creates a [MainAppBarTitleWidget] with an optional [title].
  const MainAppBarTitleWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: title.isNotNullOrEmpty,
      child: CustomTextLabelWidget(
        label: title ?? "",
      ),
    );
  }
}

