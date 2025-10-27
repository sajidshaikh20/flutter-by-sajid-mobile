import '../../../../utils/exports.dart';

/// A widget for displaying and submitting a product review.
///
/// This widget provides UI elements for:
/// - Displaying the product information (optional if not from rate order flow)
/// - Selecting a star rating
/// - Entering a review title (if not from rate order flow)
/// - Entering review details
///
/// The widget interacts with [WriteReviewCubit] to manage state updates
/// such as rating changes, title input, and review text input.
class WriteReviewWidget extends StatelessWidget {
  /// The ID of the product being reviewed.
  final ProductListingResponse? product;

  /// Indicates if the widget is shown as part of the "Rate Order" flow.
  ///
  /// If `true`, product details from the order are shown differently
  /// and the review title field is hidden.
  final bool isFromRateOrder;

  /// The type of device for responsive UI adjustments.
  ///
  /// Defaults to [ScreenType.mobile].
  final ScreenType device;

  /// Creates a [WriteReviewWidget].
  ///
  /// [isFromRateOrder] defaults to `false` and [device] defaults to [ScreenType.mobile].
  const WriteReviewWidget({
    super.key,
    this.product,
    this.isFromRateOrder = false,
    this.device = ScreenType.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimens.space16.padding,
      child: Column(
        children: <Widget>[
          // Show product order details if not coming from Rate Order
          if (!isFromRateOrder)
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: MainConfig.appColors.lightGreyColor,
                  width: Dimens.borderWidth05,
                ),
                borderRadius:
                const BorderRadius.all(Radius.circular(Dimens.space8)),
                color: MainConfig.appColors.backgroundWhite,
              ),
              child: OrderListViewWidget(
                isFromWriteReview: true,
                product: product,
                onWriteReviewPressed: () async {
                  await context.router.push(WriteReviewRoute());
                },
              ),
            ),
          Dimens.size22.heightBox,

          // Heading
          CustomTextLabelWidget(
            label: context.appString.rateTheProductKey,
            style: context.textTheme.headlineMedium?.copyWith(
              fontSize: Dimens.fontSize18,
              fontWeight: FontWeight.w700,
              color: MainConfig.appColors.textBlackColor,
            ),
          ),
          Dimens.size36.heightBox,

          // Star rating selection with optimized buildWhen
          BlocBuilder<WriteReviewCubit, WriteReviewState>(
            buildWhen: (WriteReviewState previous, WriteReviewState current) {
              // Only rebuild when rating changes
              return previous.rating != current.rating ||
                     previous.status != current.status;
            },
            builder: (BuildContext context, WriteReviewState state) {
              return Align(
                child: WriteReviewRatingView(
                  onRatingChanged: (String rating) {
                    // Update rating in cubit
                    context
                        .read<WriteReviewCubit>()
                        .updateRating(int.parse(rating));
                  },
                  device: device,
                  currentRating: state.rating,
                ),
              );
            },
          ),
          Dimens.size26.heightBox,

          // Review title field (hidden in Rate Order flow) with optimized buildWhen
          if (!isFromRateOrder) ...<Widget>[
            BlocBuilder<WriteReviewCubit, WriteReviewState>(
              buildWhen: (WriteReviewState previous, WriteReviewState current) {
                // Only rebuild when title-related fields change
                return previous.titleTextController != current.titleTextController ||
                       previous.titleFocusNode != current.titleFocusNode ||
                       previous.titleTextController.text != current.titleTextController.text ||
                       previous.status != current.status;
              },
              builder: (BuildContext context, WriteReviewState state) {
                return CommonTextFormFieldWidget(
                  input: TextInputAction.next,
                  maxLength: Dimens.maxLength50,
                  onTextSubmit: (String p0) {
                    context
                        .read<WriteReviewCubit>()
                        .moveToNextField(state.writeReviewFocusNode);
                  },
                  focusNode: state.titleFocusNode,
                  label: context.appString.titleKey,
                  controller: state.titleTextController,
                );
              },
            ),
            Dimens.size24.heightBox,
          ],

          // Review details text area with optimized buildWhen
          BlocBuilder<WriteReviewCubit, WriteReviewState>(
            buildWhen: (WriteReviewState previous, WriteReviewState current) {
              // Only rebuild when review-related fields change
              return previous.writeReviewTextController != current.writeReviewTextController ||
                     previous.writeReviewFocusNode != current.writeReviewFocusNode ||
                     previous.formKey != current.formKey ||
                     previous.writeReviewTextController.text != current.writeReviewTextController.text ||
                     previous.status != current.status;
            },
            builder: (BuildContext context, WriteReviewState state) {
              return MyOrderCancelWriteReviewView(
                focusNode: state.writeReviewFocusNode,
                formKey: state.formKey,
                controller: state.writeReviewTextController,
                isTitleVisible: false,
                device: device,
              );
            },
          ),
        ],
      ),
    );
  }
}
