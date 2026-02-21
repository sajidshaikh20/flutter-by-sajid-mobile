import '../../../utils/exports.dart';

@RoutePage()
class MyAccountPage extends BaseResponsiveView {
  const MyAccountPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);
  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);
  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<MyAccountCubit>(
      create: (BuildContext ctx) => MyAccountCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.appString.navAccountKey)),
        body: const Center(child: Text('My Account')),
      ),
    );
  }
}
