import '../utils/exports.dart';

/// A base Cubit class that provides common state-reset functionality
/// for managing redirection and error states.
///
/// This class is intended to be extended by specific Cubit implementations
/// that work with a [BaseState] subclass.
///
/// Subclasses must implement:
/// - [getResetRedirectionState] → returns a state with redirection cleared.
/// - [getResetErrorState] → returns a state with error cleared.
///
/// Example:
/// ```dart
/// class LoginCubit extends BaseCubit<LoginState> {
///   LoginCubit() : super(LoginState.initial());
///
///   @override
///   LoginState getResetRedirectionState() => state.copyWith(redirection: null);
///
///   @override
///   LoginState getResetErrorState() => state.copyWith(error: null);
/// }
/// ```
abstract class BaseCubit<T extends BaseState> extends Cubit<T> {
  /// Creates a [BaseCubit] with the provided initial state.
  BaseCubit(super.initialState);

  /// Returns a state where any redirection information has been reset.
  T getResetRedirectionState();

  /// Returns a state where any error information has been reset.
  T getResetErrorState();

  /// Emits a state with redirection cleared.
  void resetRedirection() {
    emit(getResetRedirectionState());
  }

  /// Emits a state with error cleared.
  void resetError() {
    emit(getResetErrorState());
  }
}
