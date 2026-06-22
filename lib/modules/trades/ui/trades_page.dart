import '../../../utils/exports.dart';

@RoutePage()
/// Trades tab displaying dashboard metrics, recent history, live trades, and market summaries.
class TradesPage extends BaseResponsiveView {
  const TradesPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<TradesCubit>(
      create: (BuildContext context) => TradesCubit(
        repository: TradesRepositoryImpl(),
      ),
      child: const TradesViewBody(),
    );
  }
}

class TradesViewBody extends StatefulWidget {
  const TradesViewBody({super.key});

  @override
  State<TradesViewBody> createState() => _TradesViewBodyState();
}

class _TradesViewBodyState extends State<TradesViewBody> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      unawaited(context.read<TradesCubit>().loadTrades());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
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
                    showNotification: false,
                    title: 'Trading Signals',
                    subtitle: 'Explore high-quality trades from professional traders',
                  ),
                  Expanded(
                    child: SubscriptionLockWidget(
                      title: 'Unlock Trading Signals',
                      subtitle: 'Subscribe to view high-probability signals from professional traders.',
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return BlocConsumer<TradesCubit, TradesState>(
          listener: (BuildContext context, TradesState state) {
            if (state.status == BaseStateStatus.success && state.msg != null && state.msg!.isNotEmpty) {
              context.scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(state.msg!),
                  backgroundColor: AppColors.successColor,
                ),
              );
              context.read<TradesCubit>().resetError();
            }

            if (state.status == BaseStateStatus.failure && state.msg != null && state.msg!.isNotEmpty) {
              context.scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(state.msg!),
                  backgroundColor: AppColors.errorColor,
                ),
              );
              context.read<TradesCubit>().resetError();
            }
          },
      builder: (BuildContext context, TradesState state) {
        final List<TradingSignalModel> allSignals = state.signals;

        final List<TradingSignalModel> filteredSignals = allSignals.where((TradingSignalModel s) {
          // Filter by search query (trading pair or category name)
          bool matchesSearch = true;
          if (state.searchQuery.isNotEmpty) {
            matchesSearch = s.pair.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
                s.category.toLowerCase().contains(state.searchQuery.toLowerCase());
          }

          return matchesSearch;
        }).toList();

        return Scaffold(
          backgroundColor: pageBg,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                // Common Header App Bar matching Home tab styling (No back button, notification hidden)
                const HomeHeaderAppBar(
                  showProfileImage: false,
                  showNotification: false,
                  title: 'Trading Signals',
                  subtitle: 'Explore high-quality trades from professional traders',
                ),
                // Scrolling Body list content with sticky headers
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      // Search Bar positioned directly above the filters row
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space8),
                          child: Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.cardDark : AppColors.cardLight,
                              borderRadius: BorderRadius.circular(Dimens.radius12),
                              border: Border.all(
                                color: isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5),
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
                                      context.read<TradesCubit>().updateSearchQuery(value);
                                    },
                                  ),
                                ),
                                if (state.searchQuery.isNotEmpty) ...<Widget>[
                                  const SizedBox(width: Dimens.space10),
                                  GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                      context.read<TradesCubit>().clearSearch();
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
                      // Metric Summary Cards (will scroll off-screen with Search Bar)
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
                      // Sticky Filter bar section
                      SliverStickyHeader(
                        header: Container(
                          color: pageBg,
                          padding: const EdgeInsets.symmetric(vertical: Dimens.space4),
                          child: TradesFilterBar(
                            selectedFilter: state.selectedFilter,
                            onFilterChanged: (SignalFilter filter) async {
                              context.read<TradesCubit>().selectFilter(filter);
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
                        // Signals List content
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
                                      if (index == filteredSignals.length) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(vertical: Dimens.space16),
                                          child: Center(
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,
                                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: Dimens.space12),
                                        child: TradingSignalCard(signal: filteredSignals[index]),
                                      );
                                    },
                                    childCount: filteredSignals.length + (state.status == BaseStateStatus.loading && state.offset > 0 ? 1 : 0),
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
      },
    );
  }
}
