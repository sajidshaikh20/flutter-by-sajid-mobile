import '../../../utils/exports.dart';
import 'language_selection_state.dart';


/// Cubit responsible for managing the state of the language selection screen.
class LanguageSelectionCubit extends Cubit<LanguageSelectionState> {
  /// Constructor for [LanguageSelectionCubit].
  ///

  /// Initializes the state and schedules a microtask to initialize the cubit.
  LanguageSelectionCubit() : super(LanguageSelectionState.initial()) {
    scheduleMicrotask(
          () async => _init(),
    );
  }



  /// Initializes the cubit by setting the initial language code.
  Future<void> _init() async {
    Locale locale=getLocale();
    emit(state.copyWith(languageCode: locale.languageCode, ));
  }





}
