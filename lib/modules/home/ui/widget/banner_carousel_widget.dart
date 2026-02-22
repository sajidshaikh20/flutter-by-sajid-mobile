import '../../../../utils/exports.dart';

/// Horizontal scrollable banner carousel for promotional content.
class BannerCarouselWidget extends StatelessWidget {
  /// Creates a banner carousel widget.
  const BannerCarouselWidget({super.key});

  static const Color _banner1Start = Color(0xFF1a3a2a);
  static const Color _banner1End = Color(0xFF2d6e4a);
  static const Color _banner2Start = Color(0xFF2d5a3d);
  static const Color _banner2End = Color(0xFF1a3a2a);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.size140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _BannerCard(
            width: Dimens.size260,
            child: Stack(
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: Dimens.radius15.borderRadius,
                    gradient: const LinearGradient(
                      colors: <Color>[_banner1Start, _banner1End],
                    ),
                  ),
                  child: const SizedBox.expand(),
                ),
                Positioned(
                  left: Dimens.space14,
                  top: Dimens.space18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: 'WHERE\nDO YOU WANT TO',
                        textAlign: TextAlign.start,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: MainConfig.appColors.textWhiteColor
                              .withValues(alpha: Dimens.opacity073),
                          fontSize: Dimens.fontSize10,
                          height: Dimens.fontHeight1_5,
                        ),
                      ),
                      Dimens.space2.heightBox,
                      CustomTextLabelWidget(
                        label: 'EXPLORE',
                        textAlign: TextAlign.start,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: MainConfig.appColors.textWhiteColor,
                          fontSize: Dimens.fontSize22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: Dimens.space10,
                  bottom: Dimens.space10,
                  child: Icon(
                    Icons.airplanemode_active,
                    color: MainConfig.appColors.textWhiteColor,
                    size: Dimens.size60,
                  ),
                ),
              ],
            ),
          ),
          Dimens.space10.widthBox,
          _BannerCard(
            width: Dimens.size120,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: Dimens.radius15.borderRadius,
                gradient: const LinearGradient(
                  colors: <Color>[_banner2Start, _banner2End],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.directions_bus,
                  color: MainConfig.appColors.textWhiteColor,
                  size: Dimens.size50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({
    required this.width,
    required this.child,
  });

  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: Dimens.radius15.borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: Dimens.opacity02),
            blurRadius: Dimens.blurRadius8,
            offset: const Offset(Dimens.offset0, Dimens.offset4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: Dimens.radius15.borderRadius,
        child: child,
      ),
    );
  }
}
