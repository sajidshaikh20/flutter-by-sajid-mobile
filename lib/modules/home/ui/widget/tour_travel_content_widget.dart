import '../../../../utils/exports.dart';

/// Tour & Travel tab content: 3-item grid (Train, Flight, Bus) + row (Hotel + plane banner).
class TourTravelContentWidget extends StatelessWidget {
  /// Creates a tour travel content widget.
  const TourTravelContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ServiceItemModel> all = ServiceItemModel.tourAndTravel;
    final List<ServiceItemModel> topRow = all.sublist(0, 3);
    final ServiceItemModel hotelItem = all[3];

    return Column(
      children: <Widget>[
        ServicesGridWidget(services: topRow),
        Dimens.space12.heightBox,
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ServiceGridItemWidget(
                  label: hotelItem.label,
                  icon: hotelItem.icon,
                ),
              ),
              Dimens.space12.widthBox,
               const Expanded(
                flex: Dimens.flex2,
                child: TourTravelPlaneBannerWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
