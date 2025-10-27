import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the user's wishlist.
class WishListPage extends BaseResponsiveView {
  /// Creates a wishlist page.
  const WishListPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildViews(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildViews(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildViews(context, ScreenType.tablet);
  }

  /// Builds the wishlist view with BlocProvider for the specified device type.
  Widget buildViews(BuildContext context, ScreenType device) {
    return BlocProvider<WishListCubit>(
        create: (BuildContext c) => WishListCubit(),
        child: WishlistPageWidget(
          device: device,
        ));
  }
}
