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
      child: Scaffold(
        appBar: AppBar(title: Text(context.appString.navWishlistKey)),
        body: const Center(child: Text('Wishlist')),
      ),
    );
  }
}
