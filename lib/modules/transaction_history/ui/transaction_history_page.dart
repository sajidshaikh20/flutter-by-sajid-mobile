import '../../../utils/exports.dart';

@RoutePage()
class TransactionHistoryPage extends BaseResponsiveView {
  const TransactionHistoryPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);
  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);
  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<TransactionHistoryCubit>(
      create: (BuildContext c) => TransactionHistoryCubit(),
      child:  Scaffold(
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Transaction History'),
            Assets.svgs.icLoan.svg(
              height: 20,
              color: Colors.red
            )
          ],
        )),
      ),
    );
  }
}
