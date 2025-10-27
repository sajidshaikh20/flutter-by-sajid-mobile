import '../../../../utils/exports.dart';

/// A page widget that wraps [WriteReviewWidget] and listens to review submission events.
///
/// This widget uses a [BlocListener] to respond to state changes from [WriteReviewCubit].
/// It shows success or error messages based on the API response for saving a review.
///
/// If the review is submitted successfully, a confirmation dialog is shown
/// and the page automatically navigates back once the dialog is dismissed.
class WriteReviewPageWidget extends StatelessWidget {
  /// The ID of the product being reviewed.
  final ProductListingResponse? product;

  /// The type of device on which the widget is being displayed.
  ///
  /// Defaults to [ScreenType.mobile].
  final ScreenType device;

  /// Indicates if the review is being written from the "Rate Order" flow.
  ///
  /// Defaults to `false`.
  final bool isFromRateOrder;

  /// The order ID when rating an order.
  final int? orderId;

  /// Creates a [WriteReviewPageWidget].
  ///
  /// [device] defaults to [ScreenType.mobile] and [isFromRateOrder] defaults to `false`.
  const WriteReviewPageWidget({
    super.key,
    this.product,
    this.isFromRateOrder = false,
    this.orderId,
    this.device = ScreenType.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<WriteReviewCubit, WriteReviewState>(
      listener: (BuildContext cxt, WriteReviewState state) {
        // Handle success case
        if ((state.saveReviewResponse?.success ?? false) == true) {
          if (state.saveReviewResponse?.message != null) {
            unawaited(
              showCustomMessageDialog(cxt, state.saveReviewResponse!.message)
                  .whenComplete(() {
                if (context.mounted) {
                  context.router.back();
                }
              }),
            );
          }
        }

        // Handle failure case
        if (state.status == BaseStateStatus.failure) {
          displaySnackBar(state.msg ?? "", context);
        }
      },
      child: WriteReviewWidget(
        isFromRateOrder: isFromRateOrder,
        product : product,
        device: device,
      ),
    );
  }
}
