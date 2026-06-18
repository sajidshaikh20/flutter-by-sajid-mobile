import '../../../utils/exports.dart';

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
      create: (BuildContext context) => LeaderboardCubit(
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
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBorder = isDark ? AppColors.borderDark : AppColors.borderLight;

    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (BuildContext context, LeaderboardState state) {
        return Scaffold(
          backgroundColor: pageBg,
          body: SafeArea(
            child: RefreshIndicator(
              color: AppColors.primaryPurple,
              onRefresh: () => context.read<LeaderboardCubit>().refreshLeaderboard(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 1. Header (Leaderboard, Refresh, Notifications)
                  _buildHeader(context, isDark, textColor, subtextColor, cardBorder),

                  // Scrollable Area
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: Dimens.space16),

                            // 2. Podium (Top 3)
                            if (!state.shimmerLoading) ...<Widget>[
                              _buildPodiumSection(context, isDark, state),
                              const SizedBox(height: Dimens.space24),
                            ],

                            // 3. Rankings Table Header
                            _buildTableHeader(isDark, subtextColor),
                            const SizedBox(height: Dimens.space8),

                            // 4. List Items / Rankings List
                            if (state.shimmerLoading)
                              _buildShimmerList(isDark)
                            else if (state.filteredItems.isEmpty)
                              _buildEmptyState(textColor, subtextColor)
                            else
                              _buildRankingsList(isDark, textColor, subtextColor, cardBorder, state),

                            const SizedBox(height: Dimens.space24),

                            // 5. Footer Notice
                            _buildFooterNotice(isDark, subtextColor),
                            const SizedBox(height: Dimens.space32),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- Widget Builders ---

  Widget _buildHeader(
    BuildContext context,
    bool isDark,
    Color textColor,
    Color subtextColor,
    Color borderCol,
  ) {
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
                  color: isDark ? AppColors.successColor : AppColors.primaryPurple,
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
          // Bell Icon
          IconButton(
            icon: Icon(
              Icons.notifications_none_rounded,
              color: textColor,
              size: Dimens.size22,
            ),
            onPressed: () => context.router.push(const NotificationRoute()),
          ),
        ],
      ),
    );
  }



  Widget _buildPodiumSection(BuildContext context, bool isDark, LeaderboardState state) {
    // We need at least the top 3 items to show podium
    final List<LeaderboardItemModel> filtered = state.filteredItems;
    if (filtered.length < 3) return const SizedBox.shrink();

    // Map top 3 by rank
    final LeaderboardItemModel? first = filtered.firstWhereOrNull((LeaderboardItemModel x) => x.rank == 1);
    final LeaderboardItemModel? second = filtered.firstWhereOrNull((LeaderboardItemModel x) => x.rank == 2);
    final LeaderboardItemModel? third = filtered.firstWhereOrNull((LeaderboardItemModel x) => x.rank == 3);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // 2nd Place (Left)
        if (second != null)
          Expanded(
            child: _buildPodiumCard(
              item: second,
              rank: 2,
              height: 200,
              gradientColors: isDark
                  ? <Color>[const Color(0xFF141D35), const Color(0xFF0F1527)]
                  : <Color>[const Color(0xFFE8ECEF), const Color(0xFFF1F3F5)],
              badgeColor: const Color(0xFF9E9E9E), // Silver
              isDark: isDark,
            ),
          ),
        const SizedBox(width: Dimens.space8),

        // 1st Place (Center - Golden Highlighted)
        if (first != null)
          Expanded(
            child: _buildPodiumCard(
              item: first,
              rank: 1,
              height: 230,
              gradientColors: isDark
                  ? <Color>[const Color(0xFF2C2213), const Color(0xFF19140B)]
                  : <Color>[const Color(0xFFFFF9E6), const Color(0xFFFFF2CC)],
              badgeColor: const Color(0xFFFFD700), // Gold
              isHighlighted: true,
              isDark: isDark,
            ),
          ),
        const SizedBox(width: Dimens.space8),

        // 3rd Place (Right)
        if (third != null)
          Expanded(
            child: _buildPodiumCard(
              item: third,
              rank: 3,
              height: 200,
              gradientColors: isDark
                  ? <Color>[const Color(0xFF221714), const Color(0xFF160F0D)]
                  : <Color>[const Color(0xFFF5E6E3), const Color(0xFFF0DCD7)],
              badgeColor: const Color(0xFFCD7F32), // Bronze
              isDark: isDark,
            ),
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
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color winRateColor = isDark ? AppColors.successColor : AppColors.greenTextColor;

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
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
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
                                        ? <Color>[const Color(0xFFFFE57F), const Color(0xFFFFC107)]
                                        : rank == 2
                                            ? <Color>[const Color(0xFFCFD8DC), const Color(0xFF90A4AE)]
                                            : <Color>[const Color(0xFFFFCC80), const Color(0xFFFFB74D)],
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
                          border: Border.all(color: isDark ? AppColors.backgroundDark : Colors.white, width: 1.5),
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
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
                    const SizedBox(height: Dimens.space4),

                    // INACTIVE / ACTIVE status pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: item.status == 'ACTIVE'
                            ? AppColors.successColor.withValues(alpha: 0.15)
                            : AppColors.errorColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CustomTextLabelWidget(
                        label: item.status,
                        style: TextStyle(
                          color: item.status == 'ACTIVE' ? AppColors.successColor : AppColors.errorColor,
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),

                // Performance Win Rate
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextLabelWidget(
                      label: 'Win Rate',
                      style: TextStyle(
                        color: subtextColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    CustomTextLabelWidget(
                      label: '${item.winRate.toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: winRateColor,
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
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: Dimens.size40,
            child: CustomTextLabelWidget(
              label: 'Rank',
              style: TextStyle(color: subtextColor, fontSize: Dimens.fontSize10, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: CustomTextLabelWidget(
              label: 'Trader',
              style: TextStyle(color: subtextColor, fontSize: Dimens.fontSize10, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: Dimens.size80,
            child: CustomTextLabelWidget(
              label: 'Win Rate',
              style: TextStyle(color: subtextColor, fontSize: Dimens.fontSize10, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: Dimens.size80,
            child: CustomTextLabelWidget(
              label: 'Status',
              style: TextStyle(color: subtextColor, fontSize: Dimens.fontSize10, fontWeight: FontWeight.bold),
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
    LeaderboardState state,
  ) {
    final List<LeaderboardItemModel> items = state.filteredItems;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (BuildContext ctx, int index) => Divider(
        height: 1,
        thickness: 0.5,
        color: isDark ? AppColors.borderDark.withValues(alpha: 0.5) : AppColors.borderLight.withValues(alpha: 0.5),
      ),
      itemBuilder: (BuildContext ctx, int index) {
        final LeaderboardItemModel item = items[index];
        final bool isActive = item.status == 'ACTIVE';

        // Colored Rank text
        Color rankColor = subtextColor;
        if (item.rank == 1) {
          rankColor = const Color(0xFFFFC107); // Gold
        } else if (item.rank == 2) {
          rankColor = const Color(0xFF90A4AE); // Silver
        } else if (item.rank == 3) {
          rankColor = const Color(0xFFFF8A65); // Bronze
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space12, horizontal: Dimens.space12),
          child: Row(
            children: <Widget>[
              // Rank
              SizedBox(
                width: Dimens.size40,
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

              // Win Rate
              SizedBox(
                width: Dimens.size80,
                child: CustomTextLabelWidget(
                  label: '${item.winRate.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: isDark ? AppColors.successColor : AppColors.greenTextColor,
                    fontSize: Dimens.fontSize13,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),

              // Status Badge
              SizedBox(
                width: Dimens.size80,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.successColor.withValues(alpha: 0.1)
                          : AppColors.errorColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Dimens.radius4),
                      border: Border.all(
                        color: isActive
                            ? AppColors.successColor.withValues(alpha: 0.2)
                            : AppColors.errorColor.withValues(alpha: 0.2),
                        width: 0.5,
                      ),
                    ),
                    child: CustomTextLabelWidget(
                      label: item.status,
                      style: TextStyle(
                        color: isActive ? AppColors.successColor : AppColors.errorColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerList(bool isDark) {
    final Color baseCol = isDark ? const Color(0xFF1B162E) : Colors.grey.shade300;
    final Color highCol = isDark ? const Color(0xFF2E274C) : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseCol,
      highlightColor: highCol,
      child: Column(
        children: List<Widget>.generate(5, (int i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space12, horizontal: Dimens.space12),
            child: Row(
              children: <Widget>[
                Container(width: 25, height: 16, color: Colors.white),
                const SizedBox(width: 20),
                const CircleAvatar(radius: Dimens.size16, backgroundColor: Colors.white),
                const SizedBox(width: 12),
                Container(width: 120, height: 14, color: Colors.white),
                const Spacer(),
                Container(width: 50, height: 14, color: Colors.white),
                const SizedBox(width: 30),
                Container(
                  width: 70,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
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
          Icon(Icons.search_off_rounded, color: subtextColor, size: Dimens.size48),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.info_outline_rounded,
          color: subtextColor.withValues(alpha: 0.7),
          size: Dimens.size14,
        ),
        const SizedBox(width: Dimens.space6),
        CustomTextLabelWidget(
          label: 'Rankings are updated every 10 minutes.',
          style: TextStyle(
            fontSize: Dimens.fontSize10,
            fontWeight: FontWeight.w400,
            color: subtextColor.withValues(alpha: 0.7),
          ),
        ),
      ],
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
        ..drawLine(Offset(center.dx - 4, center.dy), Offset(center.dx + 4, center.dy), paint)
        ..drawLine(Offset(center.dx, center.dy - 4), Offset(center.dx, center.dy + 4), paint);
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
    canvas
      ..drawArc(rect, 0.85 * pi, 0.8 * pi, false, paint)
      ..drawArc(rect, -0.65 * pi, 0.8 * pi, false, paint);

    // Draw small leaves on left
    final Paint leafPaint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    // Angle markers for left leaves
    final List<double> leftAngles = <double>[1.0 * pi, 1.2 * pi, 1.4 * pi, 1.6 * pi];
    for (final double angle in leftAngles) {
      final double leafX = cx + r * cos(angle);
      final double leafY = cy + r * sin(angle);
      canvas.drawOval(
        Rect.fromCenter(center: Offset(leafX, leafY), width: 8, height: 4),
        leafPaint,
      );
    }

    // Angle markers for right leaves
    final List<double> rightAngles = <double>[0.0 * pi, -0.2 * pi, -0.4 * pi, -0.6 * pi];
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
