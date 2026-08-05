import '../../../../../utils/exports.dart';

class LivePriceCard extends StatelessWidget {
  const LivePriceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    final AddTradeCubit cubit = context.read<AddTradeCubit>();

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      buildWhen: (AddTradeState prev, AddTradeState curr) =>
          prev.selectedPair != curr.selectedPair ||
          prev.selectedMarket != curr.selectedMarket ||
          prev.liveSocketPrice != curr.liveSocketPrice,
      builder: (BuildContext context, AddTradeState state) {
        if (state.selectedPair == null) {
          return const SizedBox.shrink();
        }

        final String livePriceStr = cubit.getLivePrice() > 0
            ? cubit.getLivePrice().toStringAsFixed(cubit.getPricePrecision())
            : '--';

        return Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF092019) : const Color(0xFFE8F8F1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.successColor.withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.successColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'LIVE MARKET PRICE',
                            style: TextStyle(
                              color: AppColors.successColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.black38 : Colors.black12,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          AddTradeUiHelpers.getPriceSource(state.selectedMarket),
                          style: const TextStyle(
                            color: AppColors.errorColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        state.selectedPair?.symbol ?? 'SYMB',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        livePriceStr,
                        style: const TextStyle(
                          color: AppColors.successColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],
        );
      },
    );
  }
}
