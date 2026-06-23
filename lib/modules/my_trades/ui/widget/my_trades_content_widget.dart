import '../../../../utils/exports.dart';

/// Main subscribed content for My Trades — state comes from [MyTradesCubit].
class MyTradesContentWidget extends StatelessWidget {
  const MyTradesContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color pageBg =
        context.isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return BlocConsumer<MyTradesCubit, MyTradesState>(
      listener: MyTradesContentWidget._onStateChanged,
      builder: (BuildContext context, MyTradesState state) {
        final MyTradesCubit cubit = context.read<MyTradesCubit>();

        return Scaffold(
          backgroundColor: pageBg,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const HomeHeaderAppBar(
                  showProfileImage: false,
                  title: 'My Trades',
                  subtitle: 'Track and manage your active and past trades',
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
                    selectedFilter: state.selectedFilter,
                    showTakeTrade: false,
                    onSearchChanged: cubit.updateSearchQuery,
                    onSearchClear: cubit.clearSearch,
                    onFilterSelected: cubit.selectFilter,
                    onLoadMore: () => unawaited(cubit.loadMore()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void _onStateChanged(BuildContext context, MyTradesState state) {
    if (state.status != BaseStateStatus.failure) return;
    if (state.msg == null || state.msg!.isEmpty) return;

    context.scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(state.msg!),
        backgroundColor: AppColors.errorColor,
      ),
    );
    context.read<MyTradesCubit>().resetError();
  }
}
