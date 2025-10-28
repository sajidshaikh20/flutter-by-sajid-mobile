
import '../../../../utils/exports.dart';

/// A widget that displays a list of hot deal products.
///
/// Each product can have cart operations (add, plus, minus), like/dislike actions,
/// and variant-specific cart operations.
class HotDealsWidget extends StatelessWidget {
  /// The list of products to display in this widget.


  /// Callback when the "+" button is pressed for a product.
  ///
  /// Provides the index of the product in the list.
  final Function(int index)? onPlusPressed;

  /// Callback when the "-" button is pressed for a product.
  ///
  /// Provides the index of the product in the list.
  final Function(int index)? onMinusPressed;

  /// Callback when the "Add" button is pressed for a product.
  ///
  /// Provides the index of the product in the list.
  final Function(int index)? onAddPressed;

  /// The total number of items in the cart.
  final int cartCount;

  /// Callback when a product is liked or disliked.
  ///
  /// Provides the index of the product in the list.
  final Function(int index)? likeDislikeItemPressed;

  /// Callback for operations on a product variant in the cart.
  ///
  /// Provides the product index, variant index, and the cart operation type.
  final Function(int productIndex, int variantIndex, CartOperation operation)? onVariantCartOperation;

  /// Creates a [HotDealsWidget].
  ///
  /// All callbacks are optional. [] is required.
  /// [cartCount] defaults to 0 if not provided.
  const HotDealsWidget({
    super.key,

    this.onPlusPressed,
    this.onMinusPressed,
    this.cartCount = 0,
    this.onAddPressed,
    this.likeDislikeItemPressed,
    this.onVariantCartOperation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.size294,
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => Container(
          margin: EdgeInsets.only(
            left: index == 0 ? Dimens.space16 : Dimens.space0,
            // Add padding to the first item only
            right: Dimens.space10,
          ),
          child: const ColoredBox(color: Colors.black),
        ),
      ),
    );
  }
}
