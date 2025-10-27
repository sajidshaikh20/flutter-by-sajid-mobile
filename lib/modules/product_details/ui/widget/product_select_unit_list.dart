import '../../../../utils/exports.dart';

/// Widget that displays a list of product units/variants for selection.
class ProductSelectUnitList extends StatelessWidget {
  /// Creates a product select unit list widget.
  const ProductSelectUnitList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Dimens.size12.heightBox,
        CustomTextLabelWidget(
          textAlign: TextAlign.start,
          label: context.appString.selectUnitKey,
          style: context.textTheme.headlineMedium
              ?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: Dimens.fontSize12,
            height: Dimens.lineHeight14
                .toLineHeight(Dimens.fontSize12),
          ),
        ),
        Dimens.size8.heightBox,
        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (BuildContext context, ProductDetailsState state) {
            // Don't show unit selection if there's only one unit (single product)
            if (state.availableUnits.length <= 1) {
              return const SizedBox.shrink();
            }
            
            return SizedBox(
              height: Dimens.size54,
              child: CustomListView(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final ProductVariantDukkan unit = state.availableUnits[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: Dimens.size8),
                    child: ProductSelectUnitWidget(
                      count: state.cartCount,
                      onTap: () {
                        context
                            .read<ProductDetailsCubit>()
                            .selectUnit(index);
                      },
                      isSelect: unit.isSelected,
                      price: unit.formattedPrice ?? unit.formattedFinalPrice ?? '',
                      quantityLabel: unit.quantityLabel ?? unit.name ?? '',
                    ),
                  );
                },
                itemCount: state.availableUnits.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
