import '../../../../utils/exports.dart';

/// Plane/GIF banner for the Tour & Travel section (2/3 of bottom row).
class TourTravelPlaneBannerWidget extends StatelessWidget {
  /// Creates a tour travel plane banner widget.
  const TourTravelPlaneBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.radius10),
        child: Image.asset(
          Assets.gif.aroplane.path,
          height: Dimens.space117,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
