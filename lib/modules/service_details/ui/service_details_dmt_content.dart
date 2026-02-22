import '../../../../utils/exports.dart';
import 'widget/service_details_grid_content.dart';

/// DMT grid items: DMT-1, DMT-2, DMT-3 (same grid layout as AEPS).
final List<ServiceItemModel> dmtGridItems = <ServiceItemModel>[
  ServiceItemModel(
    label: 'DMT-1',
    icon: Assets.svgs.icDmt.svg(),
  ),
  ServiceItemModel(
    label: 'DMT-2',
    icon: Assets.svgs.icDmt.svg(),
  ),
];

/// DMT flow content: grid of DMT-1, DMT-2, DMT-3.
class ServiceDetailsDmtContent extends StatelessWidget {
  const ServiceDetailsDmtContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceDetailsGridContent(
      services: dmtGridItems,
      onItemTap: (BuildContext context, ServiceItemModel item) {
        displaySnackBar('${item.label} – coming soon', context);
      },
    );
  }
}
