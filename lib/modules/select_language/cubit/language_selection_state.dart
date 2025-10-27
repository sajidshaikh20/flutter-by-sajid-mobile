import '../../../utils/exports.dart';

/// Immutable state for the language selection screen.
class LanguageSelectionState extends BaseState {
  /// Creates a new instance of [LanguageSelectionState].
  const LanguageSelectionState({


    required super.status,
    super.msg = '',
    super.redirectRoute,
    this.languageAlignment=AppConstant.defaultLanguageAlignment,
    this.languageCode=AppConstant.en,
    this.listOfLanguage=AppConstant.listOfLanguage,
  });


  /// Current text alignment for the selected language (e.g., ltr or rtl).
  final String languageAlignment;
  /// Current language code (e.g., 'en', 'ar').
  final String languageCode;
  /// Supported languages list used to populate the UI.
  final List<String> listOfLanguage;


  @override
  List<Object?> get props => <Object?>[

    languageAlignment,
    languageCode,
        ...super.props,
    listOfLanguage
      ];


  /// Returns a copy of the state with updated fields.
  LanguageSelectionState copyWith({
     BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    String? languageAlignment,
    String? languageCode,
    List<String>? listOfLanguage
  }) {
    return LanguageSelectionState(
      status: status ?? this.status,
      redirectRoute: redirectRoute,
      msg: msg,
        languageAlignment: languageAlignment ?? this.languageAlignment,
        languageCode: languageCode ?? this.languageCode,
        listOfLanguage: listOfLanguage ?? this.listOfLanguage,
    );
  }
  /// Factory method for the initial/default state.
  factory LanguageSelectionState.initial() {
    return const LanguageSelectionState(
      status: BaseStateStatus.initial,
    );
  }
}
