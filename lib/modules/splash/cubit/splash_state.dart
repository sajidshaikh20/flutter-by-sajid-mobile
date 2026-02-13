import '../../../utils/exports.dart';

/// State for the splash screen.
class SplashState extends Equatable {
  /// Creates a [SplashState].
  const SplashState({this.redirectPath = ''});

  /// Route path to navigate to after splash (e.g. AppPaths.main).
  final String redirectPath;

  /// Returns a copy with updated fields.
  SplashState copyWith({String? redirectPath}) {
    return SplashState(
      redirectPath: redirectPath ?? this.redirectPath,
    );
  }

  @override
  List<Object?> get props => <Object?>[redirectPath];
}
