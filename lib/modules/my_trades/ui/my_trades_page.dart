import '../../../utils/exports.dart';

@RoutePage()
/// My Trades tab displaying user's trade history, active metrics, search and status filtering.
class MyTradesPage extends BaseResponsiveView {
  const MyTradesPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<MyTradesCubit>(
      create: (BuildContext context) => MyTradesCubit(
        repository: TradesRepositoryImpl(),
      ),
      child: const MyTradesViewBody(),
    );
  }
}

class MyTradesViewBody extends StatelessWidget {
  const MyTradesViewBody({super.key});

  bool _onScrollNotification(BuildContext context, ScrollNotification notification) {
    if (notification is ScrollEndNotification || notification is ScrollUpdateNotification) {
      final ScrollMetrics metrics = notification.metrics;
      if (metrics.pixels >= metrics.maxScrollExtent * 0.9) {
        unawaited(context.read<MyTradesCubit>().loadMore());
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return ListenableBuilder(
      listenable: UserProfileService.instance(),
      builder: (BuildContext context, Widget? child) {
        final bool isSubscribed = UserProfileService.instance().isSubscriptionActive;

        if (!isSubscribed) {
          return Scaffold(
            backgroundColor: pageBg,
            body: const SafeArea(
              child: Column(
                children: <Widget>[
                  HomeHeaderAppBar(
                    showProfileImage: false,
                    title: 'My Trades',
                    subtitle: 'Track and manage your active and past trades',
                  ),
                  Expanded(
                    child: SubscriptionLockWidget(
                      title: 'Unlock My Trades',
                      subtitle: 'Subscribe to view and track your customized trade history.',
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return BlocConsumer<MyTradesCubit, MyTradesState>(
          listener: (BuildContext context, MyTradesState state) {
            if (state.isInitialLoading) {
              unawaited(EasyLoading.show(status: 'Loading...'));
            } else {
              unawaited(EasyLoading.dismiss());
            }

            if (state.status == BaseStateStatus.failure && state.msg != null && state.msg!.isNotEmpty) {
              context.scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(state.msg!),
                  backgroundColor: AppColors.errorColor,
                ),
              );
              context.read<MyTradesCubit>().resetError();
            }
          },
          builder: (BuildContext context, MyTradesState state) {
            final List<TradingSignalModel> filteredSignals = state.signals.where((TradingSignalModel s) {
              if (state.searchQuery.isEmpty) return true;
              final String query = state.searchQuery.toLowerCase();
              return s.pair.toLowerCase().contains(query) ||
                  s.category.toLowerCase().contains(query);
            }).toList();

            final bool showInitialLoader = state.isInitialLoading;
            final bool showLoadMoreIndicator = state.isLoadingMore && state.signals.isNotEmpty;

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
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) =>
                            _onScrollNotification(context, notification),
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.space16,
                                  vertical: Dimens.space8,
                                ),
                                child: Container(
                                  height: 46,
                                  decoration: BoxDecoration(
                                    color: isDark ? AppColors.cardDark : AppColors.cardLight,
                                    borderRadius: BorderRadius.circular(Dimens.radius12),
                                    border: Border.all(
                                      color: isDark
                                          ? AppColors.borderDark
                                          : AppColors.borderLight.withValues(alpha: 0.5),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.search_rounded,
                                        color: subtextColor,
                                        size: Dimens.size20,
                                      ),
                                      const SizedBox(width: Dimens.space10),
                                      Expanded(
                                        child: TextField(
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: Dimens.fontSize13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Search pair (e.g. BTCU)',
                                            hintStyle: TextStyle(
                                              color: subtextColor,
                                              fontSize: Dimens.fontSize13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          onChanged: (String value) {
                                            context.read<MyTradesCubit>().updateSearchQuery(value);
                                          },
                                        ),
                                      ),
                                      if (state.searchQuery.isNotEmpty) ...<Widget>[
                                        const SizedBox(width: Dimens.space10),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<MyTradesCubit>().clearSearch();
                                          },
                                          child: Icon(
                                            Icons.clear_rounded,
                                            color: subtextColor,
                                            size: Dimens.size18,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimens.space8),
                                child: TradesSummaryCards(
                                  activeCount: state.activeCount.toString(),
                                  pendingCount: state.pendingCount.toString(),
                                  closedCount: state.closedCount.toString(),
                                  lossesCount: state.lossesCount.toString(),
                                ),
                              ),
                            ),
                            SliverStickyHeader(
                              header: Container(
                                color: pageBg,
                                padding: const EdgeInsets.symmetric(vertical: Dimens.space4),
                                child: TradesFilterBar(
                                  selectedFilter: state.selectedFilter,
                                  onFilterChanged: (SignalFilter filter) {
                                    context.read<MyTradesCubit>().selectFilter(filter);
                                  },
                                ),
                              ),
                              sliver: showInitialLoader
                                  ? SliverToBoxAdapter(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: Dimens.space40),
                                        child: Center(
                                          child: SizedBox(
                                            width: 32,
                                            height: 32,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                MainConfig.appColors.mainColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : filteredSignals.isEmpty
                                      ? SliverToBoxAdapter(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: Dimens.space40),
                                              child: CustomTextLabelWidget(
                                                label: 'No signals available for this filter',
                                                style: TextStyle(
                                                  color: subtextColor,
                                                  fontSize: Dimens.fontSize13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SliverPadding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: Dimens.space16,
                                            vertical: Dimens.space12,
                                          ),
                                          sliver: SliverList(
                                            delegate: SliverChildBuilderDelegate(
                                              (BuildContext context, int index) {
                                                if (index == filteredSignals.length) {
                                                  return const Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: Dimens.space16,
                                                    ),
                                                    child: Center(
                                                      child: SizedBox(
                                                        width: 24,
                                                        height: 24,
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2.5,
                                                          valueColor: AlwaysStoppedAnimation<Color>(
                                                            AppColors.primaryPurple,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return Padding(
                                                  padding: const EdgeInsets.only(bottom: Dimens.space12),
                                                  child: TradingSignalCard(
                                                    signal: filteredSignals[index],
                                                    showTakeTrade: false,
                                                  ),
                                                );
                                              },
                                              childCount: filteredSignals.length +
                                                  (showLoadMoreIndicator ? 1 : 0),
                                            ),
                                          ),
                                        ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
