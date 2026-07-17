import '../../../../utils/exports.dart';

/// Main subscribed content for Trading Signals — state comes from [TradesCubit].
class TradesContentWidget extends StatelessWidget {
  const TradesContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color pageBg =
        context.isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return BlocConsumer<TradesCubit, TradesState>(
      listener: TradesContentWidget._onStateChanged,
      builder: (BuildContext context, TradesState state) {
        final TradesCubit cubit = context.read<TradesCubit>();
        final String role = UserProfileService.instance().roleName;
        final bool canAddTrade = role == 'TRADER' || role == 'ADMIN';

        return Scaffold(
          backgroundColor: pageBg,
          floatingActionButton: canAddTrade
              ? FloatingActionButton(
                  onPressed: () async {
                    await context.router.push(const AddTradeRoute());
                  },
                  backgroundColor: AppColors.primaryPurple,
                  child: const Icon(Icons.add, color: AppColors.whiteColor),
                )
              : null,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const HomeHeaderAppBar(
                  showProfileImage: false,
                  showNotification: false,

                  title: 'Trading Signals',
                  subtitle: 'Explore high-quality trades from professional traders',
                ),
                Expanded(
                  child: TradesTabScrollContentWidget(
                    isInitialLoading: state.isInitialLoading,
                    showEmptyState: state.showEmptyState,
                    showLoadMore: state.showLoadMoreIndicator,
                    filteredSignals: state.filteredSignals,
                    searchQuery: state.searchQuery,
                    activeCount: state.activeCount.toString(),
                    pendingCount: state.pendingCount.toString(),
                    closedCount: state.closedCount.toString(),
                    lossesCount: state.lossesCount.toString(),
                    selectedFilters: state.selectedFilters,
                    onSearchChanged: cubit.updateSearchQuery,
                    onSearchClear: cubit.clearSearch,
                    onFilterSelected: cubit.selectFilter,
                    onLoadMore: () => unawaited(cubit.loadMore()),
                    onRefresh: () => cubit.loadTrades(isRefresh: true),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void _onStateChanged(BuildContext context, TradesState state) {
    if (state.msg == null || state.msg!.isEmpty) return;

    if (state.status == BaseStateStatus.success) {
      context.scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(state.msg!),
          backgroundColor: AppColors.successColor,
        ),
      );
    } else if (state.status == BaseStateStatus.failure) {
      context.scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(state.msg!),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }

    context.read<TradesCubit>().resetError();
  }
}
