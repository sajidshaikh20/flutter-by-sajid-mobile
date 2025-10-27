import '../../../../utils/exports.dart';

/// Widget that displays the main review and rating interface with pagination.
class MyReviewRatingWidget extends StatelessWidget {
  /// Creates a my review rating widget.
  const MyReviewRatingWidget({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = Dimens.space16;
    double varticalPadding = Dimens.space14;
    switch (device) {
      case ScreenType.tablet:
        varticalPadding = Dimens.space20;
        horizontalPadding = Dimens.space32;
      default:
        break;
    }
    
    return BlocBuilder<MyReviewRatingCubit, MyReviewRatingState>(
      buildWhen: (MyReviewRatingState previous, MyReviewRatingState current) {
        return previous.status != current.status ||
               previous.reviewRatingList != current.reviewRatingList ||
               previous.isLoadingMore != current.isLoadingMore;
      },
      builder: (BuildContext context, MyReviewRatingState state) {
        // Show loading shimmer when API is loading
        if (state.status == BaseStateStatus.loading) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: varticalPadding,
            ),
            child: CustomListView(
              itemCount: AppConstant.limitProduct,
              isPadding: true,
              isSeparator: true,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                // Apply custom padding based on the index
                double topPadding = Dimens.space16;
                double bottomPadding = Dimens.space16;

                if (index == 0) {
                  // First item - only bottom padding
                  bottomPadding = Dimens.space16;
                  topPadding = Dimens.size0; // No top padding for the first item
                } else if (index == AppConstant.limitProduct - 1) {
                  // Last item - only top padding
                  topPadding = Dimens.space16;
                  bottomPadding = Dimens.size0; // No bottom padding for the last item
                }

                return Padding(
                  padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
                  child: const MyReviewAndRatingCardShimmer(),
                );
              },
            ),
          );
        }

        // Show empty state when no reviews found and API call was successful
        if (state.reviewRatingList?.isEmpty ?? true) {
          return CustomNoDataWidget(
            key: ValueKey<String>('empty_reviews_${state.hashCode}'),
            message: context.appString.noReviewsFoundKey,
            description: context.appString.noReviewsFoundDescKey,
            buttonText: context.appString.tryAgainKey,
            onButtonPressed: () async {
              await context.read<MyReviewRatingCubit>().getReviewRating();
            },
          );
        }

        // Show review list when reviews are available
        int itemCount = state.reviewRatingList?.length ?? 0;
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<MyReviewRatingCubit>().refreshReviews();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: varticalPadding,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: CustomListView(
                    itemCount: itemCount,
                    isPadding: true,
                    isSeparator: true,
                    scrollPhysics: const AlwaysScrollableScrollPhysics(),
                    scrollController: state.scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      // Apply custom padding based on the index
                      double topPadding = Dimens.space16;
                      double bottomPadding = Dimens.space16;

                      if (index == 0) {
                        // First item - only bottom padding
                        bottomPadding = Dimens.space16;
                        topPadding = Dimens.size0; // No top padding for the first item
                      } else if (index == itemCount - 1) {
                        // Last item - only top padding
                        topPadding = Dimens.space16;
                        bottomPadding = Dimens.size0; // No bottom padding for the last item
                      }

                      return Padding(
                        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
                        child: MyReviewAndRatingCardWidget(
                          reviewRatingList: state.reviewRatingList,
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
                // Show pagination loader at the bottom
                if (state.isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CustomPaginationLoaderWidget(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

}
