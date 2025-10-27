import '../../../../utils/exports.dart';

/// A custom carousel widget for banners that supports individual IDs for each image
class BannerCarouselWidget extends StatefulWidget {
  /// The list of image URLs to display in the carousel
  final List<String>? imagesList;
  /// The list of IDs corresponding to each image
  final List<int> idsList;
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
  final Future<void> Function(String imageUrl, int index, int id)? onImageClick;
  /// The screen type (mobile, tablet, etc.). Defaults to mobile.
  final ScreenType? device;

  /// Creates a banner carousel widget.
  ///
  /// [imagesList] The list of image URLs to display in the carousel.
  /// [idsList] The list of IDs corresponding to each image.
  /// [height] The height of the carousel. Defaults to 156.
  /// [isMobileUrl] Whether the image URLs are mobile URLs.
  /// [imageFit] The fit for the images within the carousel. Defaults to BoxFit.fill.
  /// [viewportFraction] The fraction of the viewport that each page should occupy. Defaults to 1.
  /// [imageBgColor] The background color for the images.
  /// [onImageClick] Callback function when an image is clicked.
  /// [device] The screen type (mobile, tablet, etc.). Defaults to mobile.
  BannerCarouselWidget({
    super.key,
    required this.imagesList,
    required this.idsList,
    this.height,
    this.onImageClick,
    this.isMobileUrl = false,
    this.device = ScreenType.mobile,
    this.imageFit = BoxFit.fill,
    this.viewportFraction = 1,
    Color? imageBgColor,
    this.isViewPortActionRequired = false,
  }) : imageBgColor = imageBgColor ?? MainConfig.appColors.backgroundWhite;

  @override
  State<BannerCarouselWidget> createState() => _BannerCarouselWidgetState();
}

class _BannerCarouselWidgetState extends State<BannerCarouselWidget> {
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
  Widget _buildImage(String? imageUrl) {
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
            borderRadius: BorderRadius.circular(Dimens.space6),
          ),
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            padEnds: false,
            itemCount: widget.imagesList?.length,
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            itemBuilder: (BuildContext context, int pagePosition) {
              double leftMargin = (pagePosition == 0) ? Dimens.space16 : Dimens.space8;
              double rightMargin = (pagePosition == widget.imagesList!.length - 1) ? Dimens.space16 : 0.0;

              // Get the corresponding ID for this image
              final int imageId = pagePosition < widget.idsList.length 
                  ? widget.idsList[pagePosition] 
                  : 0;

              return KeepAlivePage(
                child: InkWell(
                  key: ValueKey<String?>(widget.imagesList?[pagePosition]),
                  splashFactory: NoSplash.splashFactory,
                  splashColor: MainConfig.appColors.transparent,
                  highlightColor: MainConfig.appColors.transparent,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () async {
                    DebugLog.instance.d('Banner image click: image=${widget.imagesList?[pagePosition]}, index=$pagePosition, id=$imageId');
                    await widget.onImageClick?.call(
                      widget.imagesList![pagePosition],
                      pagePosition, 
                      imageId,
                    );
                  },
                  child: Container(
                    margin: widget.isViewPortActionRequired
                        ? EdgeInsets.only(left: leftMargin, right: rightMargin)
                        : const EdgeInsets.symmetric(horizontal: Dimens.space16),
                    height: widget.height ?? Dimens.size156,
                    child: _buildImage(widget.imagesList?[pagePosition]),
                  ),
                ),
              );
            },
          ),
        ),
        Dimens.size4.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerIndicators(widget.imagesList!.length, currentIndex, widget.device ?? ScreenType.mobile),
        ),
      ],
    );
  }
}

/// Generates a list of indicator widgets for the carousel.
List<Widget> bannerIndicators(int imagesLength, int currentIndex, ScreenType device) {
  return List<Widget>.generate(imagesLength, (int index) {
    return currentIndex == index
        ? Container(
            margin: const EdgeInsets.only(right: Dimens.size2),
            width: Dimens.size8,
            height: Dimens.size4,
            decoration: BoxDecoration(
              color: MainConfig.appColors.mainColor,
              borderRadius: Dimens.radius30.borderRadius,
            ),
          )
        : Container(
            margin: const EdgeInsets.only(right: Dimens.size2),
            width: Dimens.size4,
            height: Dimens.size4,
            decoration: BoxDecoration(
              color: MainConfig.appColors.unselectedGreyColor,
              shape: BoxShape.circle,
            ),
          );
  });
}
