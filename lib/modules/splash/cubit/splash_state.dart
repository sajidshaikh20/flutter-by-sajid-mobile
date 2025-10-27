import '../../../utils/exports.dart';

/// Immutable state for the splash screen.
class SplashState extends BaseState {
  /// Creates a [SplashState].
  const SplashState({
    required super.status,
    this.redirectPath = '',
    this.languageAlignment = AppConstant.defaultLanguageAlignment,
    this.languageCode = AppConstant.en,
    super.msg = '',
  });

  /// The next route path to navigate to after splash.
  final String redirectPath;
  /// Language alignment to apply before navigation.
  final String languageAlignment;
  /// Current language code derived during splash.
  final String languageCode;

  /// Returns a copy with updated fields.
  SplashState copyWith({
    BaseStateStatus? status,
    String? redirectPath,
    String? languageAlignment,
    String? languageCode,
    String? msg,
  }) {
    return SplashState(
      status: status ?? this.status,
      redirectPath: redirectPath ?? this.redirectPath,
      languageAlignment: languageAlignment ?? this.languageAlignment,
      languageCode: languageCode ?? this.languageCode,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object?> get props =>
      <Object?>[...super.props, languageAlignment, languageCode, msg];
}
