import '../../../utils/exports.dart';

/// UI-only HomeCubit. No repository, no API, no business logic.
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState.initial());



  void initData() {}

  void initializeSegmentIndex() {}

  void refreshHomeData() {}

  /// Toggles the visibility of the available balance.
  void toggleBalanceVisibility() {
    emit(state.copyWith(isBalanceVisible: !state.isBalanceVisible));
  }

  @override
  HomeState getResetErrorState() => state.copyWith(msg: '');

  @override
  HomeState getResetRedirectionState() => state.copyWith();
}
