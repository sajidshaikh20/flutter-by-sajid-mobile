import '../../../../utils/exports.dart';

/// Widget that displays a rating with stars and count.
class CommonRatingWidget extends StatelessWidget {
  /// The number of ratings.
  final int? ratingCount;

  /// The rating value out of 5.
  final double? rating;

  /// Creates a common rating widget.
  ///
  /// [rating] The rating value out of 5.
  /// [ratingCount] The number of ratings.
  const CommonRatingWidget({super.key, this.rating, this.ratingCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: Dimens.space5.padding,
        child: Align(
            alignment: context.isEnglishLanguage? Alignment.bottomLeft: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.space4, vertical: Dimens.space1),
              decoration: BoxDecoration(
                  color: MainConfig.appColors.backGroundForRatingColor,
                  borderRadius: Dimens.radius4.borderRadius // Background color
                  ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextLabelWidget(
                      maxLines: Dimens.maxLines01,
                      overflow: TextOverflow.ellipsis,
                      label: rating != null ? rating!.toStringAsFixed(1) : '', // formats to 1 decimal place
                      style: context.textTheme.headlineMedium?.copyWith(
                        height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                        fontSize: Dimens.fontSize12,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimens.space3),
                      child: Assets.svgs.icDStar
                          .svg(height: Dimens.size9, width: Dimens.size9),
                    ),
                    const SizedBox(
                      height: Dimens.size11,
                      child: VerticalDivider(
                        thickness:  Dimens.size05,
                        width: Dimens.size0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: Dimens.size3,
                    ),
                    CustomTextLabelWidget(
                      maxLines: Dimens.maxLines01,
                      overflow: TextOverflow.ellipsis,
                      label: ratingCount.toString(),
                      style: context.textTheme.headlineMedium?.copyWith(
                          height: Dimens.lineHeight14
                              .toLineHeight(Dimens.fontSize12),
                          fontSize: Dimens.fontSize12,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            )));
  }
}
