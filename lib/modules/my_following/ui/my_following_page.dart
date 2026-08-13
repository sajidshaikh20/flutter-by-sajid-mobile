import '../../../utils/exports.dart';
import 'widget/my_following_scroll_content.dart';

@RoutePage()
class MyFollowingPage extends StatelessWidget {
  const MyFollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyFollowingCubit>(
      create: (BuildContext context) => MyFollowingCubit(
        repository: MyFollowingRepositoryImpl(),
      ),
      child: const MyFollowingViewBody(),
    );
  }
}

class MyFollowingViewBody extends StatelessWidget {
  const MyFollowingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: BlocConsumer<MyFollowingCubit, MyFollowingState>(
          listener: (BuildContext context, MyFollowingState state) {
            if (state.status == BaseStateStatus.failure && (state.msg?.isNotEmpty ?? false)) {
              context.scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(state.msg ?? ''),
                  backgroundColor: AppColors.errorColor,
                ),
              );
              context.read<MyFollowingCubit>().resetError();
            }
          },
          builder: (BuildContext context, MyFollowingState state) {
            final MyFollowingCubit cubit = context.read<MyFollowingCubit>();

            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space8, vertical: Dimens.space8),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: textColor,
                          size: Dimens.size20,
                        ),
                        onPressed: () => context.router.back(),
                      ),
                      const SizedBox(width: Dimens.space4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomTextLabelWidget(
                              label: 'My Following',
                              style: TextStyle(
                                color: textColor,
                                fontSize: Dimens.fontSize18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            CustomTextLabelWidget(
                              label: 'Track your wishlisted and followed trades',
                              style: TextStyle(
                                color: subtextColor,
                                fontSize: Dimens.fontSize11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: MyFollowingScrollContentWidget(
                    isInitialLoading: state.isInitialLoading,
                    showEmptyState: state.showEmptyState,
                    showLoadMore: state.showLoadMoreIndicator,
                    filteredSignals: state.filteredSignals,
                    searchQuery: state.searchQuery,
                    selectedFilter: state.selectedFilter,
                    onSearchChanged: cubit.updateSearchQuery,
                    onSearchClear: cubit.clearSearch,
                    onFilterSelected: cubit.selectFilter,
                    onLoadMore: () => unawaited(cubit.loadMore()),
                    onRefresh: () => cubit.fetchWishlist(isRefresh: true),
                    onDatePickerTapped: () => _selectDateRange(context, cubit, state),
                    onDatePickerClear: () => cubit.updateDateRange(null, null),
                    hasActiveDateRange: state.fromDate != null && state.toDate != null,
                  ),
                ),
              ],
            );
          },
        ),
      ),
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

  Future<void> _selectDateRange(BuildContext context, MyFollowingCubit cubit, MyFollowingState state) async {
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
}
