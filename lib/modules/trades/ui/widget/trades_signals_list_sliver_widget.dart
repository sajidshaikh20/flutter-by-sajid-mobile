import '../../../../utils/exports.dart';

/// Paginated list of trade signal cards inside a [CustomScrollView].
class TradesSignalsListSliverWidget extends StatelessWidget {
  const TradesSignalsListSliverWidget({
    super.key,
    required this.signals,
    required this.showLoadMore,
    this.showTakeTrade = true,
  });

  final List<TradingSignalModel> signals;
  final bool showLoadMore;
  final bool showTakeTrade;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space16,
        vertical: Dimens.space12,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (index == signals.length) {
              return const Padding(
                padding: EdgeInsets.only(bottom: Dimens.space12),
                child: TradingSignalCardShimmerWidget(),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: Dimens.space12),
              child: TradingSignalCard(
                signal: signals[index],
                showTakeTrade: showTakeTrade,
              ),
            );
          },
          childCount: signals.length + (showLoadMore ? 1 : 0),
        ),
      ),
    );
  }
}
