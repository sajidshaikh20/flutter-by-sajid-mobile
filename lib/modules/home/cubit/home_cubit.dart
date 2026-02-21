import '../../../utils/exports.dart';

/// UI-only HomeCubit. No repository, no API, no business logic.
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit({required this.countCubit}) : super(HomeState.initial());

  final CartCountCubit countCubit;

  void initData() {}

  void initializeSegmentIndex() {}

  void refreshHomeData() {}

  @override
  HomeState getResetErrorState() => state.copyWith(msg: '');

  @override
  HomeState getResetRedirectionState() => state.copyWith();
}
