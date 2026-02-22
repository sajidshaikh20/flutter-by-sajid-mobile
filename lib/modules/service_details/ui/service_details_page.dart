import '../../../../utils/exports.dart';

/// Service details page; content depends on [serviceType] (e.g. AEPS Aadhaar Pay or DMT flow).
@RoutePage()
class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({super.key, required this.serviceType});

  /// Which service flow to show.
  final ServiceDetailType serviceType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceDetailsCubit>(
      create: (BuildContext c) => ServiceDetailsCubit(serviceType),
      child: const _ServiceDetailsView(),
    );
  }
}

class _ServiceDetailsView extends StatelessWidget {
  const _ServiceDetailsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
      builder: (BuildContext context, ServiceDetailsState state) {
        return Scaffold(
          body: _buildContent(context, state.serviceType),
        );
      },
    );
  }
  Widget _buildContent(BuildContext context, ServiceDetailType type) {
    switch (type) {
      case ServiceDetailType.aepsAadhaarPay:
        return const ServiceDetailsAepsContent();
      case ServiceDetailType.dmt:
        return const ServiceDetailsDmtContent();
    }
  }
}
