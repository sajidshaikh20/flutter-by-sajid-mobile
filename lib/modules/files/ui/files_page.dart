import '../../../../utils/exports.dart';

@RoutePage()
/// Page that displays the Files screen.
class FilesPage extends StatelessWidget {
  /// Creates a files page.
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainConfig.appColors.backgroundWhiteColor,
      body: Column(
        children: <Widget>[
          const HomeAppbar(
            isShadowDisplay: true,
            title: 'Files',
          ),
          Expanded(
            child: Center(
              child: CustomTextLabelWidget(
                label: 'Files',
                style: context.textTheme.headlineLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

