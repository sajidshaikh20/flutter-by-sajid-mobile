import '../../../../utils/exports.dart';

class ServicesContainerWidget extends StatelessWidget {
  final Widget child;

  const ServicesContainerWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Background subtract shape
        Positioned.fill(
          child: Assets.png.icWhiteTopCutBackground.image(
            fit: BoxFit.fill,
            color: Colors.white,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),

        // Top small drag line
        Positioned(
          top: 4,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 23,
              height: 2,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        ),

        // Dynamic content
        child,
      ],
    );
  }
}
