import '../../../../utils/exports.dart';
import 'my_following_filter_bar.dart';
import 'my_following_pagination_scroll.dart';
import 'my_following_search_bar.dart';

class MyFollowingScrollContentWidget extends StatelessWidget {
  const MyFollowingScrollContentWidget({
    super.key,
    required this.isInitialLoading,
    required this.showEmptyState,
    required this.showLoadMore,
    required this.filteredSignals,
    required this.searchQuery,
    required this.selectedFilter,
    required this.onSearchChanged,
    required this.onSearchClear,
    required this.onFilterSelected,
    required this.onLoadMore,
    required this.onRefresh,
    this.onDatePickerTapped,
    this.onDatePickerClear,
    this.hasActiveDateRange = false,
  });

  final bool isInitialLoading;
  final bool showEmptyState;
  final bool showLoadMore;
  final List<TradingSignalModel> filteredSignals;
  final String searchQuery;
  final MyFollowingFilter selectedFilter;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchClear;
  final ValueChanged<MyFollowingFilter> onFilterSelected;
  final VoidCallback onLoadMore;
  final Future<void> Function() onRefresh;
  final VoidCallback? onDatePickerTapped;
  final VoidCallback? onDatePickerClear;
  final bool hasActiveDateRange;

  @override
  Widget build(BuildContext context) {
    final Color pageBg =
        context.isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: MyFollowingPaginationScrollWidget(
        onLoadMore: onLoadMore,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: MyFollowingSearchBarWidget(
                  searchQuery: searchQuery,
                  onChanged: onSearchChanged,
                  onClear: onSearchClear,
                  onDatePickerTapped: onDatePickerTapped,
                  onDatePickerClear: onDatePickerClear,
                  hasActiveDateRange: hasActiveDateRange,
                ),
              ),
              SliverStickyHeader(
                header: Container(
                  color: pageBg,
                  padding: const EdgeInsets.symmetric(vertical: Dimens.space4),
                  child: MyFollowingFilterBar(
                    selectedFilter: selectedFilter,
                    onFilterChanged: onFilterSelected,
                  ),
                ),
                sliver: isInitialLoading
                    ? SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space16,
                          vertical: Dimens.space12,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) => const Padding(
                              padding: EdgeInsets.only(bottom: Dimens.space12),
                              child: TradingSignalCardShimmerWidget(),
                            ),
                            childCount: 4,
                          ),
                        ),
                      )
                    : showEmptyState
                        ? const SliverToBoxAdapter(child: TradesEmptyFilterWidget())
                        : TradesSignalsListSliverWidget(
                            signals: filteredSignals,
                            showLoadMore: showLoadMore,
                            showTakeTrade: false,
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
