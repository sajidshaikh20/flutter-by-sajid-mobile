import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays wallet information including balance and transaction history.
class MyWalletPage extends BaseResponsiveView {
  /// Creates a my wallet page.
  const MyWalletPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      _buildView(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      _buildView(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      _buildView(context, ScreenType.tablet);

  Widget _buildView(BuildContext context, ScreenType device) => BlocProvider<MyWalletCubit>(
        create: (BuildContext context) => MyWalletCubit(
          initialState: const MyWalletState(
            status: BaseStateStatus.initial,
            walletAmount: '0',
            collection: <String>['', ''],
            isVisible: true,
          ),
          myWalletRepository: MyWalletRepositoryImpl(),
        ),
        child: MyWalletView(
          device: device,
        ),
      );
}
