import '../../../utils/exports.dart';

/// Cubit managing Trades page state including search queries and category/status filtering.
class TradesCubit extends BaseCubit<TradesState> {
  TradesCubit() : super(TradesState.initial());

  /// Updates the currently selected filter.
  void selectFilter(SignalFilter filter) {
    emit(state.copyWith(selectedFilter: filter));
  }

  /// Updates the search query text.
  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  /// Clears the current search query.
  void clearSearch() {
    emit(state.copyWith(searchQuery: ''));
  }

  @override
  TradesState getResetErrorState() => state.copyWith(msg: '');

  @override
  TradesState getResetRedirectionState() => state.copyWith();
}
