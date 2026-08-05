import '../../../../../utils/exports.dart';

class PairSelectionSheet extends StatelessWidget {
  final AddTradeCubit cubit;

  const PairSelectionSheet({
    super.key,
    required this.cubit,
  });

  static Future<void> show(BuildContext context, AddTradeCubit cubit, AddTradeState state) async {
    cubit.updatePairSearchQuery('');
    state.pairSearchController.clear();

    final bool isDark = context.isDark;
    final Color sheetBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;

    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: sheetBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext ctx) {
        return BlocProvider<AddTradeCubit>.value(
          value: cubit,
          child: PairSelectionSheet(cubit: cubit),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      builder: (BuildContext context, AddTradeState state) {
        final List<CurrencyPairResponse> filtered = state.currencyPairs.where((CurrencyPairResponse p) {
          final String cleanQuery = state.pairSearchQuery.trim().toLowerCase();
          if (cleanQuery.isEmpty) return true;
          return p.symbol.toLowerCase().contains(cleanQuery) ||
                 p.baseCurrency.toLowerCase().contains(cleanQuery) ||
                 p.quoteCurrency.toLowerCase().contains(cleanQuery);
        }).toList();

        final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final double screenHeight = MediaQuery.of(context).size.height;
        final double maxHeight = keyboardHeight > 0 
            ? (screenHeight - keyboardHeight) 
            : (screenHeight * 0.75);

        return Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Container(
            height: maxHeight > 0 ? maxHeight : 100.0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 38,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2C3240) : Colors.black12,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Select Currency Pair',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close_rounded, color: subtextColor, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <String>['CRYPTO', 'FOREX', 'COMMODITY', 'STOCK']
                        .map((String m) {
                      final bool isSelected = state.selectedMarket == m;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            cubit.updateMarket(m);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryPurple
                                  : (isDark
                                      ? const Color(0xFF1E2430)
                                      : AppColors.whiteSmokeShade),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryPurple
                                    : (isDark ? const Color(0xFF2C3240) : Colors.transparent),
                              ),
                            ),
                            child: Text(
                              m,
                              style: TextStyle(
                                color: isSelected ? Colors.white : textColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 12),

                DecoratedBox(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E2430) : const Color(0xFFF2F4F7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: state.pairSearchQuery.isNotEmpty
                          ? AppColors.primaryPurple
                          : (isDark ? const Color(0xFF2C3240) : Colors.transparent),
                      width: 1.2,
                    ),
                  ),
                  child: TextField(
                    controller: state.pairSearchController,
                    onChanged: cubit.updatePairSearchQuery,
                    style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      hintText: 'Search BTCUSD, EURUSD, XAUUSD...',
                      hintStyle: TextStyle(
                        color: subtextColor.withValues(alpha: 0.65),
                        fontSize: 12,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 20,
                        color: state.pairSearchQuery.isNotEmpty ? AppColors.primaryPurple : subtextColor,
                      ),
                      suffixIcon: state.pairSearchQuery.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                state.pairSearchController.clear();
                                cubit.updatePairSearchQuery('');
                              },
                              child: Icon(Icons.cancel_rounded, size: 18, color: subtextColor),
                            )
                          : null,
                      filled: false,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      state.pairSearchQuery.trim().isNotEmpty
                          ? 'Found ${filtered.length} results'
                          : '${filtered.length} pairs available',
                      style: TextStyle(
                        color: state.pairSearchQuery.trim().isNotEmpty ? AppColors.primaryPurple : subtextColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state.selectedMarket,
                      style: TextStyle(color: subtextColor.withValues(alpha: 0.6), fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Expanded(
                  child: state.isLoadingPairs
                      ? const Center(child: CircularProgressIndicator())
                      : filtered.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.search_off_rounded,
                                      size: 44,
                                      color: subtextColor.withValues(alpha: 0.4),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'No pairs found for "${state.pairSearchQuery}"',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Try searching for another pair symbol or select a different market tab.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: subtextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: filtered.length,
                              padding: const EdgeInsets.only(top: 4, bottom: 12),
                              itemBuilder: (BuildContext context, int index) {
                                final CurrencyPairResponse pair = filtered[index];
                                final bool isSelected = state.selectedPair?.id == pair.id;
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primaryPurple.withValues(alpha: 0.12)
                                        : (isDark ? AppColors.cardDark : AppColors.whiteSmokeShade),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryPurple
                                          : (isDark ? const Color(0xFF2C3240) : Colors.transparent),
                                      width: isSelected ? 1.5 : 1.0,
                                    ),
                                  ),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                    title: Text(
                                      pair.symbol,
                                      style: TextStyle(
                                        color: isSelected ? AppColors.primaryPurple : textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    trailing: isSelected
                                        ? const Icon(
                                            Icons.check_circle_rounded,
                                            color: AppColors.primaryPurple,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.chevron_right_rounded,
                                            color: subtextColor.withValues(alpha: 0.5),
                                            size: 20,
                                          ),
                                    onTap: () {
                                      cubit.updateSelectedPair(pair);
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
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
