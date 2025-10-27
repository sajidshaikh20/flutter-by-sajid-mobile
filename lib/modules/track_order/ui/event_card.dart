import '../../../utils/exports.dart';

/// A card widget for displaying event information in the track order timeline.
class EventCard extends StatelessWidget {
  /// Creates an event card.
  const EventCard({
    super.key,
    this.child,
    this.device = ScreenType.mobile,
  });

  /// The screen type for responsive design.
  final ScreenType device;

  /// The child widget to display inside the card.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    double spaceMobTab20_22 = Dimens.space16;

    switch (device) {
      case ScreenType.tablet:
        spaceMobTab20_22 = Dimens.space22;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }
    return Container(
      margin: const EdgeInsets.only(top: Dimens.size2),
      padding: spaceMobTab20_22.padding,
      child: child,
    );
  }
}
