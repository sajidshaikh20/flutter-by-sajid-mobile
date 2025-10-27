import '../../../utils/exports.dart';

/// Manages review and rating data.
class MyReviewRatingCubit extends Cubit<MyReviewRatingState> {
  /// Factory constructor for singleton-like behavior.
  factory MyReviewRatingCubit() =>
      MyReviewRatingCubit._internal(MyReviewRepositoryImpl());

  MyReviewRatingCubit._internal(this._repository)
      : super(MyReviewRatingState()) {
    _initializeScrollListener();
    scheduleMicrotask(() async => _getReviewAndRating(limit: 8, offset: 0));
  }

  final MyReviewRepository _repository;

  /// Initialize scroll listener for pagination
  void _initializeScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  /// Handle scroll events for pagination
  void _onScroll() {
    if (state.scrollController.position.pixels >=
        state.scrollController.position.maxScrollExtent - 200) {
      if (state.hasMore && !state.isLoadingMore) {
        unawaited(loadMoreReviews());
      }
    }
  }

  /// Fetches reviews and ratings.
  Future<void> getReviewRating() async {
    await _getReviewAndRating(limit: 8, offset: 0);
  }

  /// Load more reviews for pagination
  Future<void> loadMoreReviews() async {
    if (state.isLoadingMore || !state.hasMore) return;
    
    emit(state.copyWith(isLoadingMore: true));
    
    final int nextOffset = (state.currentPage + 1) * 8;
    await _getReviewAndRating(
      limit: 8,
      offset: nextOffset,
      isLoadMore: true,
    );
  }

  /// Refresh reviews (pull to refresh)
  Future<void> refreshReviews() async {
    emit(state.copyWith(
      status: BaseStateStatus.loading,
      currentPage: 0,
      hasMore: true,
      reviewRatingList: const <ListOfMyReviewsRatingResponseModel>[],
    ));
    
    await _getReviewAndRating(limit: AppConstant.limitReviewRatingList, offset: 0);
  }

  Future<void> _getReviewAndRating({
    required int limit,
    required int offset,
    bool isLoadMore = false,
  }) async {
    if (!isLoadMore) {
      emit(state.copyWith(status: BaseStateStatus.loading));
    }

    await _repository
        .getReviewList(
        MyReviewsRatingRequestModel(
          customerToken: getIt<UserProfileService>().customerToken,
          languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
          platform: getPlatformName(),
          version: getIt<MainConfig>().packageInfo.version,
          limit: limit,
          offset: offset,
          )
    )
        .then(
            (ResponseHandler<BaseResponse<List<ListOfMyReviewsRatingResponseModel>>> value) {
              if (value.isSuccess()) {
                final BaseResponse<List<ListOfMyReviewsRatingResponseModel>>? myReviewRatingList =
                    value
                        .getSuccessInstance()
                        ?.response;

                // Check if API returned success: false (like "Orders not Found")
                if (myReviewRatingList?.success == false) {
                  // API returned success: false with empty data - treat as successful empty state
                  emit(
                    state.copyWith(
                      status: BaseStateStatus.success,
                      reviewRatingList: <ListOfMyReviewsRatingResponseModel>[],
                      totalCount: 0,
                      hasMore: false,
                      isLoadingMore: false,
                    ),
                  );
                } else {
                  // Handle pagination logic
                  final List<ListOfMyReviewsRatingResponseModel> newReviews = myReviewRatingList?.data ?? <ListOfMyReviewsRatingResponseModel>[];
                  final int totalCount = myReviewRatingList?.totalCount ?? 0;
                  
                  List<ListOfMyReviewsRatingResponseModel> updatedList;
                  int newCurrentPage;
                  
                  if (isLoadMore) {
                    // Append new reviews to existing list
                    updatedList = <ListOfMyReviewsRatingResponseModel>[...(state.reviewRatingList ?? <ListOfMyReviewsRatingResponseModel>[]), ...newReviews];
                    newCurrentPage = state.currentPage + 1;
                  } else {
                    // Replace list with new reviews
                    updatedList = newReviews;
                    newCurrentPage = 0;
                  }
                  
                  // Check if there are more reviews to load
                  final bool hasMore = updatedList.length < totalCount;
                  
                  emit(
                    state.copyWith(
                      status: BaseStateStatus.success,
                      reviewRatingList: updatedList,
                      totalCount: totalCount,
                      currentPage: newCurrentPage,
                      hasMore: hasMore,
                      isLoadingMore: false,
                    ),
                  );
                }
              } else if (value.isFailure()) {
                emit(
                  state.copyWith(
                    msg: value
                        .getFailureInstance()
                        ?.error
                        ?.errorMessage ?? '',
                    status: BaseStateStatus.failure,
                    isLoadingMore: false,
                  ),
                );
              }
            } );
  }

  /// Displays a shimmer effect by emitting loading state and then success after a delay.
  void displayShimmer(){
    emit(state.copyWith(status: BaseStateStatus.loading));
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (!isClosed)
      {
        emit(state.copyWith(status: BaseStateStatus.success));
      }

    });
  }

  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }
}
