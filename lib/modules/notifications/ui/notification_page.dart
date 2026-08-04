import '../../../utils/exports.dart';
import 'notification_view.dart';

@RoutePage()
/// Notifications Page displaying alerts, updates, and messages.
class NotificationPage extends BaseResponsiveView {
  const NotificationPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return const NotificationView();
  }
}
