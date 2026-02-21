import '../../../utils/exports.dart';

@RoutePage()
class BankTransferPage extends BaseResponsiveView {
  const BankTransferPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);
  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);
  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<BankTransferCubit>(
      create: (BuildContext c) => BankTransferCubit(),
      child: const Scaffold(
        body: Center(child: Text('Bank Transfer')),
      ),
    );
  }
}
