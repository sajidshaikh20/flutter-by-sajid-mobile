import '../../../../utils/exports.dart';

/// Scrollable body shared by Trades and My Trades tabs.
class TradesTabScrollContentWidget extends StatelessWidget {
  const TradesTabScrollContentWidget({
    super.key,
    required this.isInitialLoading,
    required this.showEmptyState,
    required this.showLoadMore,
    required this.filteredSignals,
    required this.searchQuery,
    required this.activeCount,
    required this.pendingCount,
    required this.closedCount,
    required this.lossesCount,
    required this.selectedFilters,
    required this.onSearchChanged,
    required this.onSearchClear,
    required this.onFilterSelected,
    required this.onLoadMore,
    this.showTakeTrade = true,
  });

  final bool isInitialLoading;
  final bool showEmptyState;
  final bool showLoadMore;
  final List<TradingSignalModel> filteredSignals;
  final String searchQuery;
  final String activeCount;
  final String pendingCount;
  final String closedCount;
  final String lossesCount;
  final Set<SignalFilter> selectedFilters;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchClear;
  final ValueChanged<SignalFilter> onFilterSelected;
  final VoidCallback onLoadMore;
  final bool showTakeTrade;

  @override
  Widget build(BuildContext context) {
    final Color pageBg =
        context.isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return TradesPaginationScrollWidget(
      onLoadMore: onLoadMore,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: TradesSearchBarWidget(
              searchQuery: searchQuery,
              onChanged: onSearchChanged,
              onClear: onSearchClear,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space8),
              child: TradesSummaryCards(
                activeCount: activeCount,
                pendingCount: pendingCount,
                closedCount: closedCount,
                lossesCount: lossesCount,
              ),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              color: pageBg,
              padding: const EdgeInsets.symmetric(vertical: Dimens.space4),
              child: TradesFilterBar(
                selectedFilters: selectedFilters,
                onFilterChanged: onFilterSelected,
              ),
            ),
            sliver: isInitialLoading
                ? SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space12),
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
                        showTakeTrade: showTakeTrade,
                      ),
          ),
        ],
      ),
    );
  }
}
