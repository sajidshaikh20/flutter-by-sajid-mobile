import '../../../../utils/exports.dart';

/// Horizontal scrollable banner carousel using PNG images.
class BannerCarouselWidget extends StatelessWidget {
  /// Creates a banner carousel widget.
  const BannerCarouselWidget({super.key});

  static final List<String> _bannerImages = <String>[
    Assets.png.icHomeBanner1.path,
    Assets.png.icHomeBanner2.path,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.size100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _bannerImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index < _bannerImages.length - 1 ? Dimens.space10 : 0,
            ),
            child: BannerCardWidget(
              imagePath: _bannerImages[index],
            ),
          );
        },
      ),
    );
  }
}
