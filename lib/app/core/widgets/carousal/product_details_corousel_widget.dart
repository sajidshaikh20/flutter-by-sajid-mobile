import '../../../../utils/exports.dart';

/// A widget for displaying a carousel of product images with indicators.
class ProductDetailsCarouselWidget extends StatefulWidget {
  /// The list of image URLs or assets to display in the carousel.
  final List<String> imagesList;
  /// The id of product.
  final int id;
  /// The height of the carousel. Defaults to 156.
  final double? height;
  /// Whether the image URLs are mobile URLs.
  final bool isMobileUrl;
  /// The fit for the images within the carousel. Defaults to BoxFit.fill.
  final BoxFit? imageFit;
  /// The fraction of the viewport that each page should occupy. Defaults to 1.
  final double viewportFraction;
  /// Whether viewport actions are required (e.g., margins on the first/last items).
  final bool isViewPortActionRequired;
  /// The background color for the image container. Defaults to white.
  final Color? imageBgColor;
  /// Callback function when an image is clicked.
  final Function(
      String imageUrl,
      int index,
      )? onImageCLick;
  /// The screen type (mobile, tablet, etc.). Defaults to mobile.
  final ScreenType? device;

  /// Creates a [ProductDetailsCarouselWidget].
  ///
  /// Args:
  /// * [imagesList]: The list of image URLs or assets.
  /// * [height]: The height of the carousel.
  /// * [onImageCLick]: Callback when an image is clicked.
  /// * [isMobileUrl]: Whether the image URLs are mobile URLs.
  /// * [device]: The screen type.
  /// * [imageFit]: The fit for the images.
  /// * [viewportFraction]: The viewport fraction for each page.
  /// * [imageBgColor]: The background color of the image container.
  /// * [isViewPortActionRequired]: Whether viewport actions are needed.
  ///
  /// Example :
  /// ProductDetailsCarouselWidget(imagesList);
   ProductDetailsCarouselWidget(this.imagesList,this.id,
      {super.key,
        this.height,
        this.onImageCLick,
        this.isMobileUrl = false,
        this.device = ScreenType.mobile,
        this.imageFit = BoxFit.fill,
        this.viewportFraction = 1,
        Color? imageBgColor,
        this.isViewPortActionRequired = false})
   : imageBgColor =imageBgColor?? MainConfig.appColors.backgroundWhite;

  @override
  State<ProductDetailsCarouselWidget> createState() =>
      _ProductDetailsCarouselWidgetState();
}

class _ProductDetailsCarouselWidgetState extends State<ProductDetailsCarouselWidget> {
  late PageController _pageController;
  int currentIndex = 0;
  Timer? _timer;
  double viewportFractionInner = 1;

  @override
  void initState() {
    super.initState();
    viewportFractionInner = widget.viewportFraction;

    _pageController = PageController(
      initialPage: currentIndex,
      viewportFraction: viewportFractionInner,
    );

    _pageController.addListener(() {
      int newIndex = _pageController.page?.round() ?? 0;
      if (newIndex != currentIndex) {
        setState(() {
          currentIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  /// Build image widget that handles both local assets and network images
  Widget _buildImage(String imageUrl) {
    return CommonImageWidget(
      imagePath: imageUrl,
      fit: BoxFit.fill,
      placeHolderImage: Container(
        color: Colors.grey[300],
        child: const Icon(Icons.error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: widget.height ?? Dimens.size156,
          decoration: BoxDecoration(
              color: widget.imageBgColor,
              borderRadius: BorderRadius.circular(Dimens.space6)),
          child: PageView.builder(

              physics: const BouncingScrollPhysics(), // Ensures smooth scrolling
              padEnds: false,
              itemCount: widget.imagesList.length,
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              itemBuilder: (BuildContext context, int pagePosition) {

                double leftMargin = (pagePosition == 0) ? Dimens.space16 : Dimens.space8;
                double rightMargin = (pagePosition == widget.imagesList.length - 1) ? Dimens.space16 : 0.0;

                return KeepAlivePage(
                  child: InkWell(
                    key: ValueKey<String?>(widget.imagesList[pagePosition]),
                    splashFactory: NoSplash.splashFactory,
                    splashColor: MainConfig.appColors.transparent,
                    highlightColor: MainConfig.appColors.transparent,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    onTap: () {
                      DebugLog.instance.d('image click index: ${widget.imagesList[pagePosition]} image type id ${widget.id}');

                      widget.onImageCLick?.call(
                          widget.imagesList[pagePosition], widget.id);
                    },
                    child: Container(
                      margin: widget.isViewPortActionRequired
                          ? EdgeInsets.only(left: leftMargin, right: rightMargin)
                          : const EdgeInsets.symmetric(horizontal: Dimens.space16),
                      height: widget.height ?? Dimens.size156,
                      child: _buildImage(widget.imagesList[pagePosition]),
                    ),
                  ),
                );
              }),
        ),
        Dimens.size4.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(widget.imagesList.length, currentIndex, widget.device ?? ScreenType.mobile),
        )
      ],
    );
  }
}


/// Generates a list of indicator widgets for the carousel.
///
/// The indicators visually represent the current page in the carousel.
///
/// Args:
/// * [imagesLength]: The total number of images in the carousel.
/// * [currentIndex]: The index of the currently visible image.
/// * [device]: The screen type (mobile, tablet, etc.).
///
/// Returns:
/// A list of indicator widgets.
List<Widget> indicators(int imagesLength,int currentIndex, ScreenType device) {
  return List<Widget>.generate(imagesLength, (int index) {
    return currentIndex == index
        ? Container(
        margin: const EdgeInsets.only(right: Dimens.size2),
        width: Dimens.size8,
        height: Dimens.size4,
        decoration: BoxDecoration(
          color: MainConfig.appColors.mainColor,
          borderRadius: Dimens.radius30.borderRadius,
        ))
        : Container(
        margin: const EdgeInsets.only(right: Dimens.size2),
        width: Dimens.size4,
        height: Dimens.size4,
        decoration: BoxDecoration(
          color: MainConfig.appColors.unselectedGreyColor,
          shape: BoxShape.circle,
        ));
  });
}
