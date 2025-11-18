import '../../../../utils/exports.dart';

@RoutePage()
/// Page that displays the Tabs screen.
class TabsPage extends StatelessWidget {
  /// Creates a tabs page.
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainConfig.appColors.backgroundWhiteColor,
      body: Column(
        children: <Widget>[
          const HomeAppbar(
            isShadowDisplay: true,
            title: 'Tabs',
          ),
          Expanded(
            child: Center(
              child: CustomTextLabelWidget(
                label: 'Tabs',
                style: context.textTheme.headlineLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

