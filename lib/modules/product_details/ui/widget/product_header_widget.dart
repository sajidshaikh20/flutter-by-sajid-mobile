import '../../../../utils/exports.dart';

/// Widget that displays the product header with image carousel and basic info.
class ProductHeaderWidget extends StatelessWidget {
  /// The current product details state.
  final ProductDetailsState state;

  /// The screen type for responsive design.
  final ScreenType device;

  /// Creates a product header widget.
  const ProductHeaderWidget(
      {super.key, required this.state, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    double productDetailCarousalHeight = Dimens.size375;
    switch (device) {
      case ScreenType.tablet:
        productDetailCarousalHeight = Dimens.size500;
      default:
        break;
    }

    return Stack(
      children: <Widget>[
        ProductDetailsCarouselWidget(
          state.detailsModel?.imageGallery?.map((ImageGallery img) => img.url ?? '').toList() ?? <String>[], 0,
          height: productDetailCarousalHeight,
          onImageCLick: (String imageUrl, int index) {},
          device: device,
          imageFit: BoxFit.contain,
          imageBgColor: MainConfig.appColors.imageBgColor,
        ),
        Visibility(
          visible: state.detailsModel?.isNew?.isNotEmpty ?? false,
          child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space8),
              child: ProductCommonNewWidget(
                label: state.detailsModel?.isNew??"",
              )),
        ),
        if ((int.tryParse(state.detailsModel?.reviewCount?.toString() ?? '0') ?? 0) > 0)
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimens.space5,
                bottom: Dimens.space10,
              ),
              child: CommonRatingWidget(
                rating: state.detailsModel?.ratings ?? 0.0,
                ratingCount: int.tryParse(
                  state.detailsModel?.reviewCount?.toString() ?? '0',
                ) ?? 0,
              ),
            ),
          ),

      ],
    );
  }
}
