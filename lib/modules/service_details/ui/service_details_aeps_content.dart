import '../../../../utils/exports.dart';

/// Dummy data for AEPS grid (AEPS-1, AEPS-2) – same UI as home grid.
final List<ServiceItemModel> _aepsGridItems = <ServiceItemModel>[
  ServiceItemModel(
    label: 'AEPS-1',
    icon: Assets.svgs.icStreamlineColorFingerprint2.svg(),
  ),
  ServiceItemModel(
    label: 'AEPS-2',
    icon: Assets.svgs.icStreamlineColorFingerprint2.svg(),
  ),
];

/// AEPS Aadhaar Pay flow content: grid of AEPS-1 and AEPS-2 (same UI as home grid).
class ServiceDetailsAepsContent extends StatelessWidget {
  const ServiceDetailsAepsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.space38,
          horizontal: Dimens.space20),
      child: ServicesDetailsGridview(
        services: _aepsGridItems,
      ),
    );
  }
}
