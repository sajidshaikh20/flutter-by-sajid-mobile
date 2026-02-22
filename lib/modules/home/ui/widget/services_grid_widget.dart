import '../../../../utils/exports.dart';

/// Grid of service items (e.g. Banking, Recharge, or Tour top row).
class ServicesGridWidget extends StatelessWidget {
  /// Creates a services grid widget.
  const ServicesGridWidget({
    super.key,
    required this.services,
  });

  /// List of service items to display.
  final List<ServiceItemModel> services;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Dimens.crossAxisCount3,
        mainAxisSpacing: Dimens.space10,
        crossAxisSpacing: Dimens.space10,
        childAspectRatio: Dimens.serviceGridChildAspectRatio,
      ),
      itemCount: services.length,
      itemBuilder: (BuildContext context, int index) {
        final ServiceItemModel item = services[index];
        return ServiceGridItemWidget(
          label: item.label,
          icon: item.icon,
          onTap: item.serviceDetailType != null
              ? () async {
                  await context.router.push(
                    ServiceDetailsRoute(serviceType: item.serviceDetailType!),
                  );
                }
              : null,
        );
      },
    );
  }
}
