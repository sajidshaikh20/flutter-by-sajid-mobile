import '../../../utils/exports.dart';

/// A page for writing product reviews.
///
/// This page adapts to different screen sizes (mobile, tablet, desktop)
/// by extending [BaseResponsiveView]. It uses a [WriteReviewCubit] to
/// manage the review writing state and submission process.
@RoutePage()
class WriteReviewPage extends BaseResponsiveView {
  /// The product detail
final ProductListingResponse? product;

  /// Indicates if this page was opened from a "Rate Order" flow.
  final bool isFromRateOrder;

  /// The order ID when rating an order.
  final int? orderId;

  /// Creates a [WriteReviewPage].
  ///
  /// All parameters are optional, but providing product details will
  /// improve the review writing experience for the user.
  const WriteReviewPage({
    super.key,
    this.product,
    this.isFromRateOrder = false,
    this.orderId,
  });

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context, ScreenType.tablet);
  }

  /// Builds the main review-writing view for the given [device] type.
  ///
  /// Wraps the [WriteReviewUi] in a [BlocProvider] so that it has access
  /// to a [WriteReviewCubit] and the necessary state to manage review writing.
  Widget _buildView(BuildContext context, ScreenType device) {
    return BlocProvider<WriteReviewCubit>(
      create: (BuildContext context) => WriteReviewCubit(
        repository: WriteReviewRepositoryImpl(),
        initialState: WriteReviewState(
          status: BaseStateStatus.initial,
          formKey: GlobalKey<FormState>(),
          writeReviewTextController: TextEditingController(),
          titleTextController: TextEditingController(),
          rating: 0,
          titleFocusNode: FocusNode(),
          writeReviewFocusNode: FocusNode(),
          product: product,
          isFromRateOrder: isFromRateOrder,
          orderId: orderId,
        ),
      ),
      // Removed `const` so the UI rebuilds with state changes
      child: const WriteReviewUi(),
    );
  }
}
