import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays detailed information about a product.
class ProductDetailsPage extends StatelessWidget {
  /// The entity ID of the product to display.
  final int entityId;

  /// The index of the product in a list (optional).
  final int? index;

  /// Whether the page was opened from a notification.
  final bool? isFromNotification;

  /// Creates a product details page.
  const ProductDetailsPage({super.key,
    @PathParam('entityId') required this.entityId,
    this.index = -1,
    this.isFromNotification = false});

  /// Builds the product details page with BlocProvider.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailsCubit>(
      create: (BuildContext context) => ProductDetailsCubit(
          entityId: entityId,
          wishlistCartRepository: WishlistCartRepositoryImpl(),
          detailsRepository: ProductDetailsRepositoryImpl()),
      child: ProductDetailsWidget(
        entityId: entityId,
        index: index,
      ),
    );
  }
}
