import '../../../../utils/exports.dart';

/// Reusable stock row tile used in watchlist list.
class WatchlistStockTileWidget extends StatelessWidget {
  const WatchlistStockTileWidget({
    required this.stock,
    required this.index,
    super.key,
  });

  final WatchlistStockModel stock;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isPositive = stock.changePercentage >= Dimens.zero;
    final Color changeColor = isPositive
        ? MainConfig.appColors.greenColor
        : MainConfig.appColors.redColor;
    final String signedPercentage =
        '${isPositive ? '+' : ''}${stock.changePercentage.toStringAsFixed(2)}%';

    return Card(
      margin: const EdgeInsets.only(bottom: Dimens.space12),
      elevation: Dimens.elevation0,
      shape: RoundedRectangleBorder(
        borderRadius: Dimens.radius10.borderRadius,
        side: Dimens.borderWidth1.borderSide(
          color: MainConfig.appColors.borderLightGreyColor,
        ),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.space12,
          vertical: Dimens.space4,
        ),
        leading: ReorderableDragStartListener(
          index: index,
          child: Icon(
            Icons.drag_handle_rounded,
            color: MainConfig.appColors.greyTextColor,
            size: Dimens.size22,
          ),
        ),
        title: Text(
          stock.name,
          maxLines: Dimens.maxLines01,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: Dimens.fontSize16,
            fontWeight: FontWeight.w600,
            color: MainConfig.appColors.textColorGreyBlack,
          ),
        ),
        subtitle: Text(
          stock.id,
          maxLines: Dimens.maxLines01,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: Dimens.fontSize12,
            color: MainConfig.appColors.greyTextColor,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '\$${stock.price.toStringAsFixed(2)}',
              style: context.textTheme.titleSmall?.copyWith(
                fontSize: Dimens.fontSize15,
                fontWeight: FontWeight.w700,
                color: MainConfig.appColors.textColorGreyBlack,
              ),
            ),
            Dimens.size4.heightBox,
            Text(
              signedPercentage,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w600,
                color: changeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
