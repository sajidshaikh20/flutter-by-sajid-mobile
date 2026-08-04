
import '../../../../utils/exports.dart';


@RoutePage()
class LeaderboardPage extends BaseResponsiveView {
  const LeaderboardPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<LeaderboardCubit>(
      create: (BuildContext context) =>
          LeaderboardCubit(
            repository: LeaderboardRepositoryImpl(),
          ),
      child: const LeaderboardViewBody(),
    );
  }
}

class LeaderboardViewBody extends StatefulWidget {
  const LeaderboardViewBody({super.key});

  @override
  State<LeaderboardViewBody> createState() => _LeaderboardViewBodyState();
}

class _LeaderboardViewBodyState extends State<LeaderboardViewBody> {
  PickerDateRange? _getDateRangeFromState(String? fromDate, String? toDate) {
    if (fromDate == null || toDate == null) return null;
    try {
      return PickerDateRange(DateTime.parse(fromDate), DateTime.parse(toDate));
    } on Object catch (_) {
      return null;
    }
  }

  Future<void> _selectDateRange(BuildContext context, LeaderboardCubit cubit, LeaderboardState state) async {
    final PickerDateRange? currentRange = _getDateRangeFromState(state.fromDate, state.toDate);
    final PickerDateRange? result = await showDateRangePickerModal(
      context,
      initialRange: currentRange,
    );

    if (result != null) {
      if (result.startDate == null && result.endDate == null) {
        cubit.updateDateRange(null, null);
      } else if (result.startDate != null) {
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final String fromStr = formatter.format(result.startDate!);
        final String toStr = formatter.format(result.endDate ?? result.startDate!);
        cubit.updateDateRange(fromStr, toStr);
      }
    }
  }

  Widget _buildTimePeriodSelector(BuildContext context, LeaderboardCubit cubit, LeaderboardState state) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.surfaceLight;
    final Color segmentBg = isDark ? const Color(0xFF0F1218) : AppColors.whiteSmokeShade;
    final Color borderColor = isDark ? const Color(0xFF2C3240) : AppColors.borderLight;

