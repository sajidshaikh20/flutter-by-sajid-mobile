import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../../../../app/core/widgets/date_range_picker_modal.dart';
import '../../../../utils/exports.dart';

/// Main subscribed content for Trading Signals — state comes from [TradesCubit].
class TradesContentWidget extends StatelessWidget {
  const TradesContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color pageBg =
        context.isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return BlocConsumer<TradesCubit, TradesState>(
      listener: TradesContentWidget._onStateChanged,
      builder: (BuildContext context, TradesState state) {
        final TradesCubit cubit = context.read<TradesCubit>();
        final String role = UserProfileService.instance().roleName;
        final bool canAddTrade = role == 'TRADER' || role == 'ADMIN';

        return Scaffold(
          backgroundColor: pageBg,
          floatingActionButton: canAddTrade
              ? FloatingActionButton(
                  onPressed: () async {
                    await context.router.push(const AddTradeRoute());
                  },
                  backgroundColor: AppColors.primaryPurple,
                  child: const Icon(Icons.add, color: AppColors.whiteColor),
                )
              : null,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const HomeHeaderAppBar(
                  showProfileImage: false,
                  showNotification: false,

                  title: 'Trading Signals',
                  subtitle: 'Explore high-quality trades from professional traders',
                ),
                Expanded(
                  child: TradesTabScrollContentWidget(
                    isInitialLoading: state.isInitialLoading,
                    showEmptyState: state.showEmptyState,
                    showLoadMore: state.showLoadMoreIndicator,
                    filteredSignals: state.filteredSignals,
                    searchQuery: state.searchQuery,
                    activeCount: state.activeCount.toString(),
                    pendingCount: state.pendingCount.toString(),
                    closedCount: state.closedCount.toString(),
                    lossesCount: state.lossesCount.toString(),
                    selectedFilters: state.selectedFilters,
                    onSearchChanged: cubit.updateSearchQuery,
                    onSearchClear: cubit.clearSearch,
                    onFilterSelected: cubit.selectFilter,
                    onLoadMore: () => unawaited(cubit.loadMore()),
                    onRefresh: () => cubit.loadTrades(isRefresh: true),
                    onDatePickerTapped: () => _selectDateRange(context, cubit, state),
                    onDatePickerClear: () => cubit.updateDateRange(null, null),
                    hasActiveDateRange: state.fromDate != null && state.toDate != null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PickerDateRange? _getDateRangeFromState(String? fromDate, String? toDate) {
    if (fromDate == null || toDate == null) return null;
    try {
      return PickerDateRange(DateTime.parse(fromDate), DateTime.parse(toDate));
    } on Object catch (_) {
      return null;
    }
  }

  Future<void> _selectDateRange(BuildContext context, TradesCubit cubit, TradesState state) async {
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

  static void _onStateChanged(BuildContext context, TradesState state) {
    if (state.msg == null || state.msg!.isEmpty) return;

    if (state.status == BaseStateStatus.success) {
      context.scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(state.msg!),
          backgroundColor: AppColors.successColor,
        ),
      );
    } else if (state.status == BaseStateStatus.failure) {
      context.scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(state.msg!),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }

    context.read<TradesCubit>().resetError();
  }
}
