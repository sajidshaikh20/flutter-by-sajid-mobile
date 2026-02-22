import '../../../../utils/exports.dart';
import 'services_details_gridview.dart';

/// Shared grid content for service details screens (AEPS, DMT, etc.).
/// Use this to show the same grid layout with different [services] and [onItemTap].
class ServiceDetailsGridContent extends StatelessWidget {
  const ServiceDetailsGridContent({
    super.key,
    required this.services,
    required this.onItemTap,
  });

  /// Grid items to display.
  final List<ServiceItemModel> services;

  /// Called when a grid item is tapped.
  final void Function(BuildContext context, ServiceItemModel item) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.space38,
        horizontal: Dimens.space20,
      ),
      child: ServicesDetailsGridview(
        services: services,
        onItemTap: onItemTap,
      ),
    );
  }
}
