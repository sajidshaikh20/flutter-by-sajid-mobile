import '../../../utils/exports.dart';

/// UI-only HomeCategoryCubit. No repository, no API.
class HomeCategoryCubit extends Cubit<HomeCategoryState> {
  HomeCategoryCubit() : super(HomeCategoryState()) {
    _initializeScrollListener();
  }

  void _initializeScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (state.scrollController.position.pixels >=
        state.scrollController.position.maxScrollExtent - 200) {
      if (state.hasMore && !state.isLoadingMore) {
        unawaited(loadMoreCategories());
      }
    }
  }

  /// UI only: emit success with empty list.
  Future<void> callHomeCategory({int? limit, int? offset}) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(
      status: BaseStateStatus.success,
      categoryList: <dynamic>[],
      totalCount: 0,
      hasMore: false,
      isLoadingMore: false,
    ));
  }

  Future<void> loadMoreCategories() async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    await Future<void>.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(isLoadingMore: false));
  }

  Future<void> refreshCategories() async {
    await callHomeCategory(offset: 0);
  }

  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }
}
