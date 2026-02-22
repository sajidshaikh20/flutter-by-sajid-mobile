import '../../../../utils/exports.dart';
import 'widget/service_details_app_bar.dart';

/// Service details page; content depends on [serviceType] (e.g. AEPS Aadhaar Pay or DMT flow).
@RoutePage()
class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({
    super.key,
    required this.serviceType,
    this.showRightIcon = true,
    this.onRightIconTap,
  });

  /// Which service flow to show.
  final ServiceDetailType serviceType;

  /// Whether to show the right-side icon. Defaults to true.
  final bool showRightIcon;

  /// Callback when right icon is tapped.
  final VoidCallback? onRightIconTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceDetailsCubit>(
      create: (BuildContext c) => ServiceDetailsCubit(serviceType),
      child: ServiceDetailsView(
        showRightIcon: showRightIcon,
        onRightIconTap: onRightIconTap,
      ),
    );
  }
}


