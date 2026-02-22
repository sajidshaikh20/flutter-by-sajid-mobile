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
          appBar: AppBar(
            title: Text(_title(state.serviceType)),
          ),
          body: _buildContent(context, state.serviceType),
        );
      },
    );
  }

  String _title(ServiceDetailType type) {
    switch (type) {
      case ServiceDetailType.aepsAadhaarPay:
        return 'AEPS Aadhaar Pay';
      case ServiceDetailType.dmt:
        return 'DMT';
    }
  }

  Widget _buildContent(BuildContext context, ServiceDetailType type) {
    switch (type) {
      case ServiceDetailType.aepsAadhaarPay:
        return _buildAepsContent(context);
      case ServiceDetailType.dmt:
        return _buildDmtContent(context);
    }
  }

  Widget _buildAepsContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space20),
        child: CustomTextLabelWidget(
          label: 'AEPS Aadhaar Pay flow – add your screens here.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: MainConfig.appColors.textBlackColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDmtContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space20),
        child: CustomTextLabelWidget(
          label: 'DMT flow – add your screens here.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: MainConfig.appColors.textBlackColor,
          ),
        ),
      ),
    );
  }
}
