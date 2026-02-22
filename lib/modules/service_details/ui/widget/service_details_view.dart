import '../../../../utils/exports.dart';

class ServiceDetailsView extends StatelessWidget {
  const ServiceDetailsView({
    super.key,
    this.showRightIcon = true,
    this.onRightIconTap,
  });

  final bool showRightIcon;
  final VoidCallback? onRightIconTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
      builder: (BuildContext context, ServiceDetailsState state) {
        return Scaffold(
          backgroundColor: MainConfig.appColors.backgroundWhiteColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ServiceDetailsAppBar(
                label: state.serviceType.displayLabel.toUpperCase(),
                showRightIcon: showRightIcon,
                onRightIconTap: onRightIconTap,
              ),
              Expanded(
                child: _buildContent(context, state.serviceType),
              ),
            ],
          ),
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
