import '../../../../utils/exports.dart';

/// Widget that displays individual review and rating cards with expandable content.
class MyReviewAndRatingCardWidget extends StatefulWidget {
  /// Creates a review and rating card widget.
  const MyReviewAndRatingCardWidget({
    super.key,
    this.reviewRatingList,
    this.index,
  });

  /// List of review and rating response models.
  final List<ListOfMyReviewsRatingResponseModel>? reviewRatingList;

  /// Index of the current item in the list.
  final int? index;

  @override
  // ignore: library_private_types_in_public_api, reason: This is standard Flutter practice to return a private State subclass
  _MyReviewAndRatingCardWidgetState createState() =>
      _MyReviewAndRatingCardWidgetState();
}

class _MyReviewAndRatingCardWidgetState extends State<MyReviewAndRatingCardWidget> {
  bool isExpanded = false; // Ensures the review always starts collapsed


  @override
  Widget build(BuildContext context) {
    // Get the review data from the list using the index
    final ListOfMyReviewsRatingResponseModel? review = 
        (widget.reviewRatingList != null && widget.index != null && 
         widget.index! < widget.reviewRatingList!.length) 
            ? widget.reviewRatingList![widget.index!] 
            : null;
    
    // Use actual review data or fallback to constants
    final String reviewText = review?.detail ?? '';
    final String productName = review?.ratingDetail ?? '';

    final double rating = review?.stars ?? 0.0;

    final String reviewDate = utcToDateFormate(review?.createdAt ?? '', DateConstants.dateMonthYearOnlyFormat);

    final String image = review?.image ?? '';

    String displayText = isExpanded || reviewText.length <= AppConstant.maxPreviewLength
        ? reviewText
        : "${reviewText.substring(0, AppConstant.maxPreviewLength)}...";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
          Container(
                  height: Dimens.size54,
                  width: Dimens.size54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: image.isEmpty ? MainConfig.appColors.backgroundPrimaryColor : MainConfig.appColors.backgroundWhite ,
                  ),
                  child: image.isNotEmpty
                      ? ClipOval(
                          child: FastCachedCustomNetwork(
                            imageUrl: image,
                            placeHolderImage: Assets.svgs.icPlaceHolderDukkan.svg(),
                            isShowPlaceHolder: true,
                          ),
                        )
                      : Center(
                          child: Assets.svgs.icDUser.svg(
                            height: Dimens.size24,
                            width: Dimens.size24,
                            colorFilter: ColorFilter.mode(
                              MainConfig.appColors.textWhiteColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                ),
            Dimens.size8.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextLabelWidget(
                    textDirection: TextDirection.ltr,
                    maxLines: Dimens.maxLines01,
                    overflow: TextOverflow.ellipsis,
                    label: productName,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: MainConfig.appColors.textBlackColor,
                      fontWeight: FontWeight.w700,
                      height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                      fontSize: Dimens.fontSize14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Dimens.size4.heightBox,
                  Row(
                    children: <Widget>[
                      CommonRatingIndicator(
                        rating: rating,
                        itemSize: 16,
                      ),
                      Dimens.size4.widthBox,
                      CustomTextLabelWidget(
                        textDirection: TextDirection.ltr,
                        maxLines: Dimens.maxLines02,
                        overflow: TextOverflow.ellipsis,
                        label: reviewDate,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: MainConfig.appColors.textDarkBlackColor,
                          height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
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
        RichText(
          text: TextSpan(
            style: context.textTheme.headlineMedium?.copyWith(
              color: MainConfig.appColors.textBlackColor,
              height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
              fontSize: Dimens.fontSize14,
              fontWeight: FontWeight.w400,
            ),
            children: <InlineSpan>[
              TextSpan(text: displayText),
              if (!isExpanded && reviewText.length > AppConstant.maxPreviewLength)
                WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = true; // Expand permanently when tapped
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: Dimens.space4),
                      child: CustomTextLabelWidget(
                        label: context.appString.moreKey,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: MainConfig.appColors.mainColor,
                          fontSize: Dimens.fontSize14,
                          height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize14),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
