import '../../../utils/exports.dart';

/// Immutable state for the Write Review screen.
class WriteReviewState extends BaseState {
  /// Form key for validation and submission.
  final GlobalKey<FormState> formKey;

  /// Controller for review details text.
  final TextEditingController writeReviewTextController;

  /// Controller for review title text.
  final TextEditingController titleTextController;

  /// Current rating value selected by the user.
  final int rating; // Change to int
  /// API response after saving a review, if available.
  final SaveReview? saveReviewResponse;

  /// The product identifier.
  final ProductListingResponse? product;

  /// Focus node for the title input field.
  final FocusNode titleFocusNode;

  /// Focus node for the review text field.
  final FocusNode writeReviewFocusNode;

  /// Whether this flow is opened from rate order screen.
  final bool isFromRateOrder;

  /// The order ID when rating an order.
  final int? orderId;

  /// Creates a [WriteReviewState].
  const WriteReviewState({
    required super.status,
    required this.formKey,
    required this.writeReviewTextController,
    required this.titleTextController,
    required this.titleFocusNode,
    required this.writeReviewFocusNode,
    required this.rating, // Keep as is
    this.saveReviewResponse,
    super.redirectRoute,
    super.msg = '',
    this.product,
    required this.isFromRateOrder,
    this.orderId,
  });

  /// Returns a copy with selectively overridden fields.
  WriteReviewState copyWith(
      {BaseStateStatus? status,
      GlobalKey<FormState>? formKey,
      TextEditingController? textController,
      TextEditingController? titleTextController,
      int? rating, // Change to int
      String? msg,
      PageRouteInfo? redirectRoute,
      String? errorMessage,
      bool? isFromRateOrder,
      int? orderId,
        ProductListingResponse? product,
      SaveReview? saveReviewResponse}) {
    return WriteReviewState(
        status: status ?? this.status,
        formKey: formKey ?? this.formKey,
        msg: msg,
        writeReviewTextController: textController ?? writeReviewTextController,
        titleTextController: titleTextController ?? this.titleTextController,
        rating: rating ?? this.rating,
        titleFocusNode: titleFocusNode,
        writeReviewFocusNode: writeReviewFocusNode,
        // Change to int
        redirectRoute: redirectRoute ?? this.redirectRoute,
        isFromRateOrder: isFromRateOrder ?? this.isFromRateOrder,
        orderId: orderId ?? this.orderId,
        product: product ?? this.product,
        saveReviewResponse: saveReviewResponse ?? this.saveReviewResponse);
  }

  @override

  /// Props used for equality and change detection.
  List<Object?> get props => <Object?>[
        formKey,
        writeReviewTextController,
        titleTextController,
        saveReviewResponse,
        rating,
        isFromRateOrder,
        orderId,
        ...super.props
      ]; // Update this line
}
