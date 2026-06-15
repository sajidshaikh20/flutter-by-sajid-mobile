import '../../../utils/exports.dart';

@RoutePage()
class ResultPage extends BaseResponsiveView {
  const ResultPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<ResultCubit>(
      create: (BuildContext context) => ResultCubit(),
      child: const ResultViewBody(),
    );
  }
}

class ResultViewBody extends StatefulWidget {
  const ResultViewBody({super.key});

  @override
  State<ResultViewBody> createState() => _ResultViewBodyState();
}

class _ResultViewBodyState extends State<ResultViewBody> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBorder = isDark ? AppColors.borderDark : AppColors.borderLight;

    return BlocBuilder<ResultCubit, ResultState>(
      builder: (BuildContext context, ResultState state) {
        return Scaffold(
          backgroundColor: pageBg,
          body: SafeArea(
            child: RefreshIndicator(
              color: AppColors.primaryPurple,
              onRefresh: () => context.read<ResultCubit>().refreshResults(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Custom Header
                  _buildHeader(context, isDark, textColor, cardBorder),

                  // Content Area
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if (state.shimmerLoading)
                              _buildShimmerList(isDark)
                            else if (state.resultItems.isEmpty)
                              _buildEmptyState(textColor, subtextColor)
                            else
                              _buildResultsList(context, isDark, textColor, subtextColor, cardBorder, state.resultItems),
                            const SizedBox(height: Dimens.space24),
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

  Widget _buildHeader(BuildContext context, bool isDark, Color textColor, Color borderCol) {
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
                  Icons.analytics_outlined,
                  color: isDark ? AppColors.successColor : AppColors.primaryPurple,
                  size: Dimens.size24,
                ),
                const SizedBox(width: Dimens.space8),
                CustomTextLabelWidget(
                  label: 'Trade Results',
                  style: TextStyle(
                    fontSize: Dimens.fontSize20,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(
    BuildContext context,
    bool isDark,
    Color textColor,
    Color subtextColor,
    Color borderCol,
    List<TradeResultModel> items,
  ) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (BuildContext ctx, int idx) => const SizedBox(height: Dimens.space16),
      itemBuilder: (BuildContext ctx, int index) {
        final TradeResultModel item = items[index];
        final Color statusColor = item.isProfit ? AppColors.successColor : AppColors.errorColor;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(Dimens.radius16),
            border: Border.all(color: borderCol, width: 0.8),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top Details Header
              Padding(
                padding: const EdgeInsets.all(Dimens.space12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: item.pair,
                          style: TextStyle(
                            color: textColor,
                            fontSize: Dimens.fontSize16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        CustomTextLabelWidget(
                          label: item.timestamp,
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: Dimens.fontSize11,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(Dimens.radius8),
                        border: Border.all(color: statusColor.withValues(alpha: 0.3), width: 0.5),
                      ),
                      child: CustomTextLabelWidget(
                        label: '${item.amount} (${item.isProfit ? "+" : "-"}${item.pips} pips)',
                        style: TextStyle(
                          color: statusColor,
                          fontSize: Dimens.fontSize12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Image Thumbnail (clickable)
              GestureDetector(
                onTap: () => _openFullscreenImage(context, item),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.space12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.radius12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.radius12),
                    child: Stack(
                      children: <Widget>[
                        CommonImageWidget(
                          imagePath: item.imageUrl,
                          width: double.infinity,
                          height: 180,
                        ),
                        Positioned(
                          right: Dimens.space10,
                          bottom: Dimens.space10,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.fullscreen_rounded,
                              color: Colors.white,
                              size: Dimens.size20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Description area
              Padding(
                padding: const EdgeInsets.all(Dimens.space12),
                child: CustomTextLabelWidget(
                  label: item.description,
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.85),
                    fontSize: Dimens.fontSize12,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openFullscreenImage(BuildContext context, TradeResultModel item) {
    unawaited(showDialog<dynamic>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (BuildContext ctx) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              // Close Gesture Area
              GestureDetector(
                onTap: () => Navigator.pop(ctx),
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

              // Zoomable Image
              Center(
                child: Hero(
                  tag: item.id,
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimens.radius16),
                        child: CommonImageWidget(
                          imagePath: item.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Top details panel
              Positioned(
                top: 50,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: item.pair,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Dimens.fontSize18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomTextLabelWidget(
                          label: item.timestamp,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: Dimens.fontSize12,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white, size: Dimens.size28),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),

              // Info box at bottom
              Positioned(
                bottom: 40,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(Dimens.radius12),
                    border: Border.all(color: Colors.white24, width: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const CustomTextLabelWidget(
                            label: 'Trade Details',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: (item.isProfit ? AppColors.successColor : AppColors.errorColor).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: CustomTextLabelWidget(
                              label: '${item.amount} (${item.isProfit ? "+" : "-"}${item.pips} pips)',
                              style: TextStyle(
                                color: item.isProfit ? AppColors.successColor : AppColors.errorColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomTextLabelWidget(
                        label: item.description,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  Widget _buildShimmerList(bool isDark) {
    final Color baseCol = isDark ? const Color(0xFF1B162E) : Colors.grey.shade300;
    final Color highCol = isDark ? const Color(0xFF2E274C) : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseCol,
      highlightColor: highCol,
      child: Column(
        children: List<Widget>.generate(3, (int i) {
          return Container(
            height: 310,
            margin: const EdgeInsets.only(bottom: Dimens.space16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimens.radius16),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState(Color textColor, Color subtextColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.search_off_rounded, color: subtextColor, size: Dimens.size48),
          const SizedBox(height: Dimens.space12),
          CustomTextLabelWidget(
            label: 'No Results Available',
            style: TextStyle(
              color: textColor,
              fontSize: Dimens.fontSize16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Dimens.space4),
          CustomTextLabelWidget(
            label: 'Please check back later for trading updates.',
            style: TextStyle(
              color: subtextColor,
              fontSize: Dimens.fontSize12,
            ),
          ),
        ],
      ),
    );
  }
}
