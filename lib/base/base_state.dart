import '../../../utils/exports.dart';

/// A base state class used by Cubits to manage common UI state properties.
///
/// This class extends [Equatable] to support efficient state comparisons,
/// helping to prevent unnecessary widget rebuilds.
///
/// The state contains:
/// - [status]: The current status of the state (loading, success, error, etc.).
/// - [redirectRoute]: An optional route to navigate to after an action completes.
/// - [msg]: An optional message, typically used for user feedback or error descriptions.
///
/// Example:
/// ```dart
/// class LoginState extends BaseState {
///   const LoginState({
///     required BaseStateStatus status,
///     PageRouteInfo? redirectRoute,
///     String? msg,
///   }) : super(status: status, redirectRoute: redirectRoute, msg: msg);
/// }
/// ```
class BaseState extends Equatable {
  /// Creates a new [BaseState] instance.
  ///
  /// The [status] parameter is required, while [redirectRoute] and [msg] are optional.
  const BaseState({
    required this.status,
    this.redirectRoute,
    this.msg,
  });

  /// The current state status (e.g., loading, success, failure).
  final BaseStateStatus status;

  /// Optional route to navigate to after a state change.
  final PageRouteInfo? redirectRoute;

  /// Optional message, typically used for feedback or error display.
  final String? msg;

  @override
  List<Object?> get props => <Object?>[
    status,
    redirectRoute,
    msg,
  ];
}
