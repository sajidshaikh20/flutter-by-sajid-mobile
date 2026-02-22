import '../../../../utils/exports.dart';

/// Reusable grid for service details (AEPS, DMT, etc.). [onItemTap] is called when an item is tapped.
class ServicesDetailsGridview extends StatelessWidget {
  /// Creates a services grid widget.
  const ServicesDetailsGridview({
    super.key,
    required this.services,
    required this.onItemTap,
  });

  /// List of service items to display.
  final List<ServiceItemModel> services;

  /// Called when a grid item is tapped. Pass [context] and the tapped [ServiceItemModel].
  final void Function(BuildContext context, ServiceItemModel item) onItemTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Dimens.crossAxisCount3,
        mainAxisSpacing: Dimens.space10,
        crossAxisSpacing: Dimens.space10,
      ),
      itemCount: services.length,
      itemBuilder: (BuildContext context, int index) {
        final ServiceItemModel item = services[index];
        return ServiceGridItemWidget(
          label: item.label,
          icon: item.icon,
          onTap: () => onItemTap(context, item),
        );
      },
    );
  }
}
