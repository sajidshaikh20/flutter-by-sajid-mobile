import '../../../utils/exports.dart';

/// Cubit managing My Trades page state including search queries and category/status filtering.
class MyTradesCubit extends BaseCubit<MyTradesState> {
  MyTradesCubit() : super(MyTradesState.initial());

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
  MyTradesState getResetErrorState() => state.copyWith(msg: '');

  @override
  MyTradesState getResetRedirectionState() => state.copyWith();
}
