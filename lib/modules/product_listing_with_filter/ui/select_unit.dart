import '../../../utils/exports.dart';

/// Widget that displays product variants with selection and quantity controls.
class SelectUnit extends StatelessWidget {
  /// The list of product variants to display.
  final List<ProductVariantDukkan>? productVariants;

  /// Callback when the add button is pressed for a specific index.
  final Function(int index)? onAddPressed;

  /// Callback when the plus button is pressed for a specific index.
  final Function(int index)? onPlusPressed;

  /// Callback when the minus button is pressed for a specific index.
  final Function(int index)? onMinusPressed;

  /// Callback for variant cart operations with index and operation type.
  final Function(int variantIndex, CartOperation operation)? onVariantCartOperation;
  ///SelectUnit
  const SelectUnit({
    super.key,
    this.productVariants,
    this.onAddPressed,
    this.onPlusPressed,
    this.onMinusPressed,
    this.onVariantCartOperation,
  });

  @override
  Widget build(BuildContext context) {
    // Use productVariants if available, otherwise fallback to dummy data
    final int? itemCount = productVariants?.length;
    
    return Column(
      children: <Widget>[
        ListView.builder(
          padding:
              const EdgeInsets.only(top: Dimens.space16, bottom: Dimens.space8),
          shrinkWrap: true,
          itemCount: itemCount ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ProductListingUnitRowItem(
              productVariant: productVariants != null ? productVariants![index] : null,
              index: index,
              onAddPressed: onVariantCartOperation != null 
                  ? () => onVariantCartOperation!(index, CartOperation.add)
                  : onAddPressed != null ? () => onAddPressed!(index) : null,
              onPlusPressed: onVariantCartOperation != null 
                  ? () => onVariantCartOperation!(index, CartOperation.increase)
                  : onPlusPressed != null ? () => onPlusPressed!(index) : null,
              onMinusPressed: onVariantCartOperation != null 
                  ? () => onVariantCartOperation!(index, CartOperation.decrease)
                  : onMinusPressed != null ? () => onMinusPressed!(index) : null,
            );
          },
        ),
        CustomGradientButtonWidget(
            title: context.appString.doneKey, onTap: () {})
      ],
    );
  }
}
