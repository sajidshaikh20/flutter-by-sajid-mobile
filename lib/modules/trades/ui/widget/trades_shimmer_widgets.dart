import '../../../../utils/exports.dart';

/// Theme-aware shimmer colors for light and dark mode.
class TradesShimmerTheme {
  const TradesShimmerTheme({required this.isDark});

  final bool isDark;

  factory TradesShimmerTheme.of(BuildContext context) {
    return TradesShimmerTheme(isDark: context.isDark);
  }

  Color get baseColor =>
      isDark ? AppColors.shimmerBaseDarkColor : AppColors.shimmerBaseColor;

  Color get highlightColor =>
      isDark ? AppColors.shimmerHighlightDarkColor : AppColors.shimmerHighlightColor;

  Color get placeholderColor => AppColors.shimmerPlaceholderColor(isDark: isDark);
}

/// A box placeholder used inside shimmer layouts.
class TradesShimmerBox extends StatelessWidget {
  const TradesShimmerBox({
    super.key,
    required this.theme,
    required this.height,
    this.width,
    this.radius = Dimens.radius4,
  });

  final TradesShimmerTheme theme;
  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.placeholderColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// Shimmer placeholder matching [TradingSignalCard] layout.
class TradingSignalCardShimmerWidget extends StatelessWidget {
  const TradingSignalCardShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TradesShimmerTheme theme = TradesShimmerTheme.of(context);
    final Color borderColor =
        theme.isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);

    return ShimmerEffectWidget(
      isDark: theme.isDark,
      child: Container(
        decoration: BoxDecoration(
          color: theme.isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(Dimens.radius16),
          border: Border.all(color: borderColor),
        ),
        padding: const EdgeInsets.all(Dimens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                TradesShimmerBox(
                  theme: theme,
                  width: Dimens.size36,
                  height: Dimens.size36,
                  radius: Dimens.radius8,
                ),
                const SizedBox(width: Dimens.space10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          TradesShimmerBox(theme: theme, width: 88, height: 14),
                          const SizedBox(width: Dimens.space8),
                          TradesShimmerBox(
                            theme: theme,
                            width: 52,
                            height: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.space6),
                      TradesShimmerBox(theme: theme, width: 120, height: 10),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.space16),
            TradesShimmerBox(theme: theme, width: double.infinity, height: 1),
            const SizedBox(height: Dimens.space16),
            Row(
              children: <Widget>[
                Expanded(child: _ShimmerValueColumn(theme: theme, align: CrossAxisAlignment.start)),
                Expanded(child: _ShimmerValueColumn(theme: theme, align: CrossAxisAlignment.center)),
                Expanded(child: _ShimmerValueColumn(theme: theme, align: CrossAxisAlignment.end)),
              ],
            ),
            const SizedBox(height: Dimens.space16),
            Row(
              children: <Widget>[
                TradesShimmerBox(theme: theme, width: 72, height: 10),
                const Spacer(),
                TradesShimmerBox(theme: theme, width: 56, height: 10),
              ],
            ),
            const SizedBox(height: Dimens.space12),
            TradesShimmerBox(
              theme: theme,
              width: double.infinity,
              height: 6,
            ),
            const SizedBox(height: Dimens.space12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TradesShimmerBox(theme: theme, width: 64, height: 28, radius: Dimens.radius20),
                TradesShimmerBox(theme: theme, width: 80, height: 28, radius: Dimens.radius20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerValueColumn extends StatelessWidget {
  const _ShimmerValueColumn({
    required this.theme,
    required this.align,
  });

  final TradesShimmerTheme theme;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        TradesShimmerBox(theme: theme, width: 48, height: 9),
        const SizedBox(height: Dimens.space6),
        TradesShimmerBox(theme: theme, width: 64, height: 13),
      ],
    );
  }
}

/// Shimmer for the four summary metric cards.
class TradesSummaryCardsShimmerWidget extends StatelessWidget {
  const TradesSummaryCardsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TradesShimmerTheme theme = TradesShimmerTheme.of(context);

    return ShimmerEffectWidget(
      isDark: theme.isDark,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
        child: Row(
          children: List<Widget>.generate(4, (int index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : Dimens.space4),
                child: Container(
                  padding: const EdgeInsets.all(Dimens.space8),
                  decoration: BoxDecoration(
                    color: theme.isDark ? AppColors.cardDark : AppColors.cardLight,
                    borderRadius: BorderRadius.circular(Dimens.radius12),
                    border: Border.all(
                      color: theme.isDark
                          ? AppColors.borderDark
                          : AppColors.borderLight.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      TradesShimmerBox(
                        theme: theme,
                        width: Dimens.size28,
                        height: Dimens.size28,
                        radius: Dimens.radius20,
                      ),
                      const SizedBox(width: Dimens.space8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TradesShimmerBox(theme: theme, width: 24, height: 14),
                            const SizedBox(height: Dimens.space4),
                            TradesShimmerBox(theme: theme, width: 36, height: 9),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Shimmer for search bar and filter pills — full trades page loading state.
class TradesPageShimmerWidget extends StatelessWidget {
  const TradesPageShimmerWidget({
    super.key,
    this.cardCount = 4,
  });

  final int cardCount;

  @override
  Widget build(BuildContext context) {
    final TradesShimmerTheme theme = TradesShimmerTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ShimmerEffectWidget(
          isDark: theme.isDark,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.space16,
              vertical: Dimens.space8,
            ),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: theme.isDark ? AppColors.cardDark : AppColors.cardLight,
                borderRadius: BorderRadius.circular(Dimens.radius12),
                border: Border.all(
                  color: theme.isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight.withValues(alpha: 0.5),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
              child: Row(
                children: <Widget>[
                  TradesShimmerBox(theme: theme, width: Dimens.size20, height: Dimens.size20),
                  const SizedBox(width: Dimens.space10),
                  TradesShimmerBox(theme: theme, width: 140, height: 12),
                ],
              ),
            ),
          ),
        ),
        // const Padding(
        //   padding: EdgeInsets.symmetric(vertical: Dimens.space8),
        //   child: TradesSummaryCardsShimmerWidget(),
        // ),
        ShimmerEffectWidget(
          isDark: theme.isDark,
          child: SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
              children: List<Widget>.generate(5, (int index) {
                return Padding(
                  padding: EdgeInsets.only(right: index == 4 ? 0 : Dimens.space8),
                  child: TradesShimmerBox(
                    theme: theme,
                    width: index == 0 ? 48 : 72,
                    height: 36,
                    radius: Dimens.radius20,
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: Dimens.space12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
          child: Column(
            children: List<Widget>.generate(cardCount, (int index) {
              return Padding(
                padding: EdgeInsets.only(bottom: index == cardCount - 1 ? 0 : Dimens.space12),
                child: const TradingSignalCardShimmerWidget(),
              );
            }),
          ),
        ),
      ],
    );
  }
}
