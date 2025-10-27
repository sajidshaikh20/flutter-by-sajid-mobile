import '../../../../utils/exports.dart';

/// A widget that displays the rating and review of an order.
///
/// This widget can be used to show a customer's rating and textual review
/// for a specific order.
class OrderRatingWidget extends StatelessWidget {
  /// The rating of the order, typically on a scale (e.g., 0.0 to 5.0).
  final double? orderRating;

  /// The textual review provided for the order.
  final String? orderReview;

  /// Creates an [OrderRatingWidget].
  ///
  /// Both [orderRating] and [orderReview] are required.
  const OrderRatingWidget({
    super.key,
    required this.orderRating,
    required this.orderReview,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecorationExtension.customDecoration(
            borderRadius: Dimens.radius8.borderRadius,
            border: Border.all(
                color: MainConfig.appColors.lightGreyColor,
                width: Dimens.borderWidth05)),
        padding: Dimens.space8.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          CustomTextLabelWidget(
            label: context.appString.orderRatingsKey,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: MainConfig.appColors.textBlackColor,
              height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
              fontSize: Dimens.fontSize16,
            ),
          ),
          Dimens.size12.heightBox,
          CommonRatingIndicator(
            rating: orderRating ?? 0,
            itemSize: Dimens.size16,
          ),
          Dimens.size7.heightBox,
          CustomTextLabelWidget(
            label: orderReview.toString(),
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: MainConfig.appColors.textBlackColor,
              height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
              fontSize: Dimens.fontSize14,
            ),
            textAlign: isLanguageAlignmentLTR ? TextAlign.left: TextAlign.right,
          ),
        ],
        ),
      ),
    );
  }
}