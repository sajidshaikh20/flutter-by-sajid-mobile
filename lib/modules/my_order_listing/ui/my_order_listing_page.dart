import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays a list of user's orders with filtering and pagination.
class MyOrderListingPage extends BaseResponsiveView {
  /// Creates a my order listing page.
  const MyOrderListingPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context,ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context,ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context,ScreenType.tablet);
  }

  BlocProvider<MyOrderListCubit> _buildView(BuildContext context,ScreenType device) {
    return BlocProvider<MyOrderListCubit>(
      create: (BuildContext context) => MyOrderListCubit(cartCountCubit: context.read<CartCountCubit>()),
      child:  MyOrderListingPageWidget(device:device),
    );
  }
}
