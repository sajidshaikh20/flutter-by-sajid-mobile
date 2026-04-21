import '../../../../utils/exports.dart';

/// Main home view widget combining all home screen sections.
class HomeViewWidget extends StatelessWidget {
  /// Creates a home view widget.
  const HomeViewWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         const Text('Home Screen'),
        Assets.svgs.icHome.svg(
            height: 20,
            color: Colors.red
        )
      ],
    ));
  }
}