    String customLabel = 'Custom';
    if (state.fromDate != null && state.toDate != null) {
      try {
        final DateTime from = DateTime.parse(state.fromDate!);
        final DateTime to = DateTime.parse(state.toDate!);
        final DateFormat formatter = DateFormat('MMM dd');
        customLabel = '${formatter.format(from)} - ${formatter.format(to)}';
      } on Object catch (_) {}
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(Dimens.radius12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Left Side: Icon & Title (Wrapped in Flexible to prevent overflow on small screens)
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.history_rounded,
                  color: AppColors.primaryPurple,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: CustomTextLabelWidget(
                    label: 'Time Period',
                    style: TextStyle(
                      color: textColor,
                      fontSize: Dimens.fontSize12,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Right Side: Selector
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: segmentBg,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: borderColor, width: 0.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildSegmentItem(
                  label: 'Weekly',
                  isSelected: state.activeTimeframe == 'Weekly',
                  onTap: () => cubit.updateTimeframe('Weekly'),
                  isDark: isDark,
                ),
                _buildSegmentItem(
                  label: 'Monthly',
                  isSelected: state.activeTimeframe == 'Monthly',
                  onTap: () => cubit.updateTimeframe('Monthly'),
                  isDark: isDark,
                ),
                _buildSegmentItem(
                  label: customLabel,
                  isSelected: state.activeTimeframe == 'Custom',
                  hasArrow: state.fromDate == null || state.toDate == null,
                  hasClear: state.fromDate != null && state.toDate != null,
                  onTap: () async {
                    cubit.updateTimeframe('Custom');
                    await _selectDateRange(context, cubit, state);
                  },
                  onClear: () {
                    cubit.updateTimeframe('Weekly');
                  },
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
    bool hasArrow = false,
    bool hasClear = false,
    VoidCallback? onClear,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (hasArrow) ...<Widget>[
              const SizedBox(width: 2),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                size: 13,
              ),
            ],
            if (hasClear) ...<Widget>[
              const SizedBox(width: 3),
              GestureDetector(
                onTap: onClear,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Icon(
                    Icons.cancel_rounded,
                    color: isSelected
                        ? Colors.white
                        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                    size: 13,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors
        .backgroundLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors
        .textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors
        .textSecondaryLight;
    final Color cardBorder = isDark ? AppColors.borderDark : AppColors
        .borderLight;

    return BlocConsumer<LeaderboardCubit, LeaderboardState>(
      listener: (BuildContext context, LeaderboardState state) {
        if (state.status == BaseStateStatus.success && state.msg != null && state.msg!.isNotEmpty) {
          displaySnackBar(state.msg!, context);
          context.read<LeaderboardCubit>().resetError();
        }

        if (state.status == BaseStateStatus.failure && state.msg != null && state.msg!.isNotEmpty) {
          displaySnackBar(state.msg!, context);
          context.read<LeaderboardCubit>().resetError();
        }
      },
      builder: (BuildContext context, LeaderboardState state) {
        final LeaderboardCubit cubit = context.read<LeaderboardCubit>();
        final bool showPodium = state.filteredItems.length >= 3;
        final bool hasListItems = showPodium
            ? state.filteredItems.any((LeaderboardItemModel x) => x.rank > 3)
            : state.filteredItems.isNotEmpty;

        return Scaffold(
          backgroundColor: pageBg,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 1. Header (Leaderboard, Refresh, Notifications)
                _buildHeader(
                    context, isDark, textColor, subtextColor, cardBorder),

                // Time Period Selector segment matching user screenshot
                _buildTimePeriodSelector(context, cubit, state),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.space16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: Dimens.space16),

                      // 2. Podium (Top 3)
                      if (!state.shimmerLoading && showPodium) ...<Widget>[
                        _buildPodiumSection(context, isDark, state),
                        const SizedBox(height: Dimens.space24),
                      ],

                      // 3. Rankings Table Header
                      if (state.shimmerLoading || hasListItems) ...<Widget>[
                        _buildTableHeader(isDark, subtextColor),
                        const SizedBox(height: Dimens.space8),
                      ],
                    ],
                  ),
                ),

                // 4. List Items / Rankings List (Scrollable Area)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.space16),
                    child: _buildRankingsContent(
                        context, isDark, textColor, subtextColor, cardBorder,
                        state),
                  ),
                ),

                const SizedBox(height: Dimens.space8),
                // 5. Footer Notice
                _buildFooterNotice(isDark, subtextColor),
                const SizedBox(height: Dimens.space16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRankingsContent(BuildContext context,
      bool isDark,
      Color textColor,
      Color subtextColor,
      Color borderCol,
      LeaderboardState state,) {
    if (state.shimmerLoading) {
      return _buildShimmerList(isDark);
    }

    final List<LeaderboardItemModel> listItems = state.filteredItems.length >= 3
        ? state.filteredItems.where((LeaderboardItemModel x) => x.rank > 3).toList()
        : state.filteredItems;

    return RefreshIndicator(
      color: AppColors.primaryPurple,
      onRefresh: () => context.read<LeaderboardCubit>().refreshLeaderboard(),
      child: state.filteredItems.isEmpty
          ? CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildEmptyState(textColor, subtextColor),
          ),
        ],
      )
          : NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollEndNotification ||
              notification is ScrollUpdateNotification) {
            final ScrollMetrics metrics = notification.metrics;
            if (metrics.pixels >= metrics.maxScrollExtent * 0.9) {
              unawaited(context.read<LeaderboardCubit>().loadMore());
            }
          }
          return false;
        },
        child: listItems.isEmpty
            ? CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(),
                  ),
                ],
              )
            : _buildRankingsList(
                isDark, textColor, subtextColor, borderCol, listItems, state.isLoadingMore),
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildHeader(BuildContext context,
      bool isDark,
      Color textColor,
      Color subtextColor,
      Color borderCol,) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space16,
        vertical: Dimens.space12,
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => context.router.back(),
            child: Container(
              padding: const EdgeInsets.all(Dimens.space8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: borderCol),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: textColor,
                size: Dimens.size16,
              ),
            ),
          ),
          const SizedBox(width: Dimens.space12),
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.emoji_events_outlined,
                  color: isDark ? AppColors.successColor : AppColors
                      .primaryPurple,
                  size: Dimens.size24,
                ),
                const SizedBox(width: Dimens.space8),
                CustomTextLabelWidget(
                  label: 'Leaderboard',
                  style: TextStyle(
                    fontSize: Dimens.fontSize20,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          // Info Icon
          IconButton(
              icon: Icon(
                Icons.info_outline_rounded,
                color: textColor,
                size: Dimens.size22,
              ),
              onPressed: () => _showFormulaBottomSheet(context, isDark, textColor, subtextColor),
          ),
        ],
      ),
    );
  }

  void _showFormulaBottomSheet(BuildContext context, bool isDark, Color textColor, Color subtextColor) {
    unawaited(showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius24),
              topRight: Radius.circular(Dimens.radius24),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space20, vertical: Dimens.space24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: Dimens.space20),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.info_outline_rounded,
                    color: isDark ? AppColors.successColor : AppColors.primaryPurple,
                    size: Dimens.size24,
                  ),
                  const SizedBox(width: Dimens.space8),
                  CustomTextLabelWidget(
                    label: 'Ranking Rules',
                    style: TextStyle(
                      fontSize: Dimens.fontSize18,
                      fontWeight: FontWeight.w900,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.space16),
              CustomTextLabelWidget(
                label: 'Rankings are calculated based on performance points where:',
                style: TextStyle(
                  fontSize: Dimens.fontSize13,
                  fontWeight: FontWeight.w500,
                  color: subtextColor,
                ),
              ),
              const SizedBox(height: Dimens.space16),
              
              // Formula Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(Dimens.space16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1B162E) : const Color(0xFFF7F5FC),
                  borderRadius: BorderRadius.circular(Dimens.radius12),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildFormulaItem(
                      title: 'LONG Trades',
                      formula: 'Points = (Exit - Entry) / |Entry - SL|',
                      isDark: isDark,
                    ),
                    const Divider(height: Dimens.space20, thickness: 0.5, color: Colors.white24),
                    _buildFormulaItem(
                      title: 'SHORT Trades',
                      formula: 'Points = (Entry - Exit) / |Entry - SL|',
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimens.space20),
              Align(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: CustomTextLabelWidget(
                    label: 'Close',
                    style: TextStyle(
                      color: isDark ? AppColors.successColor : AppColors.primaryPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimens.fontSize14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  Widget _buildFormulaItem({required String title, required String formula, required bool isDark}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextLabelWidget(
          label: title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.successColor,
          ),
        ),
        const SizedBox(height: 6),
        CustomTextLabelWidget(
          label: formula,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white : Colors.black87,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }


  Widget _buildPodiumSection(BuildContext context, bool isDark,
      LeaderboardState state) {
    final List<LeaderboardItemModel> filtered = state.filteredItems;
    if (filtered.isEmpty) return const SizedBox.shrink();

    // Map top 3 by rank
    final LeaderboardItemModel? first = filtered.firstWhereOrNull((
        LeaderboardItemModel x) => x.rank == 1);
    final LeaderboardItemModel? second = filtered.firstWhereOrNull((
        LeaderboardItemModel x) => x.rank == 2);
    final LeaderboardItemModel? third = filtered.firstWhereOrNull((
        LeaderboardItemModel x) => x.rank == 3);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // 2nd Place (Left)
        Expanded(
          child: second != null
              ? _buildPodiumCard(
                  item: second,
                  rank: 2,
                  height: 200,
                  gradientColors: isDark
                      ? <Color>[const Color(0xFF141D35), const Color(0xFF0F1527)]
                      : <Color>[const Color(0xFFE8ECEF), const Color(0xFFF1F3F5)],
                  badgeColor: const Color(0xFF9E9E9E),
                  // Silver
                  isDark: isDark,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(width: Dimens.space8),

        // 1st Place (Center - Golden Highlighted)
        Expanded(
          child: first != null
              ? _buildPodiumCard(
                  item: first,
                  rank: 1,
                  height: 230,
                  gradientColors: isDark
                      ? <Color>[const Color(0xFF2C2213), const Color(0xFF19140B)]
                      : <Color>[const Color(0xFFFFF9E6), const Color(0xFFFFF2CC)],
                  badgeColor: const Color(0xFFFFD700),
                  // Gold
                  isHighlighted: true,
                  isDark: isDark,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(width: Dimens.space8),

        // 3rd Place (Right)
        Expanded(
          child: third != null
              ? _buildPodiumCard(
                  item: third,
                  rank: 3,
                  height: 200,
                  gradientColors: isDark
                      ? <Color>[const Color(0xFF221714), const Color(0xFF160F0D)]
                      : <Color>[const Color(0xFFF5E6E3), const Color(0xFFF0DCD7)],
                  badgeColor: const Color(0xFFCD7F32),
                  // Bronze
                  isDark: isDark,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildPodiumCard({
    required LeaderboardItemModel item,
    required int rank,
    required double height,
    required List<Color> gradientColors,
    required Color badgeColor,
    bool isHighlighted = false,
    required bool isDark,
  }) {
    final Color textColor = isDark ? Colors.white : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors
        .textSecondaryLight;

    // Glowing shadow for first place
    final List<BoxShadow> shadows = isHighlighted
        ? <BoxShadow>[
      BoxShadow(
        color: const Color(0xFFFFD700).withValues(alpha: isDark ? 0.35 : 0.2),
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ]
        : <BoxShadow>[
      BoxShadow(
        color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ];

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(Dimens.radius16),
        border: Border.all(
          color: isHighlighted
              ? const Color(0xFFFFD700)
              : (isDark ? AppColors.borderDark : AppColors.borderLight),
          width: isHighlighted ? 1.5 : 1.0,
        ),
        boxShadow: shadows,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Confetti / Sparks graphic overlay for 1st place
          if (isHighlighted)
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: CustomPaint(
                  painter: ConfettiSparkPainter(),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Laurel Wreath & Avatar representation
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // Laurel Wreath Vector Graphic
                    CustomPaint(
                      size: const Size(70, 70),
                      painter: LaurelWreathPainter(color: badgeColor),
                    ),

                    // Avatar Circle
                    Container(
                      width: Dimens.size40,
                      height: Dimens.size40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: badgeColor,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: item.avatarUrl != null
                            ? Image.network(item.avatarUrl!, fit: BoxFit.cover)
                            : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: rank == 1
                                  ? <Color>[
                                const Color(0xFFFFE57F),
                                const Color(0xFFFFC107)
                              ]
                                  : rank == 2
                                  ? <Color>[
                                const Color(0xFFCFD8DC),
                                const Color(0xFF90A4AE)
                              ]
                                  : <Color>[
                                const Color(0xFFFFCC80),
                                const Color(0xFFFFB74D)
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: CustomTextLabelWidget(
                            label: item.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                              fontSize: Dimens.fontSize16,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Rank hexagon/badge at top center
                    Positioned(
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: isDark ? AppColors
                              .backgroundDark : Colors.white, width: 1.5),
                        ),
                        child: CustomTextLabelWidget(
                          label: rank.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Trader Details
                CustomTextLabelWidget(
                  label: item.name,
                  style: TextStyle(
                    color: textColor,
                    fontSize: Dimens.fontSize13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                // Performance Points
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextLabelWidget(
                      label: 'Points',
                      style: TextStyle(
                        color: subtextColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    CustomTextLabelWidget(
                      label: '${item.pnl >= 0 ? '+' : ''}${item.pnl.toStringAsFixed(2)} pts',
                      style: TextStyle(
                        color: item.pnl >= 0 
                            ? (isDark ? AppColors.successColor : AppColors.greenTextColor)
                            : AppColors.errorColor,
                        fontSize: Dimens.fontSize16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(bool isDark, Color subtextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.space12, vertical: Dimens.space4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50.0,
            child: CustomTextLabelWidget(
              label: 'Rank',
              style: TextStyle(color: subtextColor,
                  fontSize: Dimens.fontSize10,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: CustomTextLabelWidget(
              label: 'Trader',
              style: TextStyle(color: subtextColor,
                  fontSize: Dimens.fontSize10,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: 80.0,
            child: CustomTextLabelWidget(
              label: 'Points',
              style: TextStyle(color: subtextColor,
                  fontSize: Dimens.fontSize10,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingsList(
      bool isDark,
      Color textColor,
      Color subtextColor,
      Color borderCol,
      List<LeaderboardItemModel> items,
      bool isLoadingMore,) {
    final int itemCount = isLoadingMore ? items.length + 1 : items.length;

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (BuildContext ctx, int index) =>
          Divider(
            height: 1,
            thickness: 0.5,
            color: isDark
                ? AppColors.borderDark.withValues(alpha: 0.5)
                : AppColors.borderLight.withValues(alpha: 0.5),
          ),
      itemBuilder: (BuildContext ctx, int index) {
        if (index >= items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.space16),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryPurple),
                ),
              ),
            ),
          );
        }

        final LeaderboardItemModel item = items[index];

        // Colored Rank text (ranks 1-3 are in podium, but in case they appear, they are styled)
        Color rankColor = subtextColor;
        if (item.rank == 1) {
          rankColor = const Color(0xFFFFC107); // Gold
        } else if (item.rank == 2) {
          rankColor = const Color(0xFF90A4AE); // Silver
        } else if (item.rank == 3) {
          rankColor = const Color(0xFFFF8A65); // Bronze
        }

        final Color pointsColor = item.pnl >= 0 
            ? (isDark ? AppColors.successColor : AppColors.greenTextColor)
            : AppColors.errorColor;

        final bool isClient = UserProfileService.instance().roleName.toUpperCase() == 'CLIENT';

        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.space12, horizontal: Dimens.space12),
          child: Row(
            children: <Widget>[
              // Rank
              SizedBox(
                width: 36.0,
                child: CustomTextLabelWidget(
                  label: item.rank.toString(),
                  style: TextStyle(
                    color: rankColor,
                    fontSize: Dimens.fontSize15,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),

              // Trader image & name
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: Dimens.size32,
                      height: Dimens.size32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: AppColors.primaryGradient,
                        ),
                      ),
                      padding: const EdgeInsets.all(1.5),
                      child: ClipOval(
                        child: item.avatarUrl != null
                            ? Image.network(item.avatarUrl!, fit: BoxFit.cover)
                            : Container(
                          color: isDark ? AppColors.surfaceDark : Colors.white,
                          alignment: Alignment.center,
                          child: CustomTextLabelWidget(
                            label: item.name.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              color: textColor,
                              fontSize: Dimens.fontSize12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimens.space12),
                    Expanded(
                      child: CustomTextLabelWidget(
                        label: item.name,
                        style: TextStyle(
                          color: textColor,
                          fontSize: Dimens.fontSize13,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Points
              SizedBox(
                width: 70.0,
                child: CustomTextLabelWidget(
                  label: '${item.pnl >= 0 ? '+' : ''}${item.pnl.toStringAsFixed(2)} pts',
                  style: TextStyle(
                    color: pointsColor,
                    fontSize: Dimens.fontSize13,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),

              if (isClient && item.type == 'TRADER') ...<Widget>[
                const SizedBox(width: Dimens.space12),
                GestureDetector(
                  onTap: () async {
                    await context.read<LeaderboardCubit>().toggleFollowTrader(item);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.space8,
                      vertical: Dimens.space4,
                    ),
                    decoration: BoxDecoration(
                      color: item.isFollowing
                          ? Colors.transparent
                          : AppColors.primaryPurple,
                      border: Border.all(
                        color: AppColors.primaryPurple,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(Dimens.radius4),
                    ),
                    child: CustomTextLabelWidget(
                      label: item.isFollowing ? 'Unfollow' : 'Follow',
                      style: TextStyle(
                        color: item.isFollowing ? AppColors.primaryPurple : Colors.white,
                        fontSize: Dimens.fontSize11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerList(bool isDark) {
    final Color baseCol = isDark ? const Color(0xFF1B162E) : Colors.grey
        .shade300;
    final Color highCol = isDark ? const Color(0xFF2E274C) : Colors.grey
        .shade100;

    return Shimmer.fromColors(
      baseColor: baseCol,
      highlightColor: highCol,
      child: Column(
        children: List<Widget>.generate(5, (int i) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.space12, horizontal: Dimens.space12),
            child: Row(
              children: <Widget>[
                // Rank
                const SizedBox(
                  width: Dimens.size40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 20,
                      height: 16,
                      child: DecoratedBox(decoration: BoxDecoration(
                          color: Colors.white)),
                    ),
                  ),
                ),

                // Trader Image & Name
                Expanded(
                  child: Row(
                    children: <Widget>[
                      const CircleAvatar(
                          radius: Dimens.size16, backgroundColor: Colors.white),
                      const SizedBox(width: Dimens.space12),
                      Expanded(
                        child: Container(
                          height: 14,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                      ),
                      const SizedBox(width: Dimens.space12),
                    ],
                  ),
                ),

                // Win Rate
                const SizedBox(
                  width: Dimens.size80,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 45,
                      height: 14,
                      child: DecoratedBox(decoration: BoxDecoration(
                          color: Colors.white)),
                    ),
                  ),
                ),

                // Status Badge
                const SizedBox(
                  width: Dimens.size80,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 55,
                      height: 20,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState(Color textColor, Color subtextColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.search_off_rounded, color: subtextColor,
              size: Dimens.size48),
          const SizedBox(height: Dimens.space12),
          CustomTextLabelWidget(
            label: 'No Results Found',
            style: TextStyle(
              color: textColor,
              fontSize: Dimens.fontSize16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Dimens.space4),
          CustomTextLabelWidget(
            label: 'Try looking for another trader name or category.',
            style: TextStyle(
              color: subtextColor,
              fontSize: Dimens.fontSize12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterNotice(bool isDark, Color subtextColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.space16),
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF141A2E) : const Color(0xFFF3F5F9),
        borderRadius: BorderRadius.circular(Dimens.radius8),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.info_outline_rounded,
                color: isDark ? AppColors.successColor : AppColors.primaryPurple,
                size: Dimens.size14,
              ),
              const SizedBox(width: Dimens.space8),
              Expanded(
                child: CustomTextLabelWidget(
                  label: 'Rankings are calculated based on performance points where: points = (exit - entry) / |entry - SL| for LONG and (entry - exit) / |entry - SL| for SHORT.',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: subtextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          CustomTextLabelWidget(
            label: 'Rankings are updated every 10 minutes.',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w400,
              color: subtextColor.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Painters for Premium Aesthetics ---

/// Draws dynamic celebratory sparks/confetti behind the 1st place podium card
class ConfettiSparkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFFFD700).withValues(alpha: 0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.fill;

    // Sparks vectors
    final List<Offset> sparks = <Offset>[
      Offset(size.width * 0.15, size.height * 0.2),
      Offset(size.width * 0.85, size.height * 0.15),
      Offset(size.width * 0.3, size.height * 0.4),
      Offset(size.width * 0.75, size.height * 0.45),
      Offset(size.width * 0.2, size.height * 0.7),
      Offset(size.width * 0.8, size.height * 0.8),
    ];

    for (final Offset center in sparks) {
      canvas
        ..drawCircle(center, 2.5, paint)
        ..drawLine(
            Offset(center.dx - 4, center.dy), Offset(center.dx + 4, center.dy),
            paint)..drawLine(
          Offset(center.dx, center.dy - 4), Offset(center.dx, center.dy + 4),
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Dynamic Laurel Wreath painter for top podium rankings
class LaurelWreathPainter extends CustomPainter {
  final Color color;

  LaurelWreathPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r = size.width / 2.6;

    // Draw left branch arc
    final Rect rect = Rect.fromCircle(center: Offset(cx, cy), radius: r);
    canvas..drawArc(rect, 0.85 * pi, 0.8 * pi, false, paint)..drawArc(
        rect, -0.65 * pi, 0.8 * pi, false, paint);

    // Draw small leaves on left
    final Paint leafPaint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    // Angle markers for left leaves
    final List<double> leftAngles = <double>[
      1.0 * pi,
      1.2 * pi,
      1.4 * pi,
      1.6 * pi
    ];
    for (final double angle in leftAngles) {
      final double leafX = cx + r * cos(angle);
      final double leafY = cy + r * sin(angle);
      canvas.drawOval(
        Rect.fromCenter(center: Offset(leafX, leafY), width: 8, height: 4),
        leafPaint,
      );
    }

    // Angle markers for right leaves
    final List<double> rightAngles = <double>[
      0.0 * pi,
      -0.2 * pi,
      -0.4 * pi,
      -0.6 * pi
    ];
    for (final double angle in rightAngles) {
      final double leafX = cx + r * cos(angle);
      final double leafY = cy + r * sin(angle);
      canvas.drawOval(
        Rect.fromCenter(center: Offset(leafX, leafY), width: 8, height: 4),
        leafPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
