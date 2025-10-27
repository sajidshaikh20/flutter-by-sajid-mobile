import '../../../../utils/exports.dart';

/// Widget that displays detailed review and rating information.
class ReviewRatingDetailsCard extends StatelessWidget {
  /// The review data to display.
  final ReviewCommon? review;

  /// The screen type for responsive design.
  final ScreenType device;

  /// Creates a review rating details card.
  const ReviewRatingDetailsCard(
      {super.key, this.review, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    double sizeMobTab8_16 = Dimens.size8;

    // Calculate time ago from createdAt
    String timeAgo = _calculateTimeAgo(review?.createdAt,context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                color: MainConfig.appColors.iceBlueColor,
              ),
              padding: const EdgeInsets.all(Dimens.space7),
              child: Assets.svgs.icDUser.svg(),
            ),
            sizeMobTab8_16.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextLabelWidget(
                    maxLines: Dimens.maxLines01,
                    overflow: TextOverflow.ellipsis,
                    label: review?.name ?? context.appString.anonymousUserKey,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: MainConfig.appColors.textBlackColor,
                      fontWeight: FontWeight.w700,
                      height:
                          Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                      fontSize: Dimens.fontSize14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Dimens.size4.heightBox,
                  // Added spacing for consistency
                  Row(
                    children: <Widget>[
                      CommonRatingIndicator(
                        rating: review?.stars?.toDouble() ?? 0.0,
                        itemSize: 16,
                      ),
                      Dimens.size4.widthBox,
                      CustomTextLabelWidget(
                        maxLines: Dimens.maxLines02,
                        overflow: TextOverflow.ellipsis,
                        label: timeAgo,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: MainConfig.appColors.textDarkBlackColor,
                          height: Dimens.lineHeight14
                              .toLineHeight(Dimens.fontSize12),
                          fontSize: Dimens.fontSize12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Dimens.size1.heightBox,
                ],
              ),
            ),
          ],
        ),
        Dimens.size8.heightBox,
        CustomTextLabelWidget(
          maxLines: Dimens.maxLines02,
          overflow: TextOverflow.ellipsis,
          label: review?.ratingDetail ?? context.appString.dummyRatingTitleKey,
          style: context.textTheme.headlineMedium?.copyWith(
            height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
            fontSize: Dimens.fontSize14,
            fontWeight: FontWeight.w700,
            color: Colors.black
          ),
          textAlign: TextAlign.start,
        ),
        Dimens.size8.heightBox,
        CustomTextLabelWidget(
          label: review?.detail ?? context.appString.dummyRatingDescKey,
          style: context.textTheme.headlineMedium?.copyWith(
            height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
            fontSize: Dimens.fontSize14,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.start,
        ),
        Dimens.size8.heightBox,
      ],
    );
  }

  /// Helper method to calculate time ago from createdAt string
  String _calculateTimeAgo(String? createdAt, BuildContext context) {
    if (createdAt == null || createdAt.isEmpty) {
      return context.appString.minsAgoKey;
    }

    try {
      final DateTime reviewDate = DateTime.parse(createdAt);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(reviewDate);

      if (difference.inDays > 0) {
          return '${difference.inDays} ${difference.inDays == 1 ? context.appString.dayKey : context.appString.daysKey} ${context.appString.agoKey}';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? context.appString.hourKey : context.appString.hoursKey} ${context.appString.agoKey}';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? context.appString.minKey : context.appString.minsKey} ${context.appString.agoKey}';
      } else {
        return context.appString.justNowKey;
      }
    } on Exception {
      return context.appString.minsAgoKey;
    }
  }
}
