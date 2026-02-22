import '../../../../utils/exports.dart';

/// Container for All Services section with curved notch background and top drag line.
///
/// Uses ic_white_top_cut_background PNG as the background shape and displays
/// a small centered white drag line at the top for visual separation.
class ServicesContainerWidget extends StatelessWidget {
  /// Creates a services container widget.
  const ServicesContainerWidget({
    super.key,
    required this.child,
  });

  /// Child content (e.g. All Services section).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Background subtract shape
        Positioned.fill(
          child: Assets.png.icWhiteTopCutBackground.image(
            fit: BoxFit.fill,
            color: AppColors.whiteColor,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),

        // Top small drag line
        Positioned(
          top: Dimens.space4,
          left: Dimens.space0,
          right: Dimens.space0,
          child: Center(
            child: Container(
              width: Dimens.size23,
              height: Dimens.size2,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
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
