import '../../../utils/exports.dart';

/// UI-only HomeCubit. No repository, no API, no business logic.
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void initData() {}

  void initializeSegmentIndex() {}

  void refreshHomeData() {}

  /// Selects the given All Services tab.
  void selectServiceTab(ServiceCategoryTab tab) {
    emit(state.copyWith(selectedServiceTab: tab));

  }

  /// Toggles the visibility of the available balance.
  void toggleBalanceVisibility() {
    emit(state.copyWith(isBalanceVisible: !state.isBalanceVisible));
  }

  /// Toggles the visibility of the Postpaid wallet balance.
  void togglePostpaidVisibility() {
    emit(state.copyWith(isPostpaidVisible: !state.isPostpaidVisible));
  }

  @override
  HomeState getResetErrorState() => state.copyWith(msg: '');

  @override
  HomeState getResetRedirectionState() => state.copyWith();
}
