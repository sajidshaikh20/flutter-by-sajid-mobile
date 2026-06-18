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

class MyTradesViewBody extends StatefulWidget {
  const MyTradesViewBody({super.key});

  @override
  State<MyTradesViewBody> createState() => _MyTradesViewBodyState();
}

class _MyTradesViewBodyState extends State<MyTradesViewBody> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return BlocConsumer<MyTradesCubit, MyTradesState>(
      listener: (BuildContext context, MyTradesState state) {
        if (state.status == BaseStateStatus.loading) {
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
        final List<TradingSignalModel> allSignals = state.signals;

        // Compute dynamic counts for the metrics cards (based on all signals)
        final int activeCount = allSignals.where((TradingSignalModel s) => s.isActive).length;
        final int pendingCount = allSignals.where((TradingSignalModel s) => s.isPending).length;
        final int closedCount = allSignals.where((TradingSignalModel s) => s.isClosed).length;
        final int lossesCount = allSignals
            .where((TradingSignalModel s) => s.isClosed && s.outcome == 'LOSS')
            .length;

        // Filter signals based on search query and status
        final List<TradingSignalModel> filteredSignals = allSignals.where((TradingSignalModel s) {
          // Filter by status
          bool matchesStatus = true;
          switch (state.selectedFilter) {
            case SignalFilter.all:
              matchesStatus = true;
            case SignalFilter.active:
              matchesStatus = s.isActive;
            case SignalFilter.pending:
              matchesStatus = s.isPending;
            case SignalFilter.closed:
              matchesStatus = s.isClosed;
            case SignalFilter.cancelled:
              matchesStatus = s.isCancelled;
          }

          // Filter by search query (trading pair or category name)
          bool matchesSearch = true;
          if (state.searchQuery.isNotEmpty) {
            matchesSearch = s.pair.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
                s.category.toLowerCase().contains(state.searchQuery.toLowerCase());
          }

          return matchesStatus && matchesSearch;
        }).toList();

        return Scaffold(
          backgroundColor: pageBg,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                // Header App Bar matching design requirements with notifications icon active
                const HomeHeaderAppBar(
                  showProfileImage: false,
                  title: 'My Trades',
                  subtitle: 'Track and manage your active and past trades',
                ),

                // Scrollable Body
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      // Search Bar positioned directly above the filters row
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
                                    controller: _searchController,
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
                                      _searchController.clear();
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

                      // Metric Summary Cards with dynamic count values passed down
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.space8),
                          child: TradesSummaryCards(
                            activeCount: activeCount.toString(),
                            pendingCount: pendingCount.toString(),
                            closedCount: closedCount.toString(),
                            lossesCount: lossesCount.toString(),
                          ),
                        ),
                      ),

                      // Sticky Filter Bar section
                      SliverStickyHeader(
                        header: Container(
                          color: pageBg,
                          padding: const EdgeInsets.symmetric(vertical: Dimens.space4),
                          child: TradesFilterBar(
                            selectedFilter: state.selectedFilter,
                            onFilterChanged: (SignalFilter filter) async {
                              context.read<MyTradesCubit>().selectFilter(filter);
                              if (_scrollController.hasClients) {
                                await _scrollController.animateTo(
                                  0.0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          ),
                        ),
                        // List Content
                        sliver: filteredSignals.isEmpty
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
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: Dimens.space12),
                                        child: TradingSignalCard(
                                          signal: filteredSignals[index],
                                          showTakeTrade: false,
                                        ),
                                      );
                                    },
                                    childCount: filteredSignals.length,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
