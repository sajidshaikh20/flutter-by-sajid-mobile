import '../../../utils/exports.dart';

/// A page that displays the list of items in the cart.
///
/// This page shows all cart items, allows quantity adjustments,
/// item removal, and proceeding to checkout or payment.
@RoutePage()
class CartListPage extends StatelessWidget {
  /// Creates a [CartListPage] instance.
  const CartListPage({super.key});


  @override
  Widget build(BuildContext context) {
   return BlocProvider<CartPageCubit>(
      create:  (BuildContext context) {
        DebugLog.instance.i('CartListPage: Creating CartPageCubit');
        return CartPageCubit(
          homeRepository: HomeRepositoryImpl(),
          countCubit: context.read<CartCountCubit>(),
          wishlistCartRepository: WishlistCartRepositoryImpl(),
          cartPageRepository: CartPageRepositoryImpl(),
        );
      },
     child: const CartListPageWidget(),
    );


  }
}
