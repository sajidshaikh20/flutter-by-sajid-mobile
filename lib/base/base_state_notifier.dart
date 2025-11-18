import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/exports.dart';

/// A base StateNotifier class that can be extended by other StateNotifiers.
///
/// This class provides a generic foundation for StateNotifiers with dynamic type support.
/// It extends [StateNotifier] and can be used with any state type.
///
/// Example:
/// ```dart
/// class MyStateNotifier extends BaseStateNotifier<MyState> {
///   MyStateNotifier() : super(MyState.initial());
///
///   Future<void> loadData() async {
///     setLoading();
///     try {
///       final data = await repository.getData();
///       setSuccess();
///       state = state.copyWith(data: data);
///     } catch (e) {
///       handleException(e, defaultMessage: 'Failed to load data');
///     }
///   }
/// }
/// ```
///
/// Type parameter:
/// - [T]: The type of state this notifier manages.
class BaseStateNotifier<T> extends StateNotifier<T> {
  /// Creates a new [BaseStateNotifier] instance.
  ///
  /// The [initialState] parameter is required and represents the initial state.
  BaseStateNotifier(super.initialState);

  /// Updates the state with a loading status if the state supports it.
  ///
  /// This method attempts to update the state's status to [BaseStateStatus.loading].
  /// It works with states that extend [BaseState] and have a `copyWith` method
  /// that accepts a `status` parameter.
  ///
  /// Override this method in your subclass if your state has a different structure.
  ///
  /// Example:
  /// ```dart
  /// setLoading(); // Sets state status to loading
  /// ```
  void setLoading() {
    _updateStatusIfSupported(BaseStateStatus.loading);
  }

  /// Updates the state with a success status if the state supports it.
  ///
  /// This method attempts to update the state's status to [BaseStateStatus.success].
  /// It works with states that extend [BaseState] and have a `copyWith` method
  /// that accepts a `status` parameter.
  ///
  /// [msg] Optional message to include in the state.
  ///
  /// Override this method in your subclass if your state has a different structure.
  ///
  /// Example:
  /// ```dart
  /// setSuccess(); // Sets state status to success
  /// setSuccess(msg: 'Data loaded successfully'); // Sets state with message
  /// ```
  void setSuccess({String? msg}) {
    _updateStatusIfSupported(BaseStateStatus.success, msg: msg);
  }

  /// Updates the state with a failure status if the state supports it.
  ///
  /// This method attempts to update the state's status to [BaseStateStatus.failure].
  /// It works with states that extend [BaseState] and have a `copyWith` method
  /// that accepts a `status` parameter.
  ///
  /// [msg] Error message to include in the state.
  ///
  /// Override this method in your subclass if your state has a different structure.
  ///
  /// Example:
  /// ```dart
  /// setFailure(msg: 'Failed to load data'); // Sets state with error message
  /// ```
  void setFailure({String? msg}) {
    _updateStatusIfSupported(BaseStateStatus.failure, msg: msg);
  }

  /// Updates the state with an initial status if the state supports it.
  ///
  /// This method attempts to update the state's status to [BaseStateStatus.initial].
  /// It works with states that extend [BaseState] and have a `copyWith` method
  /// that accepts a `status` parameter.
  ///
  /// Override this method in your subclass if your state has a different structure.
  ///
  /// Example:
  /// ```dart
  /// setInitial(); // Resets state to initial
  /// ```
  void setInitial() {
    _updateStatusIfSupported(BaseStateStatus.initial);
  }

  /// Handles an exception by updating the state with a failure status.
  ///
  /// This is a convenience method that catches exceptions and updates
  /// the state with an appropriate error message.
  ///
  /// [exception] The exception that occurred.
  /// [defaultMessage] Optional default message if exception message is empty.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   await someOperation();
  /// } catch (e) {
  ///   handleException(e, defaultMessage: 'Operation failed');
  /// }
  /// ```
  void handleException(
    Exception exception, {
    String? defaultMessage,
  }) {
    final String errorMessage = exception.toString().replaceFirst('Exception: ', '');
    setFailure(
      msg: errorMessage.isNotEmpty
          ? errorMessage
          : (defaultMessage ?? 'An error occurred'),
    );
  }

  /// Updates the state with a new value.
  ///
  /// This is a convenience method that directly updates the state.
  ///
  /// [newState] The new state value.
  ///
  /// Example:
  /// ```dart
  /// updateState(MyState(status: BaseStateStatus.success));
  /// ```
  // ignore: use_setters_to_change_properties
  void updateState(T newState) {
    state = newState;
  }

  /// Internal helper method to update status if the state supports it.
  ///
  /// This method uses dynamic invocation to call copyWith on states that
  /// extend BaseState and have a copyWith method.
  void _updateStatusIfSupported(
    BaseStateStatus status, {
    String? msg,
  }) {
    try {
      // Try to use dynamic invocation for states that extend BaseState
      // and have a copyWith method
      if (state is BaseState) {
        final dynamic currentState = state;
        // Use dynamic invocation to call copyWith
        // ignore: avoid_dynamic_calls
        final dynamic newState = currentState.copyWith(
          status: status,
          msg: msg,
        );
        state = newState as T;
      }
    } on Object {
      // If copyWith doesn't exist or fails, silently ignore
      // Subclasses can override these methods for custom behavior
    }
  }
}

