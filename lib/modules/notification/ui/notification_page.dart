import '../../../utils/exports.dart';

@RoutePage()
class NotificationPage extends BaseResponsiveView {
  const NotificationPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);
  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);
  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<NotificationCubit>(
      create: (BuildContext context) => NotificationCubit(),
      child: const Scaffold(
        body: Center(child: Text('Notifications')),
      ),
    );
  }
}
