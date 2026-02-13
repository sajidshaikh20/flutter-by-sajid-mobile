import '../../../utils/exports.dart';

/// Cubit for the main screen (first screen after splash).
class MainCubit extends BaseCubit<MainState> {
  /// Creates a [MainCubit].
  MainCubit()
      : super(const MainState(
          status: BaseStateStatus.initial,
          model: MainScreenModel(
            title: 'Main',
            description: 'Welcome. First screen after splash.',
          ),
        ));

  @override
  MainState getResetRedirectionState() =>
      state.copyWith(clearRedirect: true);

  @override
  MainState getResetErrorState() => state.copyWith(clearMessage: true);

  /// Loads main screen data (basic example).
  Future<void> loadData() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(status: BaseStateStatus.success));
  }
}
