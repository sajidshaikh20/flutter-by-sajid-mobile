import '../../../utils/exports.dart';


@RoutePage()
/// Displays the details of a user's order in a responsive layout.
class MyOrderDetailPage extends BaseResponsiveView {
  /// Constructs a MyOrderDetailPage with the given order item.
  const MyOrderDetailPage({
    required this.orderId,
    super.key,
  });

  /// Holds the details of the order to be displayed on the page.
  final int? orderId;

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      _buildView(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      _buildView(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      _buildView(context, ScreenType.tablet);

  Widget _buildView(BuildContext context, ScreenType device)
  => BlocProvider<MyOrderDetailCubit>(
        create: (BuildContext context) => MyOrderDetailCubit(
          repository: MyOrderDetailRepositoryImpl(),
          initialState: MyOrderDetailState(
            status: BaseStateStatus.initial,
            orderId: orderId,
          ),
          orderId: orderId,
        ),
        child: MyOrderDetail(device: device),
      );
}
