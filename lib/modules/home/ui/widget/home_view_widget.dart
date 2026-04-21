import '../../../../utils/exports.dart';

/// Main home view widget combining all home screen sections.
class HomeViewWidget extends StatelessWidget {
  /// Creates a home view widget.
  const HomeViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gradientStart = MainConfig.appColors.primary;
    final Color gradientEnd = MainConfig.appColors.primaryDark;

    return const SizedBox(


      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.space20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text("home page"),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
