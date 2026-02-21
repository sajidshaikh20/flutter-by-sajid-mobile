import '../../../utils/exports.dart';

@RoutePage()
class WishListPage extends BaseResponsiveView {
  const WishListPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);
  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);
  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<WishListCubit>(
      create: (BuildContext c) => WishListCubit(),
      child: const Scaffold(
        body: Center(child: Text('Wishlist')),
      ),
    );
  }
}
