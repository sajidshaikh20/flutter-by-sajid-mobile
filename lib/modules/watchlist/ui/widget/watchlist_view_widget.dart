import '../../../../utils/exports.dart';

/// Main watchlist content with drag and drop ordering.
class WatchlistViewWidget extends StatelessWidget {
  const WatchlistViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistCubit, WatchlistState>(
      buildWhen: (WatchlistState previous, WatchlistState current) =>
          previous.stocks != current.stocks ||
          previous.status != current.status,
      builder: (BuildContext context, WatchlistState state) {
        if (state.stocks.isEmpty) {
          return Center(
            child: Text(
              'No stocks available',
              style: context.textTheme.bodyMedium?.copyWith(
                color: MainConfig.appColors.greyTextColor,
              ),
            ),
          );
        }

        return ReorderableListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.space16,
            vertical: Dimens.space12,
          ),
          itemCount: state.stocks.length,
          onReorder: context.read<WatchlistCubit>().onStocksReordered,
          proxyDecorator:
              (Widget child, int index, Animation<double> animation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? childWidget) {
                final double t = Curves.easeOut.transform(animation.value);
                return Material(
                  color: Colors.transparent,
                  elevation: Dimens.elevation4 * t,
                  child: childWidget,
                );
              },
              child: child,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            final WatchlistStockModel stock = state.stocks[index];
            return WatchlistStockTileWidget(
              key: ValueKey<String>(stock.id),
              stock: stock,
              index: index,
            );
          },
        );
      },
    );
  }
}
