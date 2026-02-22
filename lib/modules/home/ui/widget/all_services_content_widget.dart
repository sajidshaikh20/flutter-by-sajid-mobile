import '../../../../utils/exports.dart';

/// Content widget that displays services based on the selected tab.
class AllServicesContentWidget extends StatelessWidget {
  /// Creates an all services content widget.
  const AllServicesContentWidget({
    super.key,
    required this.selectedTab,
  });

  /// Currently selected service category tab.
  final ServiceCategoryTab selectedTab;

  @override
  Widget build(BuildContext context) {
    switch (selectedTab) {
      case ServiceCategoryTab.bankingServices:
        return ServicesGridWidget(
          services: ServiceItemModel.bankingServices,
        );
      case ServiceCategoryTab.rechargeAndBillPay:
        return ServicesGridWidget(
          services: ServiceItemModel.rechargeAndBillPay,
        );
      case ServiceCategoryTab.tourAndTravel:
        return const TourTravelContentWidget();
    }
  }
}
