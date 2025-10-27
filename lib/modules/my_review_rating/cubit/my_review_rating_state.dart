import '../../../utils/exports.dart';


/// Immutable state representing the review and rating screen.
class MyReviewRatingState extends BaseState {
  /// List of review and rating response models.
  final List<ListOfMyReviewsRatingResponseModel>? reviewRatingList;

  /// Total count of reviews available.
  final int? totalCount;

  /// Current page number for pagination.
  final int currentPage;

  /// Whether there are more items to load.
  final bool hasMore;

  /// Whether additional data is currently being loaded.
  final bool isLoadingMore;

  /// Scroll controller for the review list.
  final ScrollController scrollController;

  /// Creates an instance of [MyReviewRatingState].
  MyReviewRatingState({
    this.reviewRatingList = const <ListOfMyReviewsRatingResponseModel>[],
    this.totalCount,
    this.currentPage = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
    ScrollController? scrollController,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  }) : scrollController = scrollController ?? ScrollController();

  /// Creates a copy of this [MyReviewRatingState] with optional new values.
  MyReviewRatingState copyWith({
    List<ListOfMyReviewsRatingResponseModel>? reviewRatingList,
    int? totalCount,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    ScrollController? scrollController,
    BaseStateStatus? status,
    ListOfMyReviewsRatingResponseModel? reviewRatingObj,
    String? msg,
  }) {
    return MyReviewRatingState(
      reviewRatingList: reviewRatingList ?? this.reviewRatingList,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      scrollController: scrollController ?? this.scrollController,
      status: status ?? this.status,
      msg: msg,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    reviewRatingList,
    totalCount,
    currentPage,
    hasMore,
    isLoadingMore,
    ...super.props,
  ];
}
