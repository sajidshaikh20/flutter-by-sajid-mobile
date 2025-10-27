import '../../../../utils/exports.dart';

/// A widget that displays a horizontal list of brand items for users to browse
/// products by brand selection.
class ShopByBrands extends StatelessWidget {
  /// The list of brands to display in the horizontal scroll view.
  final List<ListOfBrandsResponse> brandsList;

  /// Callback function triggered when a brand is tapped.
  /// Receives the brand ID and brand name as parameters.
  final Function(int brandId, String brandName)? onBrandTap;

  /// Creates a [ShopByBrands] widget.
  ///
  /// [brandsList] is required and contains the brands to display.
  /// [onBrandTap] is optional and handles brand selection.
  const ShopByBrands({
    super.key,
    required this.brandsList,
    this.onBrandTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.size78,
      child: ListView.builder(
        itemCount: brandsList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final ListOfBrandsResponse brand = brandsList[index];
          return GestureDetector(
            onTap: () {
              if (onBrandTap != null && brand.id != null) {
                onBrandTap!(brand.id!, brand.brandLabel ?? '');
              }
            },
            child: Container(
                margin: EdgeInsets.only(
                  left: index == 0 ? Dimens.space16 : Dimens.space0,
                  right: Dimens.space10,
                ),
                width: Dimens.size78,
                height: Dimens.size78,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(
                    color: MainConfig.appColors.dividerGreyColor,
                    width: Dimens.borderWidth05,
                  ),
                  borderRadius: Dimens.radius8.borderRadius,
                ),
                child: CustomNetworkImageWidget(
                  imageUrl: brand.brandImage??"",
                  width: Dimens.size78,
                  height: Dimens.size78,
                  fit: BoxFit.contain,
                  placeHolderImage: Assets.svgs.icPlaceHolderDukkan.svg(),
                  isShowPlaceHolder: true,
                )
            ),
          );
        },
      ),
    );
  }
}
